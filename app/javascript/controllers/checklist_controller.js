import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    instanceId: String
  }

  connect() {
    Array.from((this.element).querySelectorAll("input[type='checkbox']")).forEach(function(checkbox) {
      checkbox.setAttribute('data-action', 'click->checklist#toggle')
      checkbox.disabled = false
    });
  }

  toggle(event) {
    let csrfToken = document.querySelector('meta[name="csrf-token"]').content
    let instanceId = this.instanceIdValue
    let checkbox = event.target
    let checked = checkbox.checked
    let index = Array.from(this.element.querySelectorAll('input[type="checkbox"]')).indexOf(checkbox);
    let url = `/checklist_instances/${instanceId}/checklist_items/${index}`
    let data = { checklist_item: { checked: checked } }
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
