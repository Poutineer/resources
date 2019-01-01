module V1
  class ReviewRealizer < ApplicationRealizer
    include(JSONAPI::Realizer::Resource)

    type(:reviews, :class_name => "Review", :adapter => :active_record)

    has_one(:author, :class_name => "V1::AccountRealizer")

    has(:body)
  end
end
