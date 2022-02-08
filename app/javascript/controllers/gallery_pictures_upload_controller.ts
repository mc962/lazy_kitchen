import { Controller } from "@hotwired/stimulus"

/**
 * Manages an uploader component for a gallery of images
 *
 * Connects to data-controller="gallery-pictures-upload"
 */
export default class extends Controller {
  static targets = ['resourceGalleryPictures', 'previewImgs'];
  private previewImgsTarget: HTMLUListElement;
  private resourceGalleryPicturesTarget: HTMLInputElement;

  /**
   * Syncs the contents of a file input with a container for previewing several images to upload, creating a small
   *   preview img for each item that will be uploaded
   */
  sync() {
    this.emptyMultiImgContainer(this.previewImgsTarget);

    const currentFiles = this.resourceGalleryPicturesTarget.files;
    if (currentFiles.length) {
      const newResourceImgTemplate = document.getElementById('new_resource_image_template') as HTMLTemplateElement;
      Array.from(currentFiles).forEach((inputFile) => {
        // Add a new preview img tag for each attached file (assumes that attached files are all image files)
        this.addGalleryPreviewImage(inputFile, newResourceImgTemplate, this.previewImgsTarget);
      });
    }
  }

  /**
   * "Cancels" the potential upload of un-uploaded imgs, clearing out the file input as well as all the corresponding
   * preview imgs
   */
  cancel() {
    // TODO see if stimulus can deal with this state in here
    // Clear out HTML displaying preview images
    this.emptyMultiImgContainer(this.previewImgsTarget);
    // Clear out images assigned to file input
    this.resourceGalleryPicturesTarget.value = ''
  }

  /**
   * Adds a new img tag to the preview images container based on the corresponding File
   *
   * @param {File} inputFile Image file that will be uploaded, which may be used to generate url pointing to the
   * local image file for display in the img
   * @param {HTMLTemplateElement} newResourceImgTemplate A template node containing an un-populated chunk of HTML
   * content that may be used to create a new preview img
   * @param {HTMLElement} multiImgContainer DOM element that preview imgs will be inserted into
   * @private
   */
  private addGalleryPreviewImage(inputFile: File, newResourceImgTemplate: HTMLTemplateElement, multiImgContainer: HTMLElement) {
    // Clone a copy of the preview img HTML from the Template element and append it to the container element for
    //   upload-able images to preview
    const newGalleryImgContainer = newResourceImgTemplate.content.cloneNode(true);
    multiImgContainer.appendChild(newGalleryImgContainer);
    // Query for element inserted into preview container and generate a URL pointing to the image file on the local
    //   filesystem, and set that URL as the img src
    const insertedImgContainer = multiImgContainer.lastElementChild as HTMLLIElement;
    const newGalleryImg = insertedImgContainer.querySelector('.synced-multi-img') as HTMLImageElement;
    newGalleryImg.src = URL.createObjectURL(inputFile);
  }

  /**
   * "Resets" the container holding preview images by free-ing up the generated object URLs and emptying out the
   * preview img HTML from the Container
   * @param {HTMLElement} multiImgContainer HTML Node containing the preview img nodes that will be emptied out
   * @private
   */
  private emptyMultiImgContainer(multiImgContainer: HTMLElement) {
    const existingMultiImgEls = multiImgContainer.querySelectorAll('.synced-multi-img');
    // Ensure that any existing image urls are revoked before attaching a new one, for performance reasons.
    existingMultiImgEls.forEach((syncedImg: HTMLImageElement) => {
      URL.revokeObjectURL(syncedImg.src);
    });

    // Clear out existing new images in preparation for reattachment with a new batch
    multiImgContainer.textContent = '';
  }
}
