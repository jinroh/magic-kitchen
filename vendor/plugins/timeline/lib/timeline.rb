require "timeline/redis"
require "timeline/event"
require "timeline/target"
require "timeline/user"
require "timeline/user/followers"
require "timeline/user/recommandations"

module Timeline
  extend Timeline::Redis
  
end