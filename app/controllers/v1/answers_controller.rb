module V1
  class AnswersController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def show
      realization = JSONAPI::Realizer.show(
        Answers::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Answer),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end
