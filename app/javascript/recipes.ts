import Sortable from 'sortablejs/modular/sortable.core.esm.js';

export const SYNCED_IMG_SRC_SELECTOR = '.synced-img-src';
export const DRAGGABLE_LIST_SELECTOR = '.draggable';

/**
 * Syncs image inputs with an img tag, such that when the input url changes, the img tag src is updated based on the
 * contents of the input
 * @param {string} selector A DOM selector that selects 1+ text input elements from the DOM that represent the input
 * elements that have images synced to them. These inputs are expected to have a `data-image-selector` attribute
 * attached to them, which should have a class selector that points at the img tag to sync with the input. At this time,
 * each input is expected to have at most 1 img tag synced to it.
 */
export const setupImageInputSync = (selector) => {
    const syncedEls = document.querySelectorAll(selector)

    syncedEls.forEach((el) => {
        syncInputImg(el)
    })
};

/**
 * Syncs an img tag to its corresponding input's `input` event
 * @param {HTMLInputElement} element Element to sync img tag to
 */
const syncInputImg = (element) => {
    // NOTE: Expected to be an HTML class
    const imgTagSelector = element.dataset.imageSelector;

    if (imgTagSelector) {
        const imgTag = document.querySelector(`${imgTagSelector}.synced-img`) as HTMLImageElement;
        if (imgTag) {
            element.addEventListener('input', (event: Event) => {
                const fileInput = event.currentTarget as HTMLInputElement;
                const imageFile = fileInput.files[0];
                if (imageFile) {
                    const currentImageUrl = imgTag.src;
                    if (currentImageUrl.length) {
                        // Ensure that any existing image urls are revoked before attaching a new one, for performance reasons.
                        URL.revokeObjectURL(currentImageUrl);
                    }

                    imgTag.src = URL.createObjectURL(imageFile);
                } else {
                    console.warn('Image file was not attached to browser properly.');
                }
            });
        } else {
            console.warn(`No img tag corresponding to ${imgTagSelector}`);
        }
    } else {
        console.warn('No selector for img tag to sync to input element');
    }
};

/**
 *
 * @param {string} listTarget List Element to attach Drag and Drop behavior onto
 */
export const setupDraggableList = (listTarget) => {
    const sortableEl = document.querySelector(listTarget);

    if (sortableEl) {
        Sortable.create(
            sortableEl,
            {
                draggable: '.recipe-step',
                onUpdate: function (_event) {
                    const sortableItems = document.querySelectorAll(`${listTarget} .recipe-step`);
                    sortableItems.forEach((item, idx) => {
                        const itemOrder = idx + 1;
                        const itemOrderEl = item.querySelector('.recipe-step-order') as HTMLInputElement;

                        itemOrderEl.value = itemOrder.toString();
                    });
                }
            })
    }
}