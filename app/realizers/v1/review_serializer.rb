module V1
  class ReviewRealizer
    include(JSONAPI::Realizer::Resource)
    include(Pundit)

    register(:reviews, :class_name => "Review", :adapter => :active_record)

    has_one(:author, as: :authors)
    has_one(:menu_item, as: :menu_items)
    has_many(:critiques, as: :critiques)

    has(:body)
    has(:moderation_state)
  end
end
