import {setupRails} from "application";
import {setupFlashAlerts} from "alert";

setupRails()

// Set up JS that depends on only DOM being fully loaded.
// Use `turbolinks:load` instead of DOMContentLoaded to work with Turbolinks
document.addEventListener('turbolinks:load', () => {
    setupFlashAlerts()
})

// Set up JS that depends on site/window being fully loaded
// window.addEventListener('load', () => {
//
// })