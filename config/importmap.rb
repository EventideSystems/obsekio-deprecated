# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@toast-ui/editor", to: "@toast-ui--editor.js", preload: true # @3.2.2
pin "orderedmap" # @2.1.1
pin "prosemirror-commands" # @1.5.2
pin "prosemirror-history" # @1.4.0
pin "prosemirror-inputrules" # @1.4.0
pin "prosemirror-keymap" # @1.2.2
pin "prosemirror-model" # @1.21.1
pin "prosemirror-state" # @1.4.3
pin "prosemirror-transform" # @1.9.0
pin "prosemirror-view" # @1.33.8
pin "rope-sequence" # @1.3.4
pin "w3c-keyname" # @2.2.8
pin "tailwindcss-animate" # @1.0.7
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @3.4.4
pin "hotkeys-js" # @3.13.7
