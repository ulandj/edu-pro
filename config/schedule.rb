# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, '/home/ulan/RubymineProjects/mini_veeqo/shopify_gateway_ruby/cron_log.log'

every 5.minutes do
  rake 'shopify_gateway:enqueue_job_for_pulling_store_settings'
end

every 1.hour do
  rake 'shopify_gateway:enqueue_job_for_pulling_products'
end
