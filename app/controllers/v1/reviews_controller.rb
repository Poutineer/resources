module V1
  class ReviewsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Review))

      realization = JSONAPI::Realizer.index(
        Reviews::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Review),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Reviews::ShowSchema.new(modified_parameters),
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
        Reviews::UpdateSchema.new(modified_parameters),
        :scope => policy_scope(Review),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end
  end
end
