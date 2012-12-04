#require 'net/http'
require 'open-uri'
require 'nokogiri'
require_relative 'event.rb'

class Scraper
  attr_accessor :url, :events

  def initialize(url)
    @url = url
    scrape
  end

  def scrape
    import_xml(open(@url).read)
  end

  # Reads Google Calendar XML and populates fields
  def import_xml(raw)
    doc = Nokogiri::XML(raw)

    @events = []
    doc.css('entry').each do |entry|
      fields = {
        :id        => entry.css('id').text,
        :published => entry.css('published').text,
        :title     => entry.css('title').text,
        :summary   => entry.css('content').text,
        :start     => entry.xpath('gd:when').first['startTime'],
        :end       => entry.xpath('gd:when').first['endTime'],
        :where     => entry.xpath('gd:where').first['valueString'],
        :url       => entry.css('link').first['href']
      }
      
      @events << Event.new(fields)
    end

    return @events
  end

end
