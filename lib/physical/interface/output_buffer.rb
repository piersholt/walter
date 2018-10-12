# it can't be asyncronous...
# it needs to be blocked

# there's also the issue of the device needing to know if something worked...
# it's not the transitters responsibioity to retry...

# can... i just keep it really dumb for now?
# basically just pull out the code that was implemented by interface

# argh, hang on i can't have a thread... as.. it's the transmitter thread that

# it's fundamentally an IO abstraction
# the fact that read needs a thread is it's own business
# where i'm getting confused is... the intput buffer doesn't populate itself...
# maybe this doesn't either... but can i make it blocking?
# can it give it to a thread, be locked until it returns?
# fucking hell, i'm moving Transmitter farther and farther away from IO
class Interface
  class OutputBuffer
    def initialize(stream)
      @stream = stream
    end

    def write(string)
      bytes_to_write = string.length
      bytes_written = @stream.write(string)
      bytes_to_write == bytes_written ? true : false
    end
  end
end
