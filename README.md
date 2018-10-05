Walter
====

A BMW I/K-BUS ~~interface~~ _tool thingy_ written in Ruby.

### Description

The project was started as a means add support for streaming music, and handsfree calls over Bluetooth. A RaspberryPi as a Bluetooth endpoint with support for the necessary Bluetooth profiles, with middleware to emulating IBUS music and telephony devices in the hope of having as native/smooth integration as possible.

Yes, you can retrofit OEM Bluetooth/AUX and so on, but for some reason I like the pain. Well, perhaps being indoctrinated into German electronics will make the drivetrain swap easier?

Made with a combination of enthusiasm and apparent self loathing in Melbourne, Australia.

### Features

I'm still in the throws of tinkering with the bus, and software currently reflects that and is more of a personal toolkit for said tinkering. However the objectives are:


- language agnostic bus interface (i.e. JSON payloads via pipes/RabbitMQ etc)
- as many of the commands mapped as possible to facilitate a variety of integrations beyond my initial goal music/telephony, or simple observation of the bus, akin to [NavCoder](http://www.navcoder.com/).
- diagnostic (INPA) commands mapped to allow additional features like showing module coding data, vehicle control, or parking sensor data which is only available via diagnostics.
- comprehensive API to allow use of the mapped commands.
- high level API to abstract the occasionally obscure behaviour (I'm looking at _you_ IKE character display...)

### Progress

As mentioned above, it's current state is a reflection of my needs while I'm exploring the bus rather than being a useful library. Until the software is more.. definitive in it's functionality it can be found on [develop](https://github.com/piersholt/walter/tree/develop).

- the most common commands have be mapped, but I'm still figuring out a number of obscure flags in the bit arrays.
- I have captured most of the diagnostic commands that are relayed over the I/K BUS, but haven't mapped them as yet.
- there is a number of rudimentary APIs to allow writing a subset of commands to the bus. There is no hardware flow control or carrier sensing, merely collision detection and arbitrary retry attempts.
- bus data is logged to allow 'replaying' the traffic.

### Notes

- Developed using Rolf Resler's v6b USB [interface](http://www.reslers.de/IBUS/index.html). I
- While Rolf has implemented hardware flow control signals, the Silicon Labs CP2102 USB UART Bridge does not appear to support signals under OS X (or at least under 10.10.5, with SiLabs 4.x drivers). The signals appear a-okay under Windows.
- The vehicles used in development were a 1997 BMW E39 528i Touring, and 2001 BMW E39 540i, both with High IKE.
- The 528i (to which I have best access) has water damaged amplifier and nav. computer so related commands are a little vague/possibly utterly wrong.
- I'll fill in the gaps with the 540i when I can.

![Exposing Walter](screenshot.jpg)
_P.S. Telephone numbers in screen shot aren't mine_ 😊
