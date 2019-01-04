class FrameSynchronisation
  attr_reader :buffer, :frame

  SYNC = 'Sync /'
  SYNC_HEADER = 'Header /'
  SYNC_TAIL = 'Tail /'
  SYNC_VALIDATION = 'Validate /'
  SYNC_ERROR = 'Error /'
  SYNC_SHIFT = 'Unshift! /'

  def initialize(buffer, frame = Frame.new)
    @buffer = buffer
    @frame = frame
  end

  def run
    fetch_frame_header
    fetch_frame_tail
    validate_frame
    frame
  rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
    LogActually.datalink.debug(SYNC_ERROR) { e }
    frame
  end

  private

  def name
    self.class.name
  end

  def fetch_frame_header
    LogActually.datalink.debug(name) { "#{SYNC} Byte Buffer size: #{buffer.size}." }

    LogActually.datalink.debug(name) { "#{SYNC_HEADER} Trying to shift #{Frame::HEADER_LENGTH} bytes." }
    header = buffer.shift(Frame::HEADER_LENGTH)
    LogActually.datalink.debug(name) { "#{SYNC_HEADER} Shifted bytes: #{header}" }

    # LogActually.datalink.debug(SYNC_HEADER) { "Setting new frame header." }
    frame.set_header(header)
    LogActually.datalink.debug(name) { "#{SYNC_HEADER} New frame header set: #{frame.header}" }
  rescue StandardError => e
    LogActually.datalink.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
    e.backtrace.each { |l| LogActually.datalink.warn(l) }
  end

  def fetch_frame_tail
    LogActually.datalink.debug(name) { "#{SYNC} Input Buffer: #{buffer.size}." }

    LogActually.datalink.debug(name) { "#{SYNC_TAIL} Shifting #{pending} bytes." }
    tail = buffer.shift(pending)
    LogActually.datalink.debug(name) { "#{SYNC_TAIL} Shifted bytes: #{tail}" }

    # LogActually.datalink.debug(SYNC_TAIL) { "Setting new frame tail." }
    frame.set_tail(tail)
    LogActually.datalink.debug(name) { "#{SYNC_TAIL} New frame tail set: #{frame.tail}" }
  rescue StandardError => e
    LogActually.datalink.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
    e.backtrace.each { |l| LogActually.datalink.warn(l) }
  end

  def pending
    LogActually.datalink.debug(name) { "#{SYNC_HEADER} Getting remaining frame bytes from header." }
    outstanding = frame.header.tail_length
    LogActually.datalink.debug(name) { "#{SYNC_HEADER} Remaining frame bytes: #{outstanding}" }
    outstanding
  rescue StandardError => e
    LogActually.datalink.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
    e.backtrace.each { |l| LogActually.datalink.warn(l) }
  end

  def validate_frame
    LogActually.datalink.debug(name) { "#{SYNC_VALIDATION} Validating new frame." }
    raise ChecksumError unless frame.valid?
    LogActually.datalink.debug(name) { "#{SYNC} Valid! #{frame}" }
  rescue ChecksumError => e
    # Need to rescue and raise this again otherwise StandardError rescue buggers it up
    raise e
  rescue StandardError => e
    LogActually.datalink.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
    e.backtrace.each { |l| LogActually.datalink.warn(l) }
  end
end
