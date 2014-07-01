require 'pivotal-tracker'

class PivotalWriter

  PIVOTAL_API_TOKEN = ENV['PIVOTAL_API_TOKEN']
  DEV_PROJECT_ID = 320599

  def initialize
    PivotalTracker::Client.use_ssl = true
    PivotalTracker::Client.token = PIVOTAL_API_TOKEN
    PivotalTracker::Project.all
  end

  def dev_project
    @dev_project ||= PivotalTracker::Project.find(DEV_PROJECT_ID)
  end

  def dev_stories
    dev_project.stories
  end

  def create(options = {})
    dev_stories.create(options)
  end
end
