#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('a').text.tidy
    end

    def position
      return ministry if ministry.start_with? 'Presidente'
      return ministry.sub('Ministero', 'Ministro') if role == 'Ministro'

      return role
    end

    def role
      noko.parent.css('p').text.tidy
    end

    def ministry
      noko.xpath('preceding::h3[not(@class="title")][1]').text.to_s.tidy
    end
  end

  class Members
    def members
      super.select { |mem| mem[:position][/^(Ministro|Presidente)/] }
    end

    def member_container
      noko.css('h4').each { |node| node.name = 'h3' } # Standardise these
      noko.css('#pagina-50 h3.title')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
