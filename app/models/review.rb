class Review < ApplicationRecord
  include(Moderated)

  belongs_to(:author, :class_name => "Account")
  belongs_to(:reviewable, :polymorphic => true)
  has_many(:critiques, :dependent => :destroy)

  Gutentag::ActiveRecord.(self)

  validates_presence_of(:body)
end
