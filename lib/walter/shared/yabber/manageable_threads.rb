# frozen_string_literal: false

# Manageable Threads
module ManageableThreads
  # include DataTools

  def log_threads
    threads.list.each do |this_thread|
      LOGGER.warn(proc_name) { this_thread.to_s }
    end
  end

  def close_threads(all = false)
    target = all ? Thread : threads

    LOGGER.debug(proc_name) { '#close_threads' }
    LOGGER.info(proc_name) { 'Threads closing.' }

    threads.list.each_with_index do |t, i|
      t.exit.join
      LOGGER.info(proc_name) { formatted(t, i) }
    end
    LOGGER.info(proc_name) { 'Threads closed.' }
    true
  end

  def thread_list
    threads.list
  end

  def list
    threads.list
  end

  def threads
    @threads ||= ThreadGroup.new
  end

  def add_thread(new_thread)
    threads.add(new_thread)
  end

  def d2h(decimal, prefix = false)
    raise ArgumentError, 'No numeric to format!' if decimal.nil?
    mask = prefix ? '%#.2x' : '%.2X'
    Kernel.format(mask, decimal)
  end

  def formatted(thread, index = nil)
    thread_status = thread.status
    thread_status = 'Terminated' if thread_status == false

    object_id = thread.group.object_id
    object_id = d2h(object_id, true)


    str_buffer = '[Thread]'
    str_buffer = str_buffer << " #{index + 1}."
    str_buffer = str_buffer << " / #{thread[:name]}"
    str_buffer = str_buffer << " / #{thread_status}"
    # str_buffer << "Group: #{object_id}"
    str_buffer
  end

  def print_status(all = false)
    target = all ? Thread : threads
    target.list.each_with_index do |t, i|
      LOGGER.info(proc_name) { formatted(t, i) }
    end
  end

  def proc_name
    self.class
  end
end
