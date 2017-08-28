# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    username { |n| Faker::Name.name }
    password { |p| Faker::Internet.password }

    factory :thai do
      username 'thai'
      password 'password'
    end

    factory :other do
      username 'other'
      password 'password'
    end
  end
end
