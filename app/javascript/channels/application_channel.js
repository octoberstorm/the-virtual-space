import consumer from "./consumer"
import * as Turbo from "@hotwired/turbo"

const commonHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
  'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml',
  'X-Requested-With': 'XMLHttpRequest'
}

consumer.subscriptions.create("ApplicationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('=====connected======')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    op = data['op'];
    console.log('=====received======', data)
    if (data['op'] == 'post_created') {
      getPost(data.post)
    }

    // TODO: commented removed
    if (op == "comment_created") {
      getComment(data.comment);
    }

    if (op == "like_count_update") {
      updateLikes(data.post_id);
    }
  }

});

const getPost = async (post) => {
  broadcaster = post.author.id;
  try {
    const response = await fetch(`/posts/${post.id}?from_broadcasting=true&broadcaster=${broadcaster}`, {
      method: 'GET',
      headers: commonHeaders,
    });

    console.log('response======', response)

    if (response.ok) {
      const content = await response.text();
      Turbo.renderStreamMessage(content);
    } else {
      console.error('Failed to get post.');
    }
  } catch (error) {
    console.error('Error occurred while getting new post:', error);
  }
}

const getComment = async (comment) => {
  broadcaster = comment.author.id;
  try {
    const response = await fetch(`/comments/${comment.id}?from_broadcasting=true&broadcaster=${broadcaster}`, {
      method: 'GET',
      headers: commonHeaders,
    });

    console.log('response======', response)

    if (response.ok) {
      const content = await response.text();
      Turbo.renderStreamMessage(content);
    } else {
      console.error('Failed to get comment.');
    }
  } catch (error) {
    console.error('Error occurred while getting new comment:', error);
  }
}

const updateLikes = async (post_id) => {
  try {
    const response = await fetch(`posts/${post_id}/likes_count`, {
      method: 'GET',
      headers: commonHeaders,
    });

    console.log('response======', response)

    if (response.ok) {
      const content = await response.text();
      Turbo.renderStreamMessage(content);
    } else {
      console.error('Failed to update likes.');
    }
  } catch (error) {
    console.error('Error occurred while updating likes:', error);
  }
}
