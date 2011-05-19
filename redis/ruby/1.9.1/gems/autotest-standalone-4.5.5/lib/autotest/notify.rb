class Autotest
  class Notify
    def self.notify(state)
      pretty_state = state.to_s.capitalize
      title = "#{pretty_state} -- Autotest"
      
      command = case RUBY_PLATFORM
      when /linux/
        title = "'#{title}'"
        case linux_lib
        when :'notify-send' then "#{linux_lib} #{title}"
        when :kdialog then "#{linux_lib} --title #{title}"
        when :zenity then "#{linux_lib} --title #{title}"
        end
      when /darwin/
        "growlnotify -n autotest -m \"#{pretty_state}\" Autotest"
      when /cygwin/
        "sncmd /m '#{title}'"
      when /mswin/
        require 'snarl'
        Snarl.show_message(title)
        ''
      end

      system command
    end

    private

    def self.linux_lib
      libs = [:'notify-send', :kdialog, :zenity]
      @@linux_lib ||= libs.detect do |l|
        system("which #{l} > /dev/null 2>&1")
      end or puts("Install one of #{libs.join(', ')} to get notified")
    end
  end
end

[:red, :green, :all_good].each do |hook|
  Autotest.add_hook hook do
    begin
      Autotest::Notify.notify(hook)
    rescue Exception => e # errors in autotest would fail silently
      puts e.to_s
      puts e.backtrace
    end
  end
end