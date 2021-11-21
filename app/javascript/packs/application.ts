// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import {setupFlashAlerts} from "alert";
import {DRAGGABLE_LIST_SELECTOR, setupDraggableList, setupMultiImgSync, setupSingleImgSync} from "recipes";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Set up JS that depends on only DOM being fully loaded
document.addEventListener('DOMContentLoaded', () => {
    setupFlashAlerts();
    setupSingleImgSync('.synced-single-img.recipe-primary-picture', '.synced-img.recipe-profile-img');
    setupMultiImgSync('#recipe_gallery_pictures', '#new_resource_images');
    setupDraggableList(DRAGGABLE_LIST_SELECTOR);
})

// Set up JS that depends on site/window being fully loaded
// window.addEventListener('load', () => {
//
// })