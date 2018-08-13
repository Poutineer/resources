module V1
  class RecipesController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "recipes"
    )

    def index
      authorize(policy_scope(Recipe))

      realization = JSONAPI::Realizer.index(
        Recipes::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Recipe),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Recipes::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Recipe),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    def create
      realization = JSONAPI::Realizer.create(
        Recipes::CreateSchema.new(request.parameters),
        :scope => policy_scope(Recipe),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        Recipes::UpdateSchema.new(request.parameters),
        :scope => policy_scope(Recipe),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end

    def destroy
      # realization = JSONAPI::Realizer.destroy(
      #   Recipes::DestroySchema.new(request.parameters)
      # )
    end
  end
end
