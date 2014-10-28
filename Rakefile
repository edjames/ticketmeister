require 'rake'
require_relative 'ticketmeister.rb'

namespace :create do

  desc "Create a Pivotal Tracker bug ticket"
  task :bug do
    number = ARGV[1]

    Ticketmeister.new.create_bug(number)

    cmd = %Q{ growlnotify -t 'Sifter ticket #{number}' -m 'Successfully created bug ticket' }
    system cmd

    task number.to_sym do ; end
  end

  desc "Create a Pivotal Tracker feature ticket"
  task :feature do
    number = ARGV[1]
    estimate = ARGV[2]

    Ticketmeister.new.create_feature(number, estimate)

    cmd = %Q{ growlnotify -t 'Sifter ticket #{number}' -m 'Successfully created dev ticket, #{estimate} pts' }
    system cmd

    task number.to_sym do ; end
    task estimate.to_sym do ; end
  end

  desc "Create a Pivotal Tracker sysops ticket"
  task :sysops do
    number = ARGV[1]
    estimate = ARGV[2]

    Ticketmeister.new.create_sysops(number, estimate)

    cmd = %Q{ growlnotify -t 'Sifter ticket #{number}' -m 'Successfully created sysops ticket, #{estimate} pts' }
    system cmd

    task number.to_sym do ; end
    task estimate.to_sym do ; end
  end

end
