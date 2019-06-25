### `wilhelm-core`
- roughly encapsulates the equivalent of OSI layer 1 (physical) and 2 (data link)
- public interface for receiving and transmitting data
- abstracts both the transmission medium, and framing, allowing arbitrary payloads to be sent and received
- support for serial devices e.g. `/dev/cu.SLAB_USBtoUART`, and log files e.g. `log/bin/2019-06-01.bin`
---
### Architecture

#### OSI Layer 1 (Physical)
- the interface encapsulates any behaviour specific to the endpoint type
- an endpoint of type `characterSpecial` will have an interface class of `IO::TTY::UART`
- an endpoint of type `file` will have an interface class of `IO::File::Log`
- as subclasses of IO, the interface is otherwise the same as any IO object
- the interfaces maintain their own buffers (a little redundant, but originally as to have greater visibility of the buffered data, and to add additional behaviour)

#### OSI Layer 2 (Data Link)
- this is roughly modelled on the Media Access Control (MAC) and Logical Link Control (LLC), although the latter is somewhat transparent
- receiving is discussed below, but is essentially the inverse when transmitting
##### MAC
- the receiver will byte shift the stream until it is synchronised (denoted by a error free frame)
- once synchronisation is achieved, the receiver shifts the stream in blocks
- if synchronisation is lost, the receiver resumes byte shifting until it is resynchronised
##### LLC
- an error free frame is pushed up to the demultiplexer, which essentially just strips the layer specific bytes (length, checksum), and wraps the encapsulated payload in a simple data structure for clients.


### Logs
- when a serial interface is used, the byte stream is captured and written to a log file.
- logs are under `log/bin/`
- logs will rollover each day, e.g. `2019-06-01.bin`, `2019-06-02.bin`
- logs and serial devices are interchangeable as the endpoint
- if the specified endpoint is a file, any operations applicable to serial devices are disabled, such as writing and logging.
- there is no special format for logs, they're simply a duplicate of the byte stream, and as such any other files of this type can theoretically also be used as an endpoint

### Flow Control
- a `UART` interface will try to enable hardware flow control (as is supported by the CP2102 USB to UART Bridge, and enabled in Resler's USB interface)
- under OS X 10.10 the CP2102 has seemingly no support for hardware flow control, with signals being unavailable. However, signals are available under Windows, so this is presumably just a driver issue, and hopefully isn't present under Linux.
- as a fallback, the transmitter will compare the value returned by `IO.write` (the number of bytes written) to the length of the string to be transmitted. In the event of a collision, whereby the values do not match, the transmitter will back off for an arbitrary interval, and retry three times. (Ham fisted, but thus far, quite successful.)
