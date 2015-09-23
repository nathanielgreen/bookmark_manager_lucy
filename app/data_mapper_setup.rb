require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
# DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

require 'dm-validations'
require './app/models/link' # require each model individually - the path may vary depending on your file structure.
require './app/models/tag'
require './app/models/user'

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

# postgres://localhost/bookmark_manager_#{env}

# postgres://ydnmkhwuegqofi:1uzRYR10EmV1wTtfa06BauBnBS@ec2-50-16-238-141.compute-1.amazonaws.com:5432/d96l2h8fum2a9c"
