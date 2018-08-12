module V1
  class RecipeSerializer < ApplicationSerializer
    has_one(:account, :if => policy_allows_relation?(:account))

    attribute(:body, :if => policy_allows_attribute?(:body))
    attribute(:ingredients, :if => policy_allows_attribute?(:ingredients))
    attribute(:instructions, :if => policy_allows_attribute?(:instructions))
    attribute(:cook_time, :if => policy_allows_attribute?(:cook_time))
    attribute(:prep_time, :if => policy_allows_attribute?(:prep_time))
    attribute(:moderation_state, :if => policy_allows_attribute?(:moderation_state))
  end
end
