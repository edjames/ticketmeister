# https://sifterapp.com/developer/resources

require 'sifter'
require 'json'

class Sifter::IssuesSummary < Hashie::Dash
  property :per_page
  property :page
  property :total_pages
  property :results_count
  property :next_page_url
  property :previous_page_url
end

module Sifter::Account::Ext
  def project(id)
    Sifter::Project.new(
      Sifter.get("/api/projects/#{id}").parsed_response["project"])
  end
end

module Sifter::Project::Ext
  def open_issues(page = 1)
    Sifter.
      get(api_open_issues_url(page)).
      fetch("issues", []).
      map { |i| Sifter::Issue.new(i) }
  end

  def issue_summary
    @issue_summary ||= Sifter::IssuesSummary.new(
      Sifter.get(api_open_issues_url).tap { |r| r.delete 'issues' })
  end

  def total_pages
    issue_summary.total_pages
  end

  def api_open_issues_url(page = 1)
    "#{api_issues_url}?s=1-2&page=#{page}"
  end
end

module Sifter::Issue::Ext
  def human_url
    "https://vzaar.sifterapp.com/issues/#{number}"
  end

  def tracker_title
    "##{number} #{subject}"
  end
end

Sifter::Account.include Sifter::Account::Ext
Sifter::Project.include Sifter::Project::Ext
Sifter::Issue.include Sifter::Issue::Ext

class SifterReader

  SIFTER_HOSTNAME = ENV['SIFTER_HOSTNAME']
  SIFTER_API_TOKEN = ENV['SIFTER_API_TOKEN']

  module Projects
    BUGS        = 2565
    DEVELOPMENT = 1207
    SYSOPS      = 2922
  end

  def account
    @account ||= Sifter::Account.new(SIFTER_HOSTNAME, SIFTER_API_TOKEN)
  end

  def bug_project
    @bug_project ||= account.project(Projects::BUGS)
  end

  def dev_project
    @dev_project ||= account.project(Projects::DEVELOPMENT)
  end

  def sysops_project
    @sysops_project ||= account.project(Projects::SYSOPS)
  end

  def find_bug_ticket(number)
    find_ticket bug_project, number
  end

  def find_dev_ticket(number)
    find_ticket dev_project, number
  end

  def find_sysops_ticket(number)
    find_ticket sysops_project, number
  end

  private

  def find_ticket(project, number)
    1.upto(project.total_pages) do |page|
      found = project.open_issues(page).find { |i| i.number.to_i == number.to_i }
      return found if found
    end
    nil
  end
end
