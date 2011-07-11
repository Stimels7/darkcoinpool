# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "zzeroo systems"
  user.email                 "pulp@zzeroo.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :bot do |bot|
  bot.ip_address            "192.168.100.10"
  bot.association :user
end

