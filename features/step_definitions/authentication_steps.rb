require 'net/http'

When /^I sign in as ucarroll with her password$/ do
  uri = URI.parse("http://pasta.lternet.edu/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  request.basic_auth('uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org', password_for('ucarroll'))
  @res = http.request request
  @auth = @res.response['set-cookie']
end

When /^I sign in as "([^"]*)" with password "([^"]*)"$/ do |user, password|
  @resource = RestClient::Resource.new("http://pasta.lternet.edu/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", 
                                       :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", 
                                       :password => password)
  @res = @resource.get {|response, request, result| response }
end

When /^I read the document with the authentication cookie$/ do
  uri = URI.parse("http://pasta.lternet.edu/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  request['Cookie'] = @auth
  @res = http.request request
end

When /^I wait for the auth\-token to expire$/ do
  sleep 65  #timeout is set for 60 seconds
end

When /^I read the document with a modified authentication cookie$/ do
  uri = URI.parse("http://pasta.lternet.edu/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  @auth = @auth[15].succ
  request['Cookie'] = @auth
  @res = http.request request
end
