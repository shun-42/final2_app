# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
# bin/importmap pin raty-js コマンドで下記にraty.jsがdownload される
# vendor/javascript/raty-js.js via download from https://ga.jspm.io/npm:raty-js@4.3.0/src/raty.js
pin "raty-js" # @4.3.0
# 自作のratyラッパーをimportmapに登録
pin "custom/raty", to: "custom/raty.js"
pin "script"