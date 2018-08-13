module V1
  class ReviewsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "reviews"
    )

    def index
      authorize(policy_scope(Review))

      realization = JSONAPI::Realizer.index(
        Reviews::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Review),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Reviews::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Review),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    def create
      realization = JSONAPI::Realizer.create(
        Reviews::CreateSchema.new(request.parameters),
        :scope => policy_scope(Review),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        Reviews::UpdateSchema.new(request.parameters),
        :scope => policy_scope(Review),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end

    def destroy
      # realization = JSONAPI::Realizer.destroy(
      #   Reviews::DestroySchema.new(request.parameters)
      # )
    end
  end
end
