class SidekiqServerLogTaggingMiddleware
  def call(worker, job, queue)
    Rails.logger.tagged("worker=#{worker.class.name}") do
      Rails.logger.tagged("queue=#{queue}") do
        Rails.logger.tagged("job=#{job.fetch("jid")}") do
          Rails.logger.tagged("group=#{job.fetch("session_id")}") do
            yield
          end
        end
      end
    end
  end
end