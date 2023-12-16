class ApplicationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "global_updates"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
