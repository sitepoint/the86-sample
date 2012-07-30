require "the86-client/active_model"

# The domain, and optionally port.
The86::Client.domain = "localhost:3000"

# The HTTP basic auth username and password for the API client.
The86::Client.credentials = ["sample", "sample"]

# Never do this.
The86::Client.disable_https!
