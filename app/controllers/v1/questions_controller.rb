module V1
  class QuestionsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def show
      realization = JSONAPI::Realizer.show(
        Questions::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Question),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end
