// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// // Set up JS that depends on only DOM being fully loaded.
// // Use `turbolinks:load` instead of DOMContentLoaded to work with Turbolinks
// document.addEventListener('turbo:load', () => {
//
// })

// // Set up JS that depends on site/window being fully loaded
// // window.addEventListener('load', () => {
// //
// // })