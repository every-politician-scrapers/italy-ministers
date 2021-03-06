#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  # decorator WikidataIdsDecorator::Links

  def header_column
    'Ritratto'
  end

  def table_number
    'position()>3'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[no _ img name start end].freeze
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
