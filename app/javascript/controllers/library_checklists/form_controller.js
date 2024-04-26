import { Controller } from "@hotwired/stimulus"
import { Editor } from '@toast-ui/editor'

export default class extends Controller {

  static targets = ["writePanel", "settingsPanel", "markdownContent"]


  connect() {
    const contentContainer = this.markdownContentTarget.querySelector('textarea')
    const content = contentContainer.value

    const editor = new Editor({
      el: document.querySelector('#editor'),
      previewStyle: 'vertical',
      height: '500px',
      initialValue: content,
      usageStatistics: false
    });

    // Update the markdown content when the editor loses focus. This is needed because the textarea is hidden and the editor is used instead.
    // It would probably be better to do this just before the form is submitted, but we can look at doing that later.
    editor.addHook('blur', function() {
      const markdown = editor.getMarkdown();
      contentContainer.value = markdown;
    });
  }

  showPanel(event, panelToShow, panelsToHide) {
    event.preventDefault();

    panelsToHide.forEach(function(panel) {
      panel.classList.add('hidden');
    });

    panelToShow.classList.remove("hidden");
    this.removeActiveMarkerFromLinks(event);
    event.target.classList.add('text-indigo-400');
  }

  showWritePanel(event) {
    this.showPanel(event, this.writePanelTarget, [this.settingsPanelTarget]);
  }

  showSettingsPanel(event) {
    this.showPanel(event, this.settingsPanelTarget, [this.writePanelTarget]);
  }

  removeActiveMarkerFromLinks(event) {
    event.target.parentNode.parentNode.querySelectorAll('a').forEach(function(link) {
      link.classList.remove('text-indigo-400');
    });
  }
}
