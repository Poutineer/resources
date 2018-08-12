class Answer < ApplicationRecord
  include(Moderated)

  belongs_to(:question, :touch => true)
  has_many(:critiques, :dependent => :destroy)

  validates_presence_of(:body)
end
