if Rails.env.production?
  Figaro.require_keys("AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_BUCKET_NAME", "FOG_DIRECTORY",
                    #"EMAIL_USER", "EMAIL_PASS", "EMAIL_HOST", "EMAIL_PORT",
                    #"STRIPE_SECRET_KEY", "STRIPE_PUBLISHABLE_KEY"
                    )
end