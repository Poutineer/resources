web: bin/web
release: bin/release
worker: bundle exec sidekiq --concurrency=5  --queue=google_places --queue=mailers --queue=versions
