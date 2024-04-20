import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["previewPanel", "detailsPanel"]

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
    this.showPanel(event, this.previewPanelTarget, [tthis.detailsPanelTarget]);
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
