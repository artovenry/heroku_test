require "sinatra/base"
require "rack-protection"
require "sinatra/json"
require "yaml"
require "erb"
require "active_record"


class ApplicationBase < Sinatra::Base
  set :environments, %w{development test production staging}

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
    require "sinatra/cross_origin"
    register Sinatra::CrossOrigin
    enable  :cross_origin
    disable :protection
    # logfile= File.join(root, "log/db.log")
    # ActiveRecord::Base.logger = Logger.new(logfile)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  configure :staging do
    require "sinatra/cross_origin"
    register Sinatra::CrossOrigin
    enable  :cross_origin
    set :allow_origin, "http://test.artovenry.com"
  end


  # if settings.development?
  #   options "*" do
  #     response.headers["Access-Control-Allow-Origin"] = "*"
  #     response.headers["Access-Control-Allow-Credentials"] = "true"
  #     response.headers["Access-Control-Allow-Methods"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  #     response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  #     200
  #   end
  # end
  root= File.expand_path "..", __FILE__
  config= YAML.load(ERB.new(File.read(File.join(root, "database.yml"))).result)
  ActiveRecord::Base.configurations= config
  ActiveRecord::Base.default_timezone= :local
  ActiveRecord::Base.establish_connection environment.to_sym
end
