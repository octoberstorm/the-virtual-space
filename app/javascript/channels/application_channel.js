import consumer from "./consumer"

consumer.subscriptions.create("ApplicationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected======')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received======', data)
    if (data['op'] == 'post_created') {
      console.log('post_created======', data)
    }
  }
});
