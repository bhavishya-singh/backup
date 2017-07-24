require 'aws-sdk'

Aws.config.update(
    credentials: Aws::Credentials.new(ENV['AWS_USER_KEY'], ENV['AWS_USER_KEY_PASS']),
    region: 'ap-south-1',
)

