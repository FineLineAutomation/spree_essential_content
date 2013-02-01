# not sure why setting the request_uri doesn't also update @fullpath
def visit(path="/")
  @request.request_uri = path
  @request.instance_variable_set "@fullpath", path
  @request
end