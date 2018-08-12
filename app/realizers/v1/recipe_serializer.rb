module V1
  class RecipeRealizer
    include(JSONAPI::Realizer::Resource)
    include(Pundit)

    register(:recipies, :class_name => "Recipe", :adapter => :active_record)

    has_one(:account, :as => :account)

    has(:name)
    has(:body)
    has(:ingredients)
    has(:instructions)
    has(:moderation_state)
    has(:cook_time)
    has(:prep_time)
  end
end
