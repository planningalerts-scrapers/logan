require "mechanize"
require "json"
require "scraperwiki"

# Returns number of records found
def get_page(agent, from:, to:, page_offset:, page_limit:)
  root_url = "https://devet.loganhub.com.au/"
  api_url = "https://devet-proxy.loganhub.com.au/devetapi/applications"

  params = {
    "lodgeDateFrom" => from,
    "lodgeDateTo" => to,
    "pageOffset" => page_offset,
    "pageLimit" => page_limit,
    "sortColumn" => "appNo",
    "sortDesc" => 0
  }

  page = agent.get(api_url, params, root_url)

  result = JSON.parse(page.body)

  result["data"].each do |a|
    council_reference = a["appNo"]
    record = {
      # Converting - to / to match what the council is showing
      "council_reference" => council_reference.gsub("-", "/"),
      "address" => a["propertyFmtAddress"] + ", QLD",
      "description" => a["description"],
      "info_url" => "#{root_url}#/applications/#{council_reference}",
      "date_scraped" => Date.today.to_s,
      "date_received" => a["lodgementDate"],
      # The API only seems to return if the application is currently on notification,
      # not the actual date range.
      # The addresses are already geocoded. We really should make use of that!
      "lat" => a["lat"],
      "lng" => a["lon"]
    }
    puts "Storing #{record["council_reference"]} - #{record["address"]}"
    ScraperWiki.save_sqlite(["council_reference"], record)
  end
  result["data"].count
end

# Search by submission date (last 30 days)
to = Date.today
from = to - 30
page_offset = 1
page_limit = 10
count = page_limit

agent = Mechanize.new

puts "Getting application submitted between #{from} and #{to}..."
while count == page_limit
  count = get_page(agent, from: from, to: to, page_offset: page_offset, page_limit: page_limit)
  page_offset += 1
end
