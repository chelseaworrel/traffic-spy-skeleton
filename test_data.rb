
def create_payloads(value)
  number = value.values[0]
  key    = value.keys[0]
  temp   = {}
  payloads = {}

  1.upto(number) do |n|
    temp[key] = n
  p  payload(temp)
  end
end

# sha = Payload.generate_sha(params.values.join)
# payload = params['payload']
# parser = ParamsParser.new(payload, sha)
# parser.parse

def payload(temp)
  num = temp.values[0]
  {
    :url              => "http://jumpstartlab.com/blog#{num}",
    :requestedAt      => "#{Time.new}",
    :respondedIn      => 37,
    :referredBy       => "http://jumpstartlab.com",
    :requestType      => "GET",
    :eventName        => "socialLogin",
    :userAgent        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)"\
    "AppleWebKit/537.17 (KHTML, like Gecko)"\
    "Chrome/24.0.1309.0 Safari/537.17",
    :resolutionWidth  => "1920",
    :resolutionHeight => "1280",
    :ip               => "63.29.38.211"
  }
end

create_payloads({url: 5})
