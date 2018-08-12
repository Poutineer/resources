module V1
  class AllergySerializer < ApplicationSerializer
    has_many(:menu_items, :if => policy_allows_relation?(:menu_items), &policy_scoped(:menu_items))
    attribute(:name, :if => policy_allows_attribute?(:name))
  end
end
