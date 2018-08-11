module V1
  module Recipes
    class CreateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:id, :type => Coercible::String.optional)
        field(:data, :type => Strict::Hash) do
          field(:id, :type => Coercible::String.optional)
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash.optional) do
            field(:body, :type => Strict::String)
            field(:body, :type => Strict::String)
            field(:ingredients, :type => Strict::Array.of(Strict::String))
            field(:instructions, :type => Strict::Array.of(Strict::String))
            field(:cook_time, :type => Strict::Integer)
            field(:prep_time, :type => Strict::Integer)
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
