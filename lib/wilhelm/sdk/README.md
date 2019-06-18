`wilhelm-sdk`

plus the encapsulating context.
including, external messaging handling,

MVC framework, including UI base classes

CONTROLS

Each control can be listened to.
Each input can be configured as one of three different types of control
Any number of services can listen/subscribe to button events,
so to avoid having multiple services conflict, it's best to design a state to avoid this.


USER INTERFACE

Routing is configured programatically
Each service can register a controller against a given keyword, akin to a namespace. The controller can implement a method per view, akin to Rails.

Example: To launch the #index method of the controller registered under :debug => `ui_context.launch(:debug, :index)`


A UI controller

Thinking the general flow...
The controller responsible for rending the view will listen for user input events

It also listens

2.1 Repurposes the Radio display for RDS, station list.

The on screen view will listen for user input events.
Any models associated with the view, when updated will cuase the view to refresh.

2.2 UI Base Classes
