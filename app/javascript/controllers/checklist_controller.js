import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["commentsDialog", "commentsDialogCancelButton", "commentsDialogSaveButton", "commentsTextArea", "errorMessage"]

  static values = {
    instanceId: String,
    dataEntryComments: String
  }

  connect() {
    Array.from((this.element).querySelectorAll("input[type='checkbox'], input[type='radio']")).forEach(function(control) {
      control.setAttribute('data-action', 'click->checklist#toggle')
    });
  }

  toggle(event) {
    debugger

    let checked = event.target.checked
    let csrfToken = document.querySelector('meta[name="csrf-token"]').content
    let instanceId = this.instanceIdValue
    let control = event.target
    let value = control.checked ? control.value : null
    let index = control.dataset.itemIndex
    let url = `/checklist_instances/${instanceId}/checklist_items/${index}`
    let data = { checklist_item: { value: value } }

    let dataEntryComments = this.dataEntryCommentsValue

    if (dataEntryComments == 'required') {
      debugger
      event.preventDefault();

      let cancelDialogButtons = this.commentsDialogCancelButtonTargets
      let saveDialogButton = this.commentsDialogSaveButtonTarget

      const dialog = this.commentsDialogTarget

      this.commentsTextAreaTarget.value = ""

      this.errorMessageTarget.classList.add("hidden")
      dialog.classList.remove("hidden")

      const cancelComment = () => {
        dialog.classList.add("hidden")
        cancelDialogButtons.forEach(element => {
          element.removeEventListener("click", cancelComment)
        })
        saveDialogButton.removeEventListener("click", saveComment)
      }

      const saveComment = () => {
        let comment = this.commentsTextAreaTarget.value

        if (comment) {
          data['checklist_item']['comment'] = comment

          fetch(url, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify(data)
          })

          dialog.classList.add("hidden")
          cancelDialogButtons.forEach(element => {
            element.removeEventListener("click", cancelComment)
          })

          saveDialogButton.removeEventListener("click", saveComment)
          event.target.checked = checked
        } else {
          this.errorMessageTarget.classList.remove("hidden")
        }
      }

      cancelDialogButtons.forEach(element => {
        element.removeEventListener("click", cancelComment)
      })
      saveDialogButton.removeEventListener("click", saveComment)

      cancelDialogButtons.forEach(element => {
        element.addEventListener("click", cancelComment)
      })

      saveDialogButton.addEventListener("click", saveComment)
    } else {
      fetch(url, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(data)
      })
    }
  }
}
