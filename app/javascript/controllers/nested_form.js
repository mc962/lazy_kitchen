import StimulusRailsNestedFormController from 'stimulus-rails-nested-form'

export default class extends StimulusRailsNestedFormController {
    add(e) {
        e.preventDefault();
        const content = this.templateTarget.content.cloneNode(true);
        const nodeInputs = content.querySelectorAll('input');
        const nodeTextAreas = content.querySelectorAll('textarea');
        [...nodeInputs, ...nodeTextAreas].forEach((nodeInput) => {
            const newRandVal = new Date().getTime().toString();
            nodeInput.name = nodeInput.name.replace(/NEW_RECORD/g, newRandVal)
            nodeInput.id = nodeInput.id.replace(/NEW_RECORD/g, newRandVal)
        });

        this.targetTarget.appendChild(content);
    }
    order(e) {
        e.preventDefault();

        const itemOrderEls = document.querySelectorAll('.recipe-step-order');
        itemOrderEls.forEach((orderEl, idx) => {
            orderEl.value = idx + 1;
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