import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="primary-image-upload"
export default class extends Controller {
  static targets = ['recipePrimaryPicture', 'previewImg'];
  private previewImgTarget: HTMLImageElement;
  private recipePrimaryPictureTarget: HTMLInputElement;

  sync(event) {
    event.preventDefault();

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

  cancel(event) {
      event.preventDefault();

      // Free existing image preview file URL and clear file from input
      URL.revokeObjectURL(this.previewImgTarget.src);
      this.recipePrimaryPictureTarget.value = '';

      // Reset image tag back to initial value
      this.previewImgTarget.src = this.previewImgTarget.dataset.originalSrc;
  }

  connect() {
  }
}
