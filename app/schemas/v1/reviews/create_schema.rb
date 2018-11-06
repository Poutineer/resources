module V1
  module Reviews
    class CreateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:id, :type => Coercible::String.optional)
        field(:data, :type => Strict::Hash) do
          field(:id, :type => Coercible::String.optional)
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash.optional) do
            field(:body, :type => Strict::String)
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
