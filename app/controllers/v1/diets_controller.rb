module V1
  class DietsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Diet))

      realization = JSONAPI::Realizer.index(
        Diets::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Diet),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Diets::ShowSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Diet),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end
