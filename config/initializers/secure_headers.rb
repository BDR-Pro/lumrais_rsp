SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(strict-origin-when-cross-origin)
  
  # Content Security Policy
  config.csp = {
    default_src: %w('self'),
    script_src: %w('self' 'unsafe-inline' 'unsafe-eval'),
    style_src: %w('self' 'unsafe-inline'),
    img_src: %w('self' data: https:),
    font_src: %w('self' data: https:),
    object_src: %w('none'),
    media_src: %w('self'),
    frame_src: %w('none'),
    sandbox: %w(allow-forms allow-scripts allow-same-origin allow-popups),
    report_uri: %w(/csp_report)
  }

  # HSTS
  config.hsts = "max-age=#{1.year.to_i}; includeSubDomains; preload"
end 