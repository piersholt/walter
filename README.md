# Walter [![License: GPL-3.0-only](https://img.shields.io/github/license/piersholt/walter.svg)](https://www.gnu.org/licenses/gpl-3.0)

Walter is a proof of concept SDK for BMWs utilising I/K-BUS. It includes resources for developing and deploying software plugins, a high level API (audio, communications etc), and lower level module APIs (radio, onboard-monitor interface etc).

This _is not_, and _should not_ be considered a library (hence the absence of a published gem), nor a how to guide. Although, I plan to continue developing the underlying library- albeit, to suit my needs, and general philosophy.

---


## Background

Walter began as a means to add support for Bluetooth audio (A2DP/AVRCP) with native display, and control via the on-board monitor (BMBT), and multi-function steering wheel controls (MFL) to my [BMW E39 5 series](https://en.wikipedia.org/wiki/BMW_5_Series_(E39). In my case, a 1997 528i Touring, optioned with navigation, HiFi, and telephone (i.e. High IKE, with both I and K buses).

There are a number of products available that fulfil this need, but each had compromises, and I was curious to what functionality could be developed via the I/K bus.

Like the Intravee, and a number of other projects, I planned to replace the CD changer, and emulate it's behaviour as to retain the native interface and controls. This began in earnest, and would come to work well for the best part. However, the solution also required a number of compromises that left me a little dissatisfied, the root of which was maintaining support for the factory audio and communication system.

Given the increasing- if not complete obsolescence, of said systems, I decided to remove the legacy modules entirely, and write an API that would allow me to retain and repurpose the existing human interfaces while adding my own functionality. I also stripped the redundant wiring from the vehicle wiring harness, so there was no turning back.

## Features


-

## The Necessaries

### Hardware

- **Raspberry Pi** 3 Model B
- [Resler USB Interface](http://www.reslers.de/IBUS)
- Bluetooth v4.0 USB module (CSR8510)
- [3.5mm stereo pigtail](https://core-electronics.com.au/right-angle-3-5mm-stereo-plug-to-pigtail-cable.html)
- Auto power on circuit: opto-isolator, resistor


### Software

- **Raspbian**: Stretch running headless for a rather swift boot
- **Bluez (version 5)**: the Linux Bluetooth stack
- [Wolfgang](https://www.github.com/piersholt/wolfgang) (see below)
- PulseAudio (with Bluetooth plugins)

#### Wilhelm

Walter relies upon a single library `wilhelm`, which is itself broken into several sub modules:

**Core** is akin to the first, and second layer of the OSI model. The lower of the two layers encapsulates IO operations for the bus, while higher of the two layers handles frame synchronisation, and error detection.

**Virtual** is a model of the bus, and common modules. This allows for building module specific states, and APIs, and acts as a framework for implementing either emulated modules i.e. the radio when it has been removed, or augmented modules i.e. piggybacking the graphics stage.

**API** is a high level API with abstractions of vehicle features, i.e. audio, telephone, display. The API objects are designed to be pseudo-universal (i.e. communication, music, navigation), reflect common operations, e.g. `API::Telephone.incoming_call(caller_id)`, and remove the need to deal with the intricacies the bus.

**SDK** is a small MVC framework, and runtime environment for services, and built on top of **API**.

**Services** includes a simple Bluetooth device manager, and Bluetooth audio streaming, two examples of services built, and deployed using the **SDK** library. They act only as an abstraction for a Bluetooth car kit, with Bluez doing the heavy lifting, with a little help from [Wolfgang](https://www.github.com/piersholt/wolfgang), which encapsulates the Bluez D-BUS API, and implements a virtual car kit.



## License

This program is released under the GNU General Public License v3.0.
