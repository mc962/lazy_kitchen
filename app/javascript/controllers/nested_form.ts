import StimulusRailsNestedFormController from 'stimulus-rails-nested-form'

// Connects to data-controller="nested-form"
// noinspection JSUnusedGlobalSymbols
export default class extends StimulusRailsNestedFormController {
    private templateTarget: HTMLTemplateElement;
    private targetTarget: HTMLElement;
    private wrapperSelectorValue: string;


    add(e) {
        e.preventDefault();
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
    order(e) {
        e.preventDefault();

        const itemOrderEls = document.querySelectorAll('.recipe-step-order');
        itemOrderEls.forEach((orderEl: HTMLInputElement, idx) => {
            orderEl.value = (idx + 1).toString();
        })
    }
    remove(e) {
        e.preventDefault();
        const wrapper = e.target.closest(this.wrapperSelectorValue);
        if (wrapper.dataset.newRecord === "true") {
            wrapper.remove();
        } else {
            const input = wrapper.querySelector("input[name*='_destroy']");
            input.value = "1";
            wrapper.classList.add('destroyed')
            e.currentTarget.classList.add('hidden')
            const undoBtn = wrapper.querySelector('.undo-remove-btn');
            undoBtn.classList.remove('hidden');
        }
    }
    undoRemove(e) {
        e.preventDefault();
        const wrapper = e.target.closest(this.wrapperSelectorValue);
        if (wrapper.dataset.newRecord === "true") {
            console.warn('Unsaved records cannot be restored after removal');
        } else {
            const input = wrapper.querySelector("input[name*='_destroy']");
            input.value = "";
            wrapper.classList.remove('destroyed')

            e.currentTarget.classList.add('hidden')
            const removeBtn = wrapper.querySelector('.remove-btn');
            removeBtn.classList.remove('hidden');
        }
    }
}