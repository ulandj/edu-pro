require 'sneakers'
require 'sneakers/handlers/maxretry'

SNEAKERS_CONFIG = {
  heartbeat:         10,
  timeout_job_after: 5.minutes,
  amqp:              Rails.application.credentials[Rails.env.to_sym][:amqp_url],
  prefetch:          10,
  workers:           ENV['WORKERS_COUNT'] ? ENV['WORKERS_COUNT'].to_i : 5,
  threads:           ENV['WORKERS_THREADS'] ? ENV['WORKERS_THREADS'].to_i : 7,
  env:               ENV['RACK_ENV'],
  durable:           true
}.freeze

SNEAKERS_RETRY_CONFIG = SNEAKERS_CONFIG.merge(
  handler:         Sneakers::Handlers::Maxretry,
  retry_timeout:   5 * 1000,
  retry_max_times: 2
)

Sneakers.configure(SNEAKERS_CONFIG)

Sneakers.logger.level = Logger::DEBUG
