# Walter [![License: GPL-3.0-only](https://img.shields.io/github/license/piersholt/walter.svg)](https://www.gnu.org/licenses/gpl-3.0)

A project demonstrating a prototype SDK for BMWs utilising I/K-BUS, which includes a high level vehicle API, and resources for developing and deploying software plugins.

This _is not_, and _should not_ be considered a library (hence the absence of a published gem), nor a how to guide. Although, I plan to continue developing the library- albeit, to suit my needs, and general philosophy.

---


## Contents

1. [Something Here](#something-here) - all kinds of somethings
1. [Something Here](#something-here) - all kinds of somethings
1. [Something Here](#something-here) - all kinds of somethings
1. [Something Here](#something-here) - all kinds of somethings
1. [Something Here](#something-here) - all kinds of somethings
1. [Something Here](#something-here) - all kinds of somethings


## Background

Walter began as a means to add support for Bluetooth audio (A2DP/AVRCP) with native display, and control via the on-board monitor (BMBT), and multi-function steering wheel controls (MFL) to my [BMW E39 5 series](https://en.wikipedia.org/wiki/BMW_5_Series_(E39). In my case, a 1997 528i Touring, optioned with navigation, HiFi, and telephone (i.e. High IKE, and both I and K buses).

There are a number of products available that fulfil this need, but each had compromises, and I was curious to what functionality could be developed via the I/K bus.

Like the Intravee, and a number of other projects, I planned to replace the CD changer, and emulate it's behaviour as to retain the native interface and controls. This began in earnest, and would come to work well for the best part.

However, the solution also required a number of compromises that left me a little dissatisfied. I admit they remain a function of my expectations alone...

- The original C23 BM, and BM53 (from my... other E39) radios both developed failing amplifiers. While the repair is relatively straight forward, even allowing for a little upgrade, I didn't want to invest more time/money into a legacy device.
- The need to support the legacy audio sources (tape, CD, radio) seemed pointless given their complete obsolesce
- The radio is a complete brat that never shuts up, meaning even with brute force re-write to the display (aka Intravee), the user experience is never quite seamless.
- I was finding A2DP, or AVRCP in particular had some frustrating shortcomings, with some common operations (like changing audio apps, i.e. Overcast to Spotify) mandating the use of the mobile device, thereby rendering the context specific interface of the vehicle controls a bit bloody pointless. (Okay, this is technically a shortcoming of the AVRCP profile which does technically support player switching, but that's besides the point!)

At this point I evaluated the radio, which in it's intended role, really only functioned as audio passthrough (albeit amplified, with the option to sprinkle a little EQ). Not a great deal of value relative to the cost of supporting it.

Long story short, I removed it, and the video module, and took the opportunity to drastically cull the entire rear wiring loom which was becoming increasingly visually, and philosophically offensive the longer it sat exposed while all the trunk trim was removed.



_This proved a little more difficult than I expected. Not to say that I thought it would be a walk in the park, but there's a number of factors to consider. I figured the first loom would be a prototype so I decided to repurpose the existing loom wiring where possible, and avoided the need for connectors buy going for quick connects._

_To be fair, the solution is heavy handed in a number of places, and unncessarily complex, but let's be frank, this entire project is largely pointless, and purely an exercise in enjoyment, so.._

_Thus began what the project ultimately became. A semi-universal interface, to allow anything to be interfaced. In seemingly enjoying overcomplicating things, this included that I think I can (in earnest) call an SDK, to provide a framework for developing additional plugins. As I touched on earlier, there's probably little practical value to anyone in this, but I enjoyed writing it, and it serves me, so I'm going to call it a win._


## The Thing I've Built...

- headless raspberry pi
- pi/amplifier interface
- consumer circuit pi power up


## Architecture

The software is comprised of several layers.

**Core** is akin to the first, and second layer of the OSI model. The lower of the two layers is responsible for reading and writing to the bus, while higher of the two layers handles frame synchronization, and error detection.

**Virtual** is a realtime model of the bus, and constituatant modules. This allows for building module specific states, and APIs, and acts as a framework for implementing either emulated modules i.e. the radio when it has been removed, or augmented modules i.e. the graphics stage.

**API** is a high level API with abstractions of vehicle features, i.e. audio, telephone, display. The API objects are designed to be pseudo-universal (i.e. communication, music, navigation), reflect common operations, e.g. `API::Telephone.incoming_call(caller_id)`, and remove the need to deal with the intricacies of the vehicle systems.

**SDK** many things

**Services** many _more_ things


------

## Usage

While the underlying library is largely configurable, and designed to eventually be a standalone library, in it's current form it's inherently biased towards the needs of the project, and makes a number of assumptions:
- the absence of the Radio, CD changer, and Telephone modules
- a HiFi optioned vehicle (i.e. HiFi amplifier- not stereo, not DSP)
- a navigation optioned vehicle (i.e. BMBT, and navigation computer, specifically the widescreen, and MK4 variants respectively)
- the presence of [Wolfgang](https://www.github.com/piersholt/wolfgang), which does the bluetooth heavy lifting.

### Requirements

- \*nix.
-

Wilhelm only relies upon a IO stream, be it a device file i.e. `/dev/cu.SLAB_USBtoUART` as in the case of Silicon Labs CP2104, or FTDI232X. I have used Resler's USB interface, (6b, with SiLabs CP2104), but there are a number of circuits using Melexis 3122, and MAX232 available online.

- MK4.. I'm too selfish to add support for various units.
- No radio... limited support for retaining the radio. Tape.. CDs.. AM/FM.. blergh..

### Usage

`$ bin/run -f /dev/cu.SLAB_USBtoUART --console`


## Documentation

See the README of the various components:

Directory|Description
:---|:---
[`lib/wilhelm/core`](lib/wilhelm/core/)|All the things!
[`lib/wilhelm/virtual`](lib/wilhelm/virtual/)|All the things!
[`lib/wilhelm/api`](lib/wilhelm/api/)|All the things!
[`lib/wilhelm/sdk`](lib/wilhelm/sdk/)|All the things! Confluence.
[`lib/wilhelm/services`](lib/wilhelm/services/)|All the things!


## References/Recommended

- HackTheIBus
- Alextronic
- Mono
- Curious
- Droid
- Distracted

## License

This program is released under the GNU General Public License v3.0.
