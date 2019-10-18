namespace :walter do
  commands = :start, :stop, :restart
  commands.each do |command|
    desc "#{command.capitalize} Thin"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        execute :echo, current_path
        within current_path do
          execute :rbenv, "sudo /etc/init.d/thin #{command}"
        end
      end
    end
  end
end

namespace :source do
  # decs 'Delete source'
  # task :delete do
  #   on roles(:development) do |host|
  #     hostname = host.hostname
  #     username = host.user
  #
  #     list = %x(ls).split
  #     restricted_files = %w(.git .gitignore .ruby-version log)
  #     restricted_files.each { |file| list.delete(file) }
  #     # puts %x`scp -r . #{username}@#{hostname}:#{fetch :deploy_to}`
  #     paths = list.join(' ')
  #     # puts paths
  #     # puts "scp -B -C -r #{paths} #{username}@#{hostname}:#{fetch :deploy_to}"
  #     puts %x`rm -rf #{paths} #{username}@#{hostname}:#{fetch :deploy_to}`
  #   end
  # end

  desc 'Upload source.'
  task :upload do
    on roles(:development) do |host|
      hostname = host.hostname
      username = host.user

      list = %x(ls -A).split
      restricted_files = %w(.git .gitignore .ruby-version log tmp .DS_Store)
      restricted_files.each { |file| list.delete(file) }
      # puts %x`scp -r . #{username}@#{hostname}:#{fetch :deploy_to}`
      puts list.join("\n")
      file_arg = list.join(' ')
      # puts "scp -B -C -r #{file_arg} #{username}@#{hostname}:#{fetch :deploy_to}"
      puts %x`scp -r #{file_arg} #{username}@#{hostname}:#{fetch :deploy_to}`
      puts Time.now
    end
  end

  # desc 'Upload lib'
  # task :lib do
  #   on roles(:development) do |host|
  #     hostname = host.hostname
  #     username = host.user
  #
  #     puts %x`scp -B -C -r lib #{username}@#{hostname}:#{fetch :deploy_to}`
  #   end
  # end
end
