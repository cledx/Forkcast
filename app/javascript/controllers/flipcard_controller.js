import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flipcard"
export default class extends Controller {
  flip(event) {
    if (event.target.classList.contains("front")) {
      event.currentTarget.classList.toggle("clicked");
      event.currentTarget.querySelector(".delete-dish-btn").classList.toggle("d-none")
    }
  }
}
