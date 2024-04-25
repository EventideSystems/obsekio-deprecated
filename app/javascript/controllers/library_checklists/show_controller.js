import { Controller } from "@hotwired/stimulus"
import { Editor } from '@toast-ui/editor'

export default class extends Controller {

  static targets = ["previewPanel", "detailsPanel"]

  connect() {
    const content = this.previewPanelTarget.querySelector('.markdown').innerHTML;

    const viewer = new Editor.factory({
      el: document.querySelector('#viewer'),
      viewer: true,
      height: '500px',
      initialValue: content
    });
  }

  showPanel(event, panelToShow, panelsToHide) {
    event.preventDefault();

    panelsToHide.forEach(function(panel) {
      panel.classList.add('hidden');
    });

    panelToShow.classList.remove("hidden");
    this.removeIndigoFromLinks(event);
    event.target.classList.add('text-indigo-400');
  }

  showPreviewPanel(event) {
    this.showPanel(event, this.previewPanelTarget, [this.detailsPanelTarget]);
  }

  showDetailsPanel(event) {
    this.showPanel(event, this.detailsPanelTarget, [this.previewPanelTarget]);
  }

  removeIndigoFromLinks(event) {
    event.target.parentNode.parentNode.querySelectorAll('a').forEach(function(link) {
      link.classList.remove('text-indigo-400');
    });
  }
}
