import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery-pictures-upload"
// noinspection JSUnusedGlobalSymbols
export default class extends Controller {
  static targets = ['recipeGalleryPictures', 'previewImgs'];
  private previewImgsTarget: HTMLUListElement;
  private recipeGalleryPicturesTarget: HTMLInputElement;

  sync() {
    this.emptyMultiImgContainer(this.previewImgsTarget);

    const currentFiles = this.recipeGalleryPicturesTarget.files;
    if (currentFiles.length) {
      const newResourceImgTemplate = document.getElementById('new_resource_image_template') as HTMLTemplateElement;
      Array.from(currentFiles).forEach((inputFile) => {
        // Add a new preview img tag for each attached file (assumes that attached files are all image files)
        this.addGalleryPreviewImage(inputFile, newResourceImgTemplate, this.previewImgsTarget);
      });
    }
  }

  cancel() {
    // TODO see if stimulus can deal with this state in here
    this.emptyMultiImgContainer(this.previewImgsTarget);
    // Clear out images assigned to file input
    this.recipeGalleryPicturesTarget.value = ''
  }

  connect() {
  }

  private addGalleryPreviewImage(inputFile: File, newResourceImgTemplate: HTMLTemplateElement, multiImgContainer: HTMLElement) {
    const newGalleryImgContainer = newResourceImgTemplate.content.cloneNode(true);
    multiImgContainer.appendChild(newGalleryImgContainer);
    const insertedImgContainer = multiImgContainer.lastElementChild as HTMLLIElement;
    const newGalleryImg = insertedImgContainer.querySelector('.synced-multi-img') as HTMLImageElement;
    newGalleryImg.src = URL.createObjectURL(inputFile);
  }

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
