module V1
  class AccountRealizer < ApplicationRealizer
    type(:accounts, :class_name => "Account", :adapter => :active_record)

    has_many(:reviews, :class_name => "V1::ReviewRealizer")

    has(:email)
    has(:name)
    has(:username)
  end
end
