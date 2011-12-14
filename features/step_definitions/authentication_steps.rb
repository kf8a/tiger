When /^I sign in as ucarroll with her password$/ do
  @resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", 
                                       :user=>"uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org", 
                                       :password => password_for('ucarroll'))
  @res = @resource.get {|response, request, result| response }
  @auth = @res.cookies['auth-token']
end

When /^I sign in as "([^"]*)" with password "([^"]*)"$/ do |user, password|
  @resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", 
                                       :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", 
                                       :password => password)
  @res = @resource.get {|response, request, result| response }
end

When /^I read the document with the authentication cookie$/ do
  # TODO: this does not do anything yet unless I figure out how to remove the Authentication header. Maybe i'll need to use a lower level library
  @res = @resource.get {|response, request, result| response }
end

When /^I wait for the auth\-token to expire$/ do
  sleep 60 + 1 #timeout is set for 60 seconds
end

When /^I read the document with a modified authentication cookie$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :cookies=> {'auth-token'=>@auth})
  @res = resource.get {|response, request, result| response }
end
