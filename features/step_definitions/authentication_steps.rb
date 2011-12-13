require 'base64'

When /^I sign in as "([^"]*)" with password "([^"]*)"$/ do |user, password|
  @resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", :password => password)
  @res = @resource.get {|response, request, result| response }
end

When /^I read the document with the authentication cookie$/ do
  @res = @resource.get {|response, request, result| response }
end

When /^I modify the authorization code$/ do
  auth = @res.cookies['auth-token'].to_s
  auth[4] = auth[4]++ # I don't need to to this since rest-client munges user token by changing + to spaces and _ to -
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :cookies => {'auth-token' => auth})
  @res = resource.get {|response, request, result| response }
end

When /^I wait for the auth\-token to expire$/ do
  sleep 10 * 60 + 1
end
