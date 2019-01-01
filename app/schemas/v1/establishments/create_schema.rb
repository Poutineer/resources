module V1
  module Establishments
    class CreateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:id, :type => Coercible::String.optional)
        field(:data, :type => Strict::Hash) do
          field(:id, :type => Coercible::String.optional)
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash.optional) do
            field(:name, :type => Strict::String)
            field(:google_places_id, :type => Strict::String)
            field(:moderation_state_event, :type => Strict::String)
          end
        end
        field(:meta, :type => Strict::Hash.optional)
        field(:included, :type => Strict::Array.optional)
        field(:fields, :type => Strict::Hash.map(Strict::String, Strict::String).optional)
        field(:include, :type => (Strict::String || Strict::Array.of(Strict::String)).optional)
      end
    end
  end
end
