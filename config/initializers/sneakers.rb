require 'sneakers'

Sneakers.configure(
    heartbeat: 10,
    amqp: Rails.application.credentials[Rails.env.to_sym][:amqp_url],
    prefetch: 10,
    workers: ENV['WORKERS_COUNT'] ? ENV['WORKERS_COUNT'].to_i : 1,
    threads: ENV['WORKERS_THREADS'] ? ENV['WORKERS_THREADS'].to_i : 7,
    env: ENV['RACK_ENV'],
    durable: true
)

Sneakers.logger.level = Logger::DEBUG