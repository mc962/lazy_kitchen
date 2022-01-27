import Sortable from "stimulus-sortable"

// Connects to data-controller="sortable-list"
// noinspection JSUnusedGlobalSymbols
export default class extends Sortable {
    async end({ item, newIndex: newIndex2 }) {
        super.end({ item, newIndex: newIndex2 });
        this.order();
    }
    private order() {
        const itemOrderEls = document.querySelectorAll('.recipe-step-order');
        itemOrderEls.forEach((orderEl: HTMLInputElement, idx) => {
            orderEl.value = (idx + 1).toString();
        })
    }
}