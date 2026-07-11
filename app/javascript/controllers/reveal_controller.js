import { Controller } from "@hotwired/stimulus"

// Ensures reveal animations re-run cleanly after Turbo visits when motion is allowed.
export default class extends Controller {
  static targets = ["item"]

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      this.itemTargets.forEach((el) => {
        el.style.opacity = "1"
        el.style.transform = "none"
        el.style.animation = "none"
      })
    }
  }
}
