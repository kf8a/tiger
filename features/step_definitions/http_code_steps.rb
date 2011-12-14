Then /^it succeeds$/ do
  @res.code.should == 200
end

Then /^it fails with a server error$/ do
  @res.code.should == 500
end

Then /^it fails with unauthorized$/ do
  @res.code.should == 401
end

Then /^it fails due to a conflict$/ do
  @res.code.should == 409
end
