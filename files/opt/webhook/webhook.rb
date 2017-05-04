#!/usr/bin/env ruby

require 'sinatra'
require 'json'

# User customization

#set :bind, '0.0.0.0'
#set :port, '8080'

post '/payload' do
  push = JSON.parse(request.body.read)
  logger.info("json payload: #{push.inspect}")

  repo_name   = push['repository']['name']
  repo_ref    = push['ref']
  ref_array   = repo_ref.split("/")
#  ref_type    = ref_array[1]
  branchName  = ref_array[2]
  logger.info("repo name = #{repo_name}")
  logger.info("repo ref = #{repo_ref}")
  logger.info("branch = #{branchName}")

  logger.info("Deploy r10k for this environment #{branchName}")
  deployEnv(branchName)
end

# Some defines.
def deployEnv(branchname)
  deployCmd = "scl enable rh-ruby23 \"r10k deploy environment #{branchname} -pv\""
  `#{deployCmd}`
end
