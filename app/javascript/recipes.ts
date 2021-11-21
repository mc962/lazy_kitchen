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

export const setupMultiImgSync = (inputSelector: string, multiImgContainerSelector: string) => {
    const fileInput = document.querySelector(inputSelector) as HTMLInputElement;
    const multiImgContainer = document.querySelector(multiImgContainerSelector) as HTMLElement;

    if (!(fileInput && multiImgContainer)) {
        return;
    }

    fileInput.addEventListener('change', (event: Event) => {
        const fileInput = event.currentTarget as HTMLInputElement;

        const existingMultiImgEls = multiImgContainer.querySelectorAll('.synced-multi-img');
        // Ensure that any existing image urls are revoked before attaching a new one, for performance reasons.
        existingMultiImgEls.forEach((syncedImg: HTMLImageElement) => {
            URL.revokeObjectURL(syncedImg.src);
        });

        // Clear out existing new images in preparation for reattachment with a new batch
        multiImgContainer.textContent = '';

        const currentFiles = fileInput.files;
        if (currentFiles.length) {
            const newResourceImgTemplate = document.getElementById('new_resource_image_template') as HTMLTemplateElement;
            Array.from(currentFiles).forEach((inputFile) => {
                const newGalleryImgContainer = newResourceImgTemplate.content.cloneNode(true);
                multiImgContainer.appendChild(newGalleryImgContainer);
                const insertedImgContainer = multiImgContainer.lastElementChild as HTMLLIElement;
                const newGalleryImg = insertedImgContainer.querySelector('.synced-multi-img') as HTMLImageElement;
                newGalleryImg.src = URL.createObjectURL(inputFile);
            });
        }
    });
}

// TODO styling
// TODO display current files
// TODO clear un-uploaded files

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