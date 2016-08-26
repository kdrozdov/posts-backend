CarrierWave.configure do |config|
  config.asset_host = URI(ENV.fetch('POSTS_URI'))
end
