module CenSys
  class ResponseError < RuntimeError
  end

  class NotFound < ResponseError
  end

  class RateLimited < ResponseError
  end

  class InternalServerError < ResponseError
  end
end
