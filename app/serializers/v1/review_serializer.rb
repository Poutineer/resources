module V1
  class ReviewSerializer < ApplicationSerializer
    has_one(:account, if: policy_allows_relation?(:account))

    attribute(:body, if: policy_allows_attribute?(:body))
    attribute(:moderation_state, if: policy_allows_attribute?(:moderation_state))
  end
end
