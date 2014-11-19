require 'pivotal-tracker'

class PivotalWriter

  PIVOTAL_API_TOKEN = ENV['PIVOTAL_API_TOKEN']
  DEV_PROJECT_ID = 320599
  SYSOPS_PROJECT_ID = 383591

  def initialize
    PivotalTracker::Client.use_ssl = true
    PivotalTracker::Client.token = PIVOTAL_API_TOKEN
    PivotalTracker::Project.all
  end

  def dev_project
    @dev_project ||= PivotalTracker::Project.find(DEV_PROJECT_ID)
  end

  def sysops_project
    @sysops_project ||= PivotalTracker::Project.find(SYSOPS_PROJECT_ID)
  end

  def project_stories(project)
    case project
    when :development
      dev_stories
    when :sysops
      sysops_stories
    end
  end

  def dev_stories
    dev_project.stories
  end

  def sysops_stories
    sysops_project.stories
  end

  def create(options = {})
    project = options.delete(:project)
    stories = project_stories(project)
    stories.create(options)
  end
end
