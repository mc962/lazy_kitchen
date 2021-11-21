import Sortable from 'sortablejs/modular/sortable.core.esm.js';

export const DRAGGABLE_LIST_SELECTOR = '.draggable';

export const setupSingleImgSync = (inputSelector: string, imgSelector: string) =>  {
    const fileInput = document.querySelector(inputSelector) as HTMLInputElement;
    const imgTag = document.querySelector(imgSelector) as HTMLImageElement;

    if (!(fileInput && imgTag)) {
        return;
    }

    fileInput.addEventListener('change', (event: Event) => {
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
}

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