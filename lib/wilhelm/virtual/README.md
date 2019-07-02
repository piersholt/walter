### `wilhelm-virtual`
- sits atop `wilhelm-core`
- an abstraction of the vehicle bus, and it's devices in provide APIs at the device level
- each modelled device has an verbose API that maps one to one with applicable commands e.g. `radio.led(led: 0xFF) => 68 04 F0 4A FF D6`
- sitting atop this verbose API, is a more 'human' API that models key features, e.g. `radio.change_disc!(5)`, and which avoids the need for knowledge of the commands.

### Architecture
- the abstraction was designed to provide an extensible intermediate interface to the bus
- this design was the true goal, not to have an comprehensive API. Aside from the need to first manually map out the commands via extensive tinkering and programatically generated random commands, I only had a handful of higher level features in mind to begin with.

### Modules

Module|Emulated|Augmented
:---|:---|:----
[`Radio`](lib/wilhelm/virtual/device/radio/)|✅|⚠️
[`Telephone`](lib/wilhelm/virtual/device/tel/)|🔧|🚫
[`CD Changer (CDC)`](lib/wilhelm/virtual/device/cdc/)|⚠️|🚫
[`On-board Monitor (BMBT)`](lib/wilhelm/virtual/device/bmbt/)|🚫|✅
[`Nav. Computer (GT)`](lib/wilhelm/virtual/device/gfx/)|🚫|✅
[`Cluster (IKE)`](lib/wilhelm/virtual/device/ike/)|🚫|✅
[`Multi-function Wheel (MFL)`](lib/wilhelm/virtual/device/mfl/)|🚫|✅
[`DSP`](lib/wilhelm/virtual/device/dsp/)|🎯|🚫
[`Diagnostics`](lib/wilhelm/virtual/device/diag/)|🔧|🚫

#### Legend
Icon|Description
:---|:---
✅ | Foundational component and reasonably stable.
🔧 | In progress...
🎯 | Will be developed in time.
⚠️ | Developed prior to decision to remove support for legacy modules. Caveat emptor.
🚫 | No use case. Will not be developed.
