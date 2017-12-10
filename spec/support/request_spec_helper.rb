module RequestSpecHelper
  def json
    JSON.parse(request.body)
  end
end
