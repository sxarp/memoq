Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Note: The Access-Control-Allow-Origin header shall never show up unless the 'Origin' header
    # which is set in the requests is contained in the list passed to the 'origins' decralative.
    origins [%r{^(|http(|s)://)(localhost|0\.0\.0\.0)(|:[0-9]+)$}]
    resource "*",
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end
