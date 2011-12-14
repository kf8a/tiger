Then /^it succeeds$/ do
  @res.code.to_i.should == 200
end

Then /^it fails with a server error$/ do
  @res.code.to_i.should == 500
end

Then /^it fails with unauthorized$/ do
  @res.code.to_i.should == 401
end

Then /^it fails due to a conflict$/ do
  @res.code.to_i.should == 409
end
