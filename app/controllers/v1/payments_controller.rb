module V1
  class PaymentsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "payments"
    )

    def index
      realization = JSONAPI::Realizer.index(
        PaymentsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Payment),
        type: :payments
      )

      authorize policy_scope(Payment)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        PaymentsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Payment),
        type: :payments
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create
      ensure_account_exists
      authenticate_account!
      ensure_cart_exists

      realization = JSONAPI::Realizer.create(
        PaymentsCreateSchema.new(request.parameters).as_json,
        scope: policy_scope(Payment),
        headers: request.headers,
      )

      authorize realization.model

      PurchaseCartOperation.new.call(payments: [realization.model]) do |operation|
        operation.success do
          render json: serialize(realization)
        end

        operation.failure do |failure|
          raise failure
        end
      end
    end
  end
end
