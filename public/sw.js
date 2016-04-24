importScripts("/pusher.worker.js");

Pusher.setLogger(function(log){
  console.log(log)
});

var pusher = new Pusher('1fb94680701ab31a3139', {
  encrypted: true,
  disableStats: true
});

var channel = pusher.subscribe('test_channel');

channel.bind('my_event', function(data) {
  self.registration.showNotification(data.title, {
    icon: 'https://avatars3.githubusercontent.com/u/739550?v=3&s=200',
    body: data.message
  });
});