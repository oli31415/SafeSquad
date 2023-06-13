import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="alarm-subscription"
export default class extends Controller {
  static values = { user: Number }

  connect() {
    // console.log("connecteddddddd");

    this.channel = createConsumer().subscriptions.create(
      { channel: "AlarmChannel" },
      { received: data => {
        console.log(data)
        if (this.userValue != data.user_id) {
          window.location.href = data.url
        }
      }}
    )
    // console.log(this.userValue);
  }

  disconnect() {
    // console.log("disconnect");

    this.channel.unsubscribe()
  }
}
