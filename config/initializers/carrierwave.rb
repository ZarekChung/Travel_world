CarrierWave.configure do |config|
config.fog_provider = 'fog/aws' # required
config.fog_credentials = {
provider: 'AWS', # required
aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], # required
aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
region: ENV['S3_BUCKET_REGION'], # optional, defaults to 'us-east-1'
default_url: ENV['DEFAULT_URL']
}
config.fog_directory = ENV['S3_BUCKET_NAME'] # required
config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end