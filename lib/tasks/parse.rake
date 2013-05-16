task :parse => :environment do
  Feed.parse_if_not_parsed_since(1.hour.ago)
end