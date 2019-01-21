# Okay, a thing that listens to certain devices that affect it...

class Virtual
  # This class handles the re-draw
  # The states will determine this automatically
  # When busy, it will not draw
  # When active, will listen for overwrite vents, which will re-draw
  class Display
    include Singleton
    include Listener
    # new layout to
    def create(laytout)
    end

    def updatex(laytout)
    end

    # redraw cached laytout
    def refresh
    end

    # Release control of display back to vehicle
    def release
    end
  end
end
