module V1
  class DietsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "diets"
    )

    def index
      authorize(policy_scope(Diet))

      realization = JSONAPI::Realizer.index(
        Diets::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Diet),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Diets::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Diet),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end
  end
end
