module Analyze
  attr_accessor :frames

  S = 0
  L = 1
  R = 2
  C = 3

  def load_all(*filenames)
    filenames.each do |id|
      print_filename(id)
    end
  end

  def print_filename(id)
    puts "---------------------------------------------------------------------------------------------------------"
    puts "#{id}"
    load("/Users/piers/Desktop/#{id}.txt")
    puts "count: #{count}"

    print 'senders: '
    puts senders.join(', ')

    print 'recipients: '
    puts recipients.join(', ')

    print_grouped_by_recipient
    print_grouped_by_command
  end

  def load(path)
    f = File.open(path)
    lines = f.readlines
    @frames = lines.map { |line| line.split(' ') }
  end

  def count
    frames.count
  end

  def recipients(sender = nil)
    return frames.find_all { |f| f[0] == sender }.map { |f| f[2] }.uniq if sender
    frames.map { |f| f[2] }.uniq
  end

  def senders
    frames.map { |f| f[0] }.uniq
  end

  def senders_frames
    frames.group_by {|f| f[0] }
  end

  def sorted_by_id(frames)
    frames.sort { |b,a| a[0] <=> b[0] }
  end

  def sorted(frames)
    frames.sort { |b,a| a[1] <=> b[1] }
  end

  def grouped_by_recipient
    senders_frames.map do |sender_id, their_frames|
      recipients_frames = their_frames.group_by {|f| f[2] }

      recipients_frame_count =
        recipients_frames.map do |recipient_id, there_frames|
          [recipient_id, there_frames.count]
        end
      sorted(recipients_frame_count)
      [sender_id, recipients_frame_count.to_h]
    end.to_h
  end

  def print_grouped_by_recipient
    puts 'grouped_by_recipient: '
    # puts grouped_by_recipient
    grouped_by_recipient.each do |sender_id, counts_by_recipient|
      puts "#{sender_id}:\n"
      counts_by_recipient.each do |recipient_id, count|
        recipient_name = device_name(recipient_id)
        puts "  #{recipient_id} (#{recipient_name}): #{count}"
      end
    end
  end

  def print_grouped_by_command
    puts 'grouped_by_command: '
    # puts grouped_by_command
    grouped_by_command.each do |sender_id, counts_by_command|
      puts "#{sender_id}:\n"
      counts_by_command.each do |command_id, count|
        command_name = command_name(command_id)
        puts "  #{command_id} (#{command_name}): #{count}"
      end
    end
  end

  def grouped_by_command
    result = senders_frames.map do |sender_id, frames_sent_by_sender|
      grouped_by_command = frames_sent_by_sender.group_by { |f| f[C] }

      command_group_count =
        grouped_by_command.map do |command_id, that_commands_frames|
          [command_id, that_commands_frames.count]
        end
      sorted_by_id(command_group_count)
      [sender_id, command_group_count.to_h]
    end

    result.to_h
  end

  def print_commands
    print 'commands: '
    commands.each do |c|
      puts "#{c}: #{command_name(c)}"
    end
  end

  def commands
    frames.map { |f| f[C] }.uniq.sort
  end

  def command_name(hex_string)
    CommandMap.instance.find(hex_string.hex)[:properties][:short_name]
  end

  def device_name(hex_string)
    # LOGGER.info('#device_name') { hex_string }
    mapped_device = DeviceMap.instance.map[hex_string.hex]
    return 'Error' unless mapped_device
    mapped_device[:properties][:short_name]

    # DeviceMap.instance.find()
  end

  def print_senders_length
    puts 'senders_length: '
    senders_length.each do |a,b|
      puts "#{a}: #{b}"
    end
  end

  def senders_length
    senders.map do |sender_id|
      result = frames.find_all {|f| f[0] == sender_id }.map {|f| f.length }.uniq
      [sender_id, result]
    end
  end
end