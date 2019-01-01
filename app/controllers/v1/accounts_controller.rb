module V1
  class AccountsController < ::V1::ApplicationController
    def inline_jsonapi(model:, schema:, realizer:, materializer:, intent: nil, scope: nil, policy_scope_class: nil, parameters: nil, context: {})
      @intent = intent || @_action_name
      @schema = schema
      @parameters = @schema.new(parameters || request.parameters)
      @record_scope = scope || model
      @policy_scope = if policy_scope_class
        policy_scope(@record_scope, :policy_scope_class => policy_scope_class)
      else
        policy_scope(@record_scope)
      end
      @headers = request.headers
      @realizer = realizer
      @materializer = materializer
      @realization = @realizer.new(
        :intent => @intent,
        :parameters => @parameters,
        :headers => @headers,
        :scope => @policy_scope,
        :context => context || {}
      )

      if params.key?(:id)
        if block_given? then yield end

        authorize(@realization.object)

        return unless stale?(:etag => @realization.object)

        @materializer.new(
          **@realization,
          :context => context || {}
        )
      else
        if block_given? then yield end

        authorize(@policy_scope)

        @materializer.new(
          **@realization,
          :context => context || {}
        )
      end
    end

    def index
      render(
        :json => inline_jsonapi(
          :model => ::Account,
          :schema => ::V1::Accounts::IndexSchema,
          :realizer => ::V1::AccountRealizer,
          :materializer => ::V1::AccountMaterializer::Collection,
          :parameters => modified_parameters,
          :context => {
            :policy => ->(object) {AccountPolicy.new(current_account, object)}
          }
        )
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :model => ::Account,
          :schema => ::V1::Accounts::ShowSchema,
          :realizer => ::V1::AccountRealizer,
          :materializer => ::V1::AccountMaterializer,
          :parameters => modified_parameters,
          :context => {
            :policy => ->(object) {AccountPolicy.new(current_account, object)}
          }
        )
      )
    end

    def create
      realization = JSONAPI::Realizer.create(
        Accounts::CreateSchema.new(request.parameters),
        :scope => policy_scope(Account),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        Accounts::UpdateSchema.new(modified_parameters),
        :scope => policy_scope(Account),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"me" => if account_signed_in? then current_account.id end},
          ["data", "id"] => {"me" => if account_signed_in? then current_account.id end}
        },
        request.parameters
      )
    end
  end
end
