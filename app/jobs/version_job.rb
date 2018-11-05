class VersionJob < ApplicationJob
  sidekiq_options(:queue => "versions", :unique_across_queues => true, :lock => :until_executed, :log_duplicate_payload => true)

  def perform(version_class, attributes, event)
    version = version_class.constantize.create!(attributes)

    unless event == :create && version.errors.any?
      log_version_errors(version, event)
    end
  end

  def log_version_errors(version, action)
    version.logger&.warn(
      "Unable to create version for #{action} of #{version.item.class.name}" \
        "##{version.item.id}: " + version.errors.full_messages.join(", ")
    )
  end
end
