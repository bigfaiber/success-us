require 'httparty'
require 'nokogiri'
require 'pry'
require 'csv'

URL_SERVICE = "craigslist.org/search/apa"

class CraiglistScraper

  def initialize city
    @url = "https://#{city}." + URL_SERVICE
  end

  def generate_cvs
    start = Time.now
    p "Started at #{start}"
    arr_to_cvs = apts_list
    arr_to_cvs.each do |apt|
      CSV.open("results.csv", "a+") do |csv|
        csv << apt
      end
    end
    p "Time spent: #{(Time.now - start).to_i/60.to_f} minutes"
  end

  private

  def scrape_page start = 0
    Nokogiri::HTML(HTTParty.get(@url + "?s=#{start}&" + "min_bedrooms=3&max_bedrooms=3&min_bathrooms=2&max_bathrooms=2&availabilityMode=0"))
  end

  def apts_list
    start = 0
    raw_page = scrape_page
    array_to_cvs = []
    while raw_page.css(".totalcount").first && start < raw_page.css(".totalcount").first.text.to_i
      results = raw_page.css(".result-row")
      results_in_page = results.count
      results.each do |r|
        title = r.css(".result-title").first.text
        monthly_rent = r.css(".result-meta").css(".result-price").first.text
        url = r.css(".result-title").first.attributes["href"].value
        description = Nokogiri::HTML(HTTParty.get(url))
        description.css(".mapaddress").first ? address = description.css(".mapaddress").first.text : address = nil
        address = "No address" if (address.nil? || address.include?("(google map)"))
        array_to_cvs << [title, address, monthly_rent, url]
      end
      break if results_in_page == 0
      start += results_in_page
      raw_page = scrape_page start
    end
    array_to_cvs
  end
end

CraiglistScraper.new("atlanta").generate_cvs