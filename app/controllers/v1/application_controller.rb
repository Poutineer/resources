module V1
  class ApplicationController < ::ApplicationController
    include(Pundit)
    include(JSONAPI::Realizer::Controller)
    include(JSONAPI::Materializer::Controller)

    after_action(:verify_authorized)
    after_action(:verify_policy_scoped)

    private def pundit_user
      current_account
    end

    private def upsert_parameter(tree, parameters)
      tree.reduce(parameters) do |accumulated_parameters, (keychain, mapping)|
        mapping.reduce(accumulated_parameters) do |accumulated_mapping, (before, after)|
          if accumulated_mapping.dig(*keychain) == before
            accumulated_mapping.deep_merge(
              keychain.reverse.reduce(after) do |accumulated, key|
                {key => accumulated}
              end
            )
          else
            accumulated_mapping
          end
        end
      end
    end
  end
end
