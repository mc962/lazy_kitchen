// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import {setupFlashAlerts} from "alert";

// Set up JS that depends on only DOM being fully loaded.
// Use `turbolinks:load` instead of DOMContentLoaded to work with Turbolinks
document.addEventListener('turbo:load', () => {
    setupFlashAlerts();
    console.log('LOADED!!!');
})

// // Set up JS that depends on site/window being fully loaded
// // window.addEventListener('load', () => {
// //
// // })