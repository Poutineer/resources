module V1
  class SearchesController < ::V1::ApplicationController

    def show
      realization = JSONAPI::Realizer.show(
        Searches::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Search),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end
