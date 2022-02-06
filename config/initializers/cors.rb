# TODO configure properly for production
unless Rails.env.production?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://www.alazykitchen.com:443', 'http://www.alazykitchen.com:80'
      resource '*',
               headers: :any,
               methods: [:get, :post, :patch, :put, :delete]
    end
  end
end
