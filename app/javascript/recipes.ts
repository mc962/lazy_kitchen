// import Sortable from 'sortablejs/modular/sortable.core.esm.js';

export const DRAGGABLE_LIST_SELECTOR = '.draggable';

/**
 * Sets up behavior for a list with draggable elements using the Drag and Drop API
 * @param {string} listTarget List Element to attach Drag and Drop behavior onto
 */
export const setupDraggableList = (listTarget) => {
    // const sortableEl = document.querySelector(listTarget);

    // if (sortableEl) {
    //     Sortable.create(
    //         sortableEl,
    //         {
    //             draggable: '.recipe-step',
    //             onUpdate: function (_event) {
    //                 const sortableItems = document.querySelectorAll(`${listTarget} .recipe-step`);
    //                 sortableItems.forEach((item, idx) => {
    //                     const itemOrder = idx + 1;
    //                     const itemOrderEl = item.querySelector('.recipe-step-order') as HTMLInputElement;
    //
    //                     itemOrderEl.value = itemOrder.toString();
    //                 });
    //             }
    //         }
    //     )
    // }
}
