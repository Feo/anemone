require "resque/tasks"

task "resque:setup" => :environment



#QUEUE=crawler_queue rake environment resque:work