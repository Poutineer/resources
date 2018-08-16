namespace :docs do
  namespace :origin do
    desc "Generates documentation for the origin service based on production instance"
    task :generate do
      require "uri"
      require "addressable/uri"
      require "net/http"

      url = URI("https://origin.poutineer.com/v1/jsonapi-home-resources")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["accept"] = "application/vnd.api+json"

      resource_mapping = Oj.load(http.request(request).read_body)
        .fetch("data")
        .map {|resource| resource.fetch("attributes") }
        .select {|resource| resource.fetch("version") == ENV["VERSION"] || "v1"}
        .map {|attributes| attributes.transform_keys(&:underscore)}
        .group_by {|attributes| attributes.fetch("namespace")}

      resource_mapping
        .each do |namespace, collection|
          template = ERB.new(File.read(Rails.root.join("docs", "_resource.md.erb")), nil, "%<>")
          data = {
            collection: collection,
            updated_at: Time.now.iso8601,
            namespace: namespace
          }
          File.write(Rails.root.join("docs", "#{namespace}.md"), template.result_with_hash(data))
        end

      namespaces = resource_mapping
        .keys

      template_filename = Rails.root.join("docs", "_toc.md.erb")
      template = ERB.new(File.read(template_filename), nil, "%<>")
      File.write(Rails.root.join("docs", "SUMMARY.md"), template.result_with_hash({namespaces: namespaces}))
    end
  end
end
