import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "select" ]

  connect() {
    this.updateBackgroundColor()
  }

  updateBackgroundColor() {
    const color = this.selectTarget.value
    // Remove old background color class
    const oldColorClass = Array.from(this.selectTarget.classList).find(className => /^bg-\w+-500$/.test(className))
    if (oldColorClass) {
      this.selectTarget.classList.remove(oldColorClass)
    }

    // Add new background color class
    this.selectTarget.classList.add(this.bgColorClass(color))
  }

  bgColorClass(color) {
    return `bg-${color}-500`
  }

  change() {
    this.updateBackgroundColor()
  }
}
