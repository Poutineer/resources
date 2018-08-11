module V1
  class AllergiesController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Allergy))

      realization = JSONAPI::Realizer.index(
        Allergies::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Allergy),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Allergies::ShowSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Allergy),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end
