module V1
  class EstablishmentsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Establishment))

      realization = JSONAPI::Realizer.index(
        Establishments::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Establishment),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Establishments::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Establishment),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    def create
      realization = JSONAPI::Realizer.create(
        Establishments::CreateSchema.new(request.parameters),
        :scope => policy_scope(Establishment),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        Establishments::UpdateSchema.new(request.parameters),
        :scope => policy_scope(Establishment),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end
  end
end
