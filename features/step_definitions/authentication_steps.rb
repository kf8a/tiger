When /^I read the document as "([^"]*)" with "([^"]*)"$/ do |user, password|
  resource = RestClient::Resource.new("http://pasta.lternet.edu/gatekeeper/package/eml/#{@eml.scope}/#{@eml.id}/#{@eml.rev}", :user=>"uid=#{@user},o=LTER,dc=ecoinformatics,dc=org", :password => password)
  @res = resource.get {|response, request, result| response }
  @res.code.should == 200
end
