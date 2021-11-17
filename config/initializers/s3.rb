LAZY_KITCHEN_BUCKET = 'lazy-kitchen'

if Rails.env.production?
  RESOURCE_BUCKET_PREFIX = 'resources/public'
else
  RESOURCE_BUCKET_PREFIX = 'resources/dev'
end
