require './webhook'

#set :environment, :production

log = File.new("/dev/stdout", "a")
log.sync = true
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
