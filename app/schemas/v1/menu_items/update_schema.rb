module V1
  module MenuItems
    class UpdateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:data, :type => Strict::Hash) do
          field(:id, :type => Coercible::String)
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash) do
            field(:name, :type => Strict::String.optional)
            field(:body, :type => Strict::String.optional)
            field(:moderation_state_event, :type => Strict::String.optional)
          end
        end
        field(:meta, :type => Strict::Hash.optional)
        field(:included, :type => Strict::Array.optional)
        field(:fields, :type => Strict::Array.of(Strict::String).optional)
        field(:include, :type => Strict::Array.of(Strict::String).optional)
      end
    end
  end
end
