// import * as ActiveStorage from "@rails/activestorage"
//
// import {setupFlashAlerts} from "alert";
// import {setupMultiImgSync, setupSingleImgSync} from "images";
// import {DRAGGABLE_LIST_SELECTOR, setupDraggableList} from "recipes";
// import {setupRails} from "application";
//
// setupRails()
// ActiveStorage.start()
//
// // Set up JS that depends on only DOM being fully loaded.
// // Use `turbolinks:load` instead of DOMContentLoaded to work with Turbolinks
// document.addEventListener('turbolinks:load', () => {
//     setupFlashAlerts();
//     setupSingleImgSync(
//         '.synced-single-img.recipe-primary-picture',
//         '.synced-img.recipe-profile-img',
//         '.cancel-primary-picture-upload-btn'
//     );
//     setupMultiImgSync(
//         '#recipe_gallery_pictures',
//         '#new_resource_images',
//         '.cancel-gallery-upload-btn'
//     );
//     setupDraggableList(DRAGGABLE_LIST_SELECTOR);
// })
//
// // Set up JS that depends on site/window being fully loaded
// // window.addEventListener('load', () => {
// //
// // })