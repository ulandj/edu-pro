namespace :shopify_gateway do
  task enqueue_job_for_pulling_products: :environment do
    Channel.active.each(&:enqueue_job_for_pulling_products)
  end
end
