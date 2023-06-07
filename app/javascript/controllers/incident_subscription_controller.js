import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="incident-subscription"
export default class extends Controller {
  connect() {
    console.log(`Subscribe to the chatroom with the id ${this.chatroomIdValue}.`)
  }
}

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages"]

  connect() {
    console.log(`Subscribe to the chatroom with the id ${this.chatroomIdValue}.`)
  }
}
