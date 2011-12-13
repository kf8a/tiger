When /^I sign in as "([^"]*)" with password "([^"]*)"$/ do |user, password|
  @resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :user=>"uid=#{user},o=LTER,dc=ecoinformatics,dc=org", :password => password)
  @res = @resource.get {|response, request, result| response }
  @res.code.should == 200
  @auth = @res.cookies['auth-token']
end

When /^I read the document with the authentication cookie$/ do
  # TODO: this does not do anything yet unless I figure out how to remove the Authentication header. Maybe i'll need to use a lower level library
  @res = @resource.get {|response, request, result| response }
end

When /^I wait for the auth\-token to expire$/ do
  sleep 10 #* 60 + 1
end

When /^I read the document with a modified authentication cookie$/ do
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :cookies=> {'auth-token'=>@auth})
  @res = resource.get {|response, request, result| response }
end
