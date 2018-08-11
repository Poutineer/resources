module V1
  class MenuItemsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(MenuItem))

      realization = JSONAPI::Realizer.index(
        MenuItems::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(MenuItem),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        MenuItems::ShowSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(MenuItem),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    def create
      realization = JSONAPI::Realizer.create(
        MenuItems::CreateSchema.new(request.parameters),
        :scope => policy_scope(MenuItem),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        MenuItems::UpdateSchema.new(modified_parameters),
        :scope => policy_scope(MenuItem),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end
  end
end
