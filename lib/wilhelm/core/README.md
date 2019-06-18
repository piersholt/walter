`wilhelm-core`

- with respect to the OSI model, this is layer 1, and layer 2.
- it is universal, providing a simple IO interface to allow is to be repurposed
- clients can simply listen for changes in order to receive frames.

- the lower layer will read bytes from the specified stream, and populate a byte input buffer.
- the higher layer will read from the byte input buffer.
- it will begin by synchronising with the byte stream, byte shifting, until a frame is valid.
- once the stream is synchronised, it will read the frame header (2 bytes), and frame header (5 - 252 bytes)
- if syncronisationis lost, the receiver will return to byte shifting.

Subsections
- scope: it's important to distingguish between frame and packet, as the scope of the one byte
command ID, is not universal. I did not realise this until I had already invested (read: wasted)
a great deal of time writing meta command classes.

- protocols: wilhelm focuses on the I/K BUS, but I have done some preliminary work on the P-BUS,
and FBVZ, the latter being in it's infancy.
