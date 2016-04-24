require 'sinatra'
require 'json'
require 'pusher'

pusher_client = Pusher::Client.new({
  app_id: ENV["PUSHER_ID"],
  key: ENV["PUSHER_KEY"],
  secret: ENV["PUSHER_SECRET"],
  encrypted: true
})

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/github' do
  event = JSON.parse(request.body.read)
  user = event["sender"]["login"]
  verb = event["action"]
  pr_title = event["pull_request"]["title"]

  message = "#{user} just #{verb} PR '#{pr_title}' on your repo"

  pusher_client.trigger('test_channel', 'my_event', {
    title: "Pusher<->Github",
    message: message
  })
end