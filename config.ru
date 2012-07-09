require './modules/site'

map '/' do
  run Site.new
end


