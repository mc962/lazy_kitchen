/**
 * Sets up behavior to sync a single image to a file input, as might be used for previewing the image before uploading
 * @param {string} inputSelector HTML selector to query for file input tag that image may be attached to
 * @param {string} imgSelector HTML selector to query for img tag that may be used to preview attached image file
 * @param {string} cancelBtnSelector HTML selector to query for button tag that will reset the preview img tag and clear
 * the file input on click
 */
export const setupSingleImgSync = (inputSelector: string, imgSelector: string, cancelBtnSelector?: string) => {
    const fileInput = document.querySelector(inputSelector) as HTMLInputElement;
    const imgTag = document.querySelector(imgSelector) as HTMLImageElement;
    const cancelBtn = document.querySelector(cancelBtnSelector) as HTMLButtonElement;

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

    // Optionally set up behavior to cancel/reset the image that was attached to the synced file input and preview container
    if (cancelBtn) {
        cancelBtn.addEventListener('click', (_event: MouseEvent) => {
            cancelSingleImgSync(fileInput, imgTag);
        });
    }
}
/**
 * Cancels upload of file on a file input by freeing up the created local URL, resetting the relevant img tag to its
 *   initial display image, and overwriting the file input value with a 'blank' value.
 * @param {HTMLInputElement} fileInput File input tag that image is attached to
 * @param {HTMLImageElement} imgTag Tag that is used to preview attached image file
 */
const cancelSingleImgSync = (fileInput: HTMLInputElement, imgTag: HTMLImageElement) => {
    // Free existing image preview file URL and clear file from input
    URL.revokeObjectURL(imgTag.src);
    fileInput.value = '';

    // Reset image tag back to initial value
    imgTag.src = imgTag.dataset.originalSrc;
}
/**
 * Sets up behavior to sync a single image to a file input, as might be used for previewing the image before uploading
 * @param {string} inputSelector HTML selector to query for file input tag that image files may be attached to
 * @param {string} multiImgContainerSelector HTML selector to query for container tag that will hold multiple img elements
 * and that new items will be appended to as the files are added to the input
 * @param {string} cancelBtnSelector HTML selector to query for button tag that will reset the preview img tag and clear
 * the file input on click
 */
export const setupMultiImgSync = (inputSelector: string, multiImgContainerSelector: string, cancelBtnSelector?: string) => {
    const fileInput = document.querySelector(inputSelector) as HTMLInputElement;
    const multiImgContainer = document.querySelector(multiImgContainerSelector) as HTMLElement;
    const cancelBtn = document.querySelector(cancelBtnSelector) as HTMLButtonElement;

    if (!(fileInput && multiImgContainer)) {
        return;
    }

    fileInput.addEventListener('change', (event: Event) => {
        const fileInput = event.currentTarget as HTMLInputElement;

        emptyMultiImgContainer(multiImgContainer);

        const currentFiles = fileInput.files;
        if (currentFiles.length) {
            const newResourceImgTemplate = document.getElementById('new_resource_image_template') as HTMLTemplateElement;
            Array.from(currentFiles).forEach((inputFile) => {
                // Add a new preview img tag for each attached file (assumes that attached files are all image files)
                addGalleryPreviewImage(inputFile, newResourceImgTemplate, multiImgContainer);
            });
        }
    });

    // Optionally set up behavior to cancel/reset the images that were attached to the synced file input and appended
    //   to the preview container
    if (cancelBtn) {
        cancelBtn.addEventListener('click', (_event: MouseEvent) => {
            cancelMultiImgSync(fileInput, multiImgContainer);
        });
    }
}
/**
 * Empties out all images in gallery preview container
 * @param {HTMLElement} multiImgContainer Container tag that will hold multiple img elements and that new items will be
 * appended to as the files are added to the input
 */
const emptyMultiImgContainer = (multiImgContainer: HTMLElement) => {
    const existingMultiImgEls = multiImgContainer.querySelectorAll('.synced-multi-img');
    // Ensure that any existing image urls are revoked before attaching a new one, for performance reasons.
    existingMultiImgEls.forEach((syncedImg: HTMLImageElement) => {
        URL.revokeObjectURL(syncedImg.src);
    });

    // Clear out existing new images in preparation for reattachment with a new batch
    multiImgContainer.textContent = '';
}
/**
 * Cancels upload of files on a file input that may have multiple files attached by freeing up the created local URLs,
 *   emptying out the preview container of HTML Elements, and overwriting the file input value with a 'blank' value.
 * @param {HTMLInputElement} fileInput File input tag that image files are attached to
 * @param {HTMLElement} multiImgContainer Container tag that will hold multiple img elements and that new items will be
 * appended to as the files are added to the input */
const cancelMultiImgSync = (fileInput: HTMLInputElement, multiImgContainer: HTMLElement) => {
    if (!(fileInput && multiImgContainer)) {
        return;
    }

    // Empty container of HTML preview img contents
    emptyMultiImgContainer(multiImgContainer);
    fileInput.value = '';
}
/**
 * Adds a preview image for an image gallery to the designated container
 * @param {File} inputFile Newly attached file used to generate preview element for in gallery
 * @param {HTMLTemplateElement} newResourceImgTemplate Template content for adding a new img tag and container,
 * and populate with data
 * @param {HTMLElement} multiImgContainer Container tag that will hold multiple img elements and that new items will be
 * appended to as the files are added to the input
 */
const addGalleryPreviewImage = (inputFile: File, newResourceImgTemplate: HTMLTemplateElement, multiImgContainer: HTMLElement) => {
    const newGalleryImgContainer = newResourceImgTemplate.content.cloneNode(true);
    multiImgContainer.appendChild(newGalleryImgContainer);
    const insertedImgContainer = multiImgContainer.lastElementChild as HTMLLIElement;
    const newGalleryImg = insertedImgContainer.querySelector('.synced-multi-img') as HTMLImageElement;
    newGalleryImg.src = URL.createObjectURL(inputFile);
}