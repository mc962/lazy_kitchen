import StimulusRailsNestedFormController from 'stimulus-rails-nested-form'

/**
 * Manages a form that may contain nested models within it, handling creation/deletion of these nested models
 *
 * Connects to data-controller="nested-form"
 */
export default class extends StimulusRailsNestedFormController {
    private templateTarget: HTMLTemplateElement;
    private targetTarget: HTMLElement;
    private wrapperSelectorValue: string;


    /**
     * Adds HTML content to form necessary for a new and unsaved nested model
     *
     * @param {Event} event Click event that triggered adding nested model content to form
     */
    add(event: Event) {
        event.preventDefault();
        const content = this.templateTarget.content.cloneNode(true) as HTMLElement;
        const nodeInputs = content.querySelectorAll('input');
        const nodeTextAreas = content.querySelectorAll('textarea');
        [...Array.from(nodeInputs), ...Array.from(nodeTextAreas)].forEach((nodeInput) => {
            const newRandVal = new Date().getTime().toString();
            nodeInput.name = nodeInput.name.replace(/NEW_RECORD/g, newRandVal)
            nodeInput.id = nodeInput.id.replace(/NEW_RECORD/g, newRandVal)
        });

        this.targetTarget.appendChild(content);
    }

    // TODO figure out if this is still needed with sortable_list
    order(e) {
        e.preventDefault();

        const itemOrderEls = document.querySelectorAll('.recipe-step-order');
        itemOrderEls.forEach((orderEl: HTMLInputElement, idx) => {
            orderEl.value = (idx + 1).toString();
        })
    }
    /**
     * Handles removal of nested model from form. For an unsaved model, this content is simply deleted from the form.
     * For content that already exists from the database, the `_destroy` attribute is added to the nested model content
     * (which is understood by the server to destroy this model), and the relevant action button(s) for undoing this
     * action are revealed.
     *
     * @param {Event} event Click event that triggered adding nested model content to form
     */
    remove(event: Event) {
        event.preventDefault();

        const eventTarget = event.target as HTMLElement;
        const wrapper = eventTarget.closest(this.wrapperSelectorValue) as HTMLLIElement;
        if (wrapper.dataset.newRecord === "true") {
            wrapper.remove();
        } else {
            const input = wrapper.querySelector("input[name*='_destroy']") as HTMLInputElement;
            input.value = "1";
            wrapper.classList.add('destroyed')
            const currentTarget = event.currentTarget as HTMLElement;
            currentTarget.classList.add('hidden')
            const undoBtn = wrapper.querySelector('.undo-remove-btn');
            undoBtn.classList.remove('hidden');
        }
    }

    /**
     * Handles undoing the actions that mark a nested model for deletion (so that it will _not_ be deleted on
     * form submission).
     * For content that already exists in the database, this removes the parameter marking it for deletion. For content
     * that has not yet been saved, it merely logs a warning, as removal cannot be undone for saved items.
     * @param {Event} event Click event that triggered removing nested model content from the form
     */
    undoRemove(event: Event) {
        event.preventDefault();

        const eventTarget = event.target as HTMLElement;
        const wrapper = eventTarget.closest(this.wrapperSelectorValue) as HTMLLIElement;
        if (wrapper.dataset.newRecord === "true") {
            console.warn('Unsaved records cannot be restored after removal');
        } else {
            const input = wrapper.querySelector("input[name*='_destroy']") as HTMLInputElement;
            input.value = "";
            wrapper.classList.remove('destroyed')

            const currentTarget = event.currentTarget as HTMLElement;
            currentTarget.classList.add('hidden')
            const removeBtn = wrapper.querySelector('.remove-btn');
            removeBtn.classList.remove('hidden');
        }
    }
}