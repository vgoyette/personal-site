import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.syncFromPreference()
  }

  toggle() {
    const next = this.isDark() ? "light" : "dark"
    this.apply(next)
    localStorage.setItem("theme", next)
  }

  syncFromPreference() {
    const stored = localStorage.getItem("theme")
    if (stored === "light" || stored === "dark") {
      this.apply(stored)
      return
    }

    const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches
    this.apply(prefersDark ? "dark" : "light")
  }

  apply(theme) {
    document.documentElement.classList.toggle("dark", theme === "dark")
    document.documentElement.style.colorScheme = theme
  }

  isDark() {
    return document.documentElement.classList.contains("dark")
  }
}
