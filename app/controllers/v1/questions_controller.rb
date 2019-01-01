module V1
  class QuestionsController < ::V1::ApplicationController

    def show
      realization = JSONAPI::Realizer.show(
        Questions::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Question),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end
  end
end
