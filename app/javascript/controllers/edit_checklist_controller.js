import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "selectInputType", "radioControl", "checkboxControl" ]

  connect() {
    this.toggleControls(this.selectInputTypeTarget.value)
  }

  selectInputTypeChanged(event) {
    this.toggleControls(event.target.value)
  }

  toggleControls(value) {
    if (value === "radio" || value === "radio_dialog_plus_comments") {
      this.checkboxControlTargets.forEach(element => {
        element.classList.add("hidden")
      })

      this.radioControlTargets.forEach(element => {
        element.classList.remove("hidden")
      })
    } else {
      this.checkboxControlTargets.forEach(element => {
        element.classList.remove("hidden")
      })

      this.radioControlTargets.forEach(element => {
        element.classList.add("hidden")
      })
    }
  }
}
