### `wilhelm-api`
- sits atop `wilhelm-virtual`
- a completely abstracted, agnostic, bi-directional API, decoupled from the underlying BMW bus implementation
- API objects modelled on universal feature sets, i.e. `Communication`, or `Audio`
- API object methods reflecting common use cases, i.e. `Communications.incoming_call(caller_id)`, or `Audio.on()`
- Callbacks for feature events, such as user control input e.g. `<Button::Stateful :id => :bmbt_next, :state => :hold>`
