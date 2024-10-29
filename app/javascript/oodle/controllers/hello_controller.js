import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello engine!"
    console.log("hi, again from hello controller connect")
  }

  hi(e) {
    e.preventDefault()
    alert("hi, i'm your engine")
    console.log("hi, again from function")
  }
}