require "timeline/event"
require "timeline/target"
require "timeline/user"
require "timeline/user/followers"

raise "$redis isn't defined" unless defined?($redis)
