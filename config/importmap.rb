# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@github/markdown-toolbar-element", to: "https://ga.jspm.io/npm:@github/markdown-toolbar-element@2.1.1/dist/index.js"
pin "marked" # @12.0.2
