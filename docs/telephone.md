# Telephone

#### Features
  - Calls
    - Initiate calls from the vehicle
    - Accept/Reject calls from the vehicle
  - Phonebook
    - accessible via BMBT and IKE
  - Handsfree System
    - ...
    - Microphone
      - On vehicles with a telephone hookup*, the handsfree speaker is positioned in the headliner.
        For further information on the cellular phone, refer to the separate Owner's Manual.

#### Behaviour/Functionality
  - calls
    - when a call is received, it must interupt/take priority over system
  - handsfree
    - initiating while the handset is still in place means handsfree is default
    - picking up the receiver with switch handsfree off
    - replacing it in the cradle will switch handsfree on
    - while in handsfree, the MFL volume buttons, and BMBT volume buttons will change call volume

#### Components
  - BMBT
    - indicator lamps
  - MFL
    - Buttons:
      - R/T: select Radio or Telephone operating mode
      - Back/Forward: scroll contacts
      - Phone: Receive a call, initiate dialing and terminate a call.

#### Notes
- ...

### Bluetooth (ULF)
- much like Walter, the ULF module acts as middleware to the vehicle that doesn't have additional hardware to support UFL.
 - MFL phone button replaced by voice, but this is merely cosmetic, with alternative functionality being implemnted by the control module
 - indicator lamps represent different events (with the middle/orange) no longer being used
- car/handset switch (similar to Toypta) in the event that a call is started on the phone while connected, and the user wishes to user their device

# Emulation

#### Overview

Walter mimics the original telephone system, and the vehicle is communicating as if the original built in telephone is still active.

While middleware maps commands between the external phone connected via Bluetooth. To the external device, it's communicating with any given HFS Protocol,

### I-BUS

### Make A Call
    # NOTE: LED commands removed for brevity

    # Start call

    17:59:16 [INFO ] BMBT  	GLO-H 	BMBT-BTN-1	[TEL] Press

    17:59:16 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-01 | 00	"☐☐"
    17:59:16 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-02 | 00	"☐"

    17:59:16 [INFO ] TEL   	ANZV  	TEL-?-1   	13
    17:59:16 [INFO ] BMBT  	RAD   	TAPE      	06 E2
    17:59:16 [INFO ] RAD   	BMBT  	???       	48
    17:59:16 [INFO ] BMBT  	RAD   	TAPE      	06 30

    # End call?

    17:59:17 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-01 | 00	"  "

    17:59:17 [INFO ] TEL   	ANZV  	TEL-?-1   	12

    17:59:17 [INFO ] BMBT  	RAD   	TAPE      	06 E1
    17:59:17 [INFO ] RAD   	BMBT  	???       	48

    17:59:17 [INFO ] BMBT  	RAD   	TAPE      	06 30
    17:59:17 [INFO ] RAD   	BMBT  	???       	48

    17:59:17 [INFO ] BMBT  	RAD   	TAPE      	06 30

    17:59:26 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-02 | 00	" "

### Make A Call 2

    # Start call
    18:04:25 [INFO ] MFL   	TEL   	BTN-FUNC  	Tel: Press

    18:04:25 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-01 | 00	"☐☐"
    18:04:25 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-02 | 00	"☐"

    18:04:25 [INFO ] TEL   	ANZV  	TEL-?-1   	13
    18:04:25 [INFO ] BMBT  	RAD   	TAPE      	06 E2
    18:04:25 [INFO ] TEL   	ANZV  	TEL-?-1   	13
    18:04:25 [INFO ] BMBT  	RAD   	TAPE      	06 E2
    18:04:25 [INFO ] RAD   	BMBT  	???       	48

    18:04:25 [INFO ] BMBT  	RAD   	TAPE      	06 30

    # HUGE DELAY: LEDs stay on, no change to display.

    # the light goes off before the icon changes..?
    18:04:42 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-01 | 00	"  "

    18:04:42 [INFO ] TEL   	ANZV  	TEL-?-1   	12
    18:04:42 [INFO ] BMBT  	RAD   	TAPE      	06 E1
    18:04:43 [INFO ] RAD   	BMBT  	???       	48
    18:04:43 [INFO ] BMBT  	RAD   	TAPE      	06 30
    --
    18:04:51 [INFO ] TEL   	ANZV  	TXT-MEDIA 	TEL-02 | 00	" "



#### Commands
- `0x23`
- `0x2B`
- `0x2C`
- `0x02`

#### `0x23`

#### GFX
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	00 20	"INSERT CARD!"
    TEL   	GFX   	23	C0 20	"SOS: 112!"
    TEL   	GFX   	23	C0 20	"SOS: 112!"
    TEL   	GFX   	23	C0 20	"SOS: 112!"
    TEL   	GFX   	23	C0 20	"SOS: 112!"

##### ANZV
    TEL   ANZV   	23	 01 00 C7 C8
    TEL   ANZV   	23	 01 00 20 20
    TEL   ANZV   	23	 01 00 C7 C8
    TEL   ANZV   	23	 01 00 20 20
    TEL   ANZV   	23	 01 00 C7 C8
    TEL   ANZV   	23	 01 00 20 20
    TEL   ANZV   	23	 01 00 C7 C8
    TEL   ANZV   	23	 01 00 20 20    
    TEL   ANZV   	23	 02 00 C6
    TEL   ANZV   	23	 02 00 20
    TEL   ANZV   	23	 02 00 C6
    TEL   ANZV   	23	 02 00 20
    TEL   ANZV   	23	 02 00 C6
    TEL   ANZV   	23	 02 00 20
    TEL   ANZV   	23	 02 00 C6
    TEL   ANZV   	23	 02 00 20
##### IKE
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
      C8 11 80 23 40 20 49 4E 53 45 52 54 20 43 41 52 44 21 18
      200 17 128 35 64 32 73 78 83 69 82 84 32 67 65 82 68 33 24
    TEL   	IKE   	TXT-MEDIA 	41 | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
    TEL   	IKE   	TXT-MEDIA 	41 | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
    TEL   	IKE   	TXT-MEDIA 	41 | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
    TEL   	IKE   	TXT-MEDIA 	41 | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
    TEL   	IKE   	TXT-MEDIA 	41 | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	""
    TEL   	IKE   	TXT-MEDIA 	Radio Set Station | Set IKE	"INSERT CARD!"
#### `0x2B`
  - recipients: [ANZV]

#### `0x2C`
  - recipients: [ANZV]

#### `0x202`

- _"Insert Card"_

# Questions
- the main menu telephone navigation is available.. is it populated?
