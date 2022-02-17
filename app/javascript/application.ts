// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"
import * as ActiveStorage from "@rails/activestorage"
import "./controllers"
import {setupTrix} from "trix";

// // Set up JS that depends on only DOM being fully loaded.
// // Use `turbolinks:load` instead of DOMContentLoaded to work with Turbolinks
document.addEventListener('turbo:load', () => {
    ActiveStorage.start();
    setupTrix();
})

// Set up JS that depends on Trix Rich Content Editor having initialized
document.addEventListener('trix-initialize', (_event: Event) => {
    setupTrix();
})

// // Set up JS that depends on site/window being fully loaded
// // window.addEventListener('load', () => {
// //
// // })