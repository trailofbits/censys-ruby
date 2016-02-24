module CenSys
  class ResponseError < RuntimeError
  end

  class AuthenticationError < ResponseError
  end

  class NotFound < ResponseError
  end

  class RateLimited < ResponseError
  end

  class InternalServerError < ResponseError
  end
end
