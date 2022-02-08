import { Controller } from "@hotwired/stimulus"


/**
 * Manages an uploader component for a single image
 *
 * Connects to data-controller="primary-image-upload"
 */
export default class extends Controller {
    static targets = ['recipePrimaryPicture', 'previewImg'];
    private previewImgTarget: HTMLImageElement;
    private recipePrimaryPictureTarget: HTMLInputElement;

    /**
     * Syncs the contents of a file input with a container for previewing a single image to upload, creating a small
     * preview img for the item that will be uploaded
     *
     * @param {Event} event Click event that triggered image upload img tag syncing with file input
     */
    sync(event) {
        const imageFile = this.recipePrimaryPictureTarget.files[0];

        if (imageFile) {
            const currentImageUrl = this.previewImgTarget.src;
            if (currentImageUrl.length) {
                // Ensure that any existing image urls are revoked before attaching a new one, for performance reasons.
                URL.revokeObjectURL(currentImageUrl);
            }

            this.previewImgTarget.src = URL.createObjectURL(imageFile);
        } else {
            console.warn('Image file was not attached to browser properly.');
        }
    }

    /**
     * "Cancels" the potential upload of an un-uploaded single image, clearing out the file input as well as the
     * corresponding preview img
     *
     * @param {Event} event Click event that triggered image upload cancellation
     */
    cancel(event: Event) {
        // Free existing image preview file URL and clear file from input
        URL.revokeObjectURL(this.previewImgTarget.src);
        this.recipePrimaryPictureTarget.value = '';

        // Reset image tag back to initial value
        this.previewImgTarget.src = this.previewImgTarget.dataset.originalSrc;
    }
}
