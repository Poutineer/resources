module V1
  class MenuItemsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "menu-items"
    )

    def index
      authorize(policy_scope(MenuItem))

      realization = JSONAPI::Realizer.index(
        MenuItems::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(MenuItem),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        MenuItems::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(MenuItem),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

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
        MenuItems::UpdateSchema.new(request.parameters),
        :scope => policy_scope(MenuItem),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end
  end
end
