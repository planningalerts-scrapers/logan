Logan City council now has a custom site that uses an API. So, we're using that.

Enjoy

* Server - Microsoft-IIS/10.0 - Windows Azure
* Cookie tracking - No (Accept terms doesn't have to set cookie)
* Pagnation - yes (default: 10 items)
* Javascript - No, Page completely loaded by JS but we can call APi directly and parse JSON
* Clearly defined data within a row - Yes, JSON data from API, tr.MuiTableRow-root on web page
* System - "Development Enquiry Tool" hosted in Australia in partnership with WSP Australia Limited

This is a scraper that runs on [Morph](https://morph.io). To get started [see the documentation](https://morph.io/documentation)

Add any issues to https://github.com/planningalerts-scrapers/issues/issues

## To run the scraper

    bundle exec ruby scraper.rb

### Expected output

    Getting application submitted between 2025-12-11 and 2026-01-10...
    Getting page: 1...
    .../ruby/3.2.2/lib/ruby/gems/3.2.0/gems/mechanize-2.8.5/lib/mechanize/pluggable_parsers.rb:107:in `new': MIME::Type.MIME::Type.new when called with a String is deprecated.
    Storing BW/104/2026 - 23 Dorchester Drive PARK RIDGE  4125, QLD
    ...
    Storing BW/13084/2025 - 33 Hartnell Drive PARK RIDGE  4125, QLD
    Sleeping 5.842s
    Getting page: 2...
    .../ruby/3.2.2/lib/ruby/gems/3.2.0/gems/mechanize-2.8.5/lib/mechanize/pluggable_parsers.rb:107:in `new': MIME::Type.MIME::Type.new when called with a String is deprecated.
    Storing BW/13085/2025 - 18 Garoona Grove SLACKS CREEK  4127, QLD
    ...
    Storing SP/3/2026 - 5-9 New Beith Road GREENBANK  4124, QLD
    Finished, Last page only had 79 items

Execution time: ~ 1 to 2 minutes

## To run style and coding checks

    bundle exec rubocop

## To check for security updates

    gem install bundler-audit
    bundle-audit
