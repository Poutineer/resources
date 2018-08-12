class Review < ApplicationRecord
  include(Moderated)

  belongs_to(:author, :class_name => "Account")
  belongs_to(:menu_item)
  has_many(:critiques, :dependent => :destroy)

  Gutentag::ActiveRecord.(self)
end
