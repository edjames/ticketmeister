require_relative 'lib/sifter_reader.rb'
require_relative 'lib/pivotal_writer.rb'

class Ticketmeister
  attr_reader :pivotal, :sifter

  def initialize
    @pivotal = PivotalWriter.new
    @sifter = SifterReader.new
  end

  def create_bug(sifter_number)
    create(
      sifter.find_bug_ticket(sifter_number),
      sifter_number: sifter_number,
      story_type: :bug)
  end

  def create_feature(sifter_number, estimate)
    create(
      sifter.find_dev_ticket(sifter_number),
      sifter_number: sifter_number,
      story_type: :feature,
      estimate: estimate)
  end

  def create_sysops(sifter_number, estimate)
    create(
      sifter.find_sysops_ticket(sifter_number),
      sifter_number: sifter_number,
      story_type: :feature,
      estimate: estimate)
  end

  private

  def create(issue, options = {})
    sifter_number = options.delete(:sifter_number)
    if issue
      options[:name] = issue.tracker_title
      options[:description] = issue.human_url
      pivotal.create(options)
    else
      raise "Cannot find issue for #{sifter_number}"
    end
  end
end
