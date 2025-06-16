class Rack::Attack
  # Store the number of requests by IP address
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  # Throttle login attempts by IP address
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.ip
    end
  end

  # Throttle API requests by IP address
  throttle('api/ip', limit: 100, period: 1.minute) do |req|
    if req.path.start_with?('/api/')
      req.ip
    end
  end

  # Block suspicious requests
  blocklist('block suspicious requests') do |req|
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 5, findtime: 1.minute, bantime: 1.hour) do
      req.path.include?('/wp-admin') || req.path.include?('/wp-login')
    end
  end

  # Log blocked requests
  self.blocklisted_response = lambda do |env|
    [ 403, { 'Content-Type' => 'application/json' }, [{ error: 'Blocked' }.to_json] ]
  end
end 