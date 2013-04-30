require "httparty"

Dir[File.dirname(__FILE__) + '/rappfirst/*.rb'].each do |file|
  require file
end