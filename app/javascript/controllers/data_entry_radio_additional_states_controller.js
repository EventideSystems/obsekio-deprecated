import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "entries" ]

  addEntry(event) {
    event.preventDefault();

    let index = this.entriesTarget.children.length;
    let content = document.getElementById('state-template').content.cloneNode(true);

    // content.querySelector('label').setAttribute('for', `checklist_data_entry_radio_additional_states_${index}_text`);
    // content.querySelector('label').textContent = `State ${index + 1}`;

    // let input = content.querySelector('input');
    // input.setAttribute('name', `checklist[data_entry_radio_additional_states][${index}][text]`);
    // input.setAttribute('id', `checklist_data_entry_radio_additional_states_${index}_text`);

    this.entriesTarget.appendChild(content);
  }
}
