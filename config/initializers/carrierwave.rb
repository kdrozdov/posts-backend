CarrierWave.configure do |config|
  config.asset_host = Rails.application.config.uri.to_s
end
