import { Controller } from "@hotwired/stimulus"
import { marked } from 'marked'

export default class extends Controller {

  static targets = ["writePanel", "detailsPanel", "previewPanel"]

  showPanel(event, panelToShow, panelsToHide) {
    event.preventDefault();

    panelsToHide.forEach(function(panel) {
      panel.classList.add('hidden');
    });

    panelToShow.classList.remove("hidden");
    this.removeIndigoFromLinks(event);
    event.target.classList.add('text-indigo-400');
  }

  showWritePanel(event) {
    this.showPanel(event, this.writePanelTarget, [this.detailsPanelTarget, this.previewPanelTarget]);
  }

  showDetailsPanel(event) {
    this.showPanel(event, this.detailsPanelTarget, [this.writePanelTarget, this.previewPanelTarget]);
  }

  showPreviewPanel(event) {
    this.showPanel(event, this.previewPanelTarget, [this.writePanelTarget, this.detailsPanelTarget]);

    const markdown = this.writePanelTarget.querySelector('textarea').value;
    debugger
    this.previewPanelTarget.querySelector('.markdown').innerHTML = marked(markdown);
  }

  removeIndigoFromLinks(event) {
    event.target.parentNode.parentNode.querySelectorAll('a').forEach(function(link) {
      link.classList.remove('text-indigo-400');
    });
  }
}
