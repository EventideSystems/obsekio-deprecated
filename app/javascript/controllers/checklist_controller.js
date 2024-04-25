import { Controller } from "@hotwired/stimulus"
import { Editor } from '@toast-ui/editor'

export default class extends Controller {
  static values = {
    instanceId: String
  }

  static targets = ["previewPanel"]

  connect() {
    const content = this.previewPanelTarget.querySelector('.markdown').innerHTML;

    const viewer = new Editor.factory({
      el: document.querySelector('#viewer'),
      viewer: true,
      height: '500px',
      initialValue: content
    });

    const taskListItems = document.querySelectorAll('.toastui-editor-contents .task-list-item')

    Array.from(taskListItems).forEach(function(taskListItem) {
      taskListItem.setAttribute('data-action', 'click->checklist#toggle')
    });
  }

  toggle(event) {
    let csrfToken = document.querySelector('meta[name="csrf-token"]').content
    let instanceId = this.instanceIdValue
    let taskListItem = event.target
    let checked = taskListItem.classList.contains('checked')
    let index = Array.from(document.querySelectorAll('.toastui-editor-contents .task-list-item')).indexOf(taskListItem);
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
