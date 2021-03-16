web: bundle exec puma -p $PORT
jobs: bundle exec sidekiq -q active_storage_analysis -q active_storage_purge -q pc_subscriber -q orders -q mailers -q reports -q probes -q default
