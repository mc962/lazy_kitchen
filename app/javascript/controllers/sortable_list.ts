import Sortable from "stimulus-sortable"

const ORDERED_ITEM_SELECTOR = '.ordered-item';

/**
 * Manages a list of items that are sorted by a particular order field, and where the items are draggable. Extends
 * imported stimulus-sortable component.
 *
 * Connects to data-controller="sortable-list"
 */
export default class extends Sortable {
    /**
     * Handles custom behavior for when an item dragged within the list is finished being dragged
     * @param {HTMLLIElement} item Ordered Sortable item that is being dragged around
     * @param {number} newIndex2 New value for index of item after dragging has finished
     */
    async end({ item, newIndex: newIndex2 }: {item: HTMLLIElement, newIndex: number}) {
        super.end({ item, newIndex: newIndex2 });
        // After an item has finished being dragged, the order form params should be re-ordered based on new order
        //  within list element.
        this.order();
    }

    /**
     * Re-orders items from the form's perspective by updating the `order` param for every item on the list based on its
     *   position within the HTML list of items.
     * @private
     */
    private order() {
        const itemOrderEls = document.querySelectorAll(ORDERED_ITEM_SELECTOR);
        itemOrderEls.forEach((orderEl: HTMLInputElement, idx) => {
            orderEl.value = (idx + 1).toString();
        })
    }
}