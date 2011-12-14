require 'yaml'

module Passwords
  def password_for(user)
    passwords = YAML::load_file(File.expand_path('../../../passwords.yaml',__FILE__))
    passwords[user]
  end
end

World(Passwords)
