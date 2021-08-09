<template>
  <section id="editable_recipe_steps" class="recipe-col">
    <label for="editable_steps">Steps</label>
    <ol id="editable_steps" class="col-items">
      <li class="step" v-for="step in steps" v-bind:id="stepId(step)">
        <p class="step-content">{{ step.instruction }}</p>
        <button type="button" class="edit-ingredients-btn" @click="setStep(step)">
          Edit
        </button>
        <button type="button" class="remove-step-btn">X</button>
      </li>
    </ol>
  </section>
  <section id="recipe_steps_action_btns">
    <button type="button" class="recipe-action-btn add-step-btn">New Step</button>
    <button type="button" class="recipe-action-btn submit-steps-btn">Submit</button>
  </section>
  <modal v-show="isModalVisible" v-if="editableStep" @close="hideModal">
    <form-step v-bind:loaded-step="editableStep" />
  </modal>
</template>

<script lang="ts">
import {defineComponent, PropType} from "vue";
import {Step} from "manage/types/recipes/mapper";
import Modal from "manage/components/Modal.vue";
import FormStep from "manage/components/recipes/form/FormStep.vue";

export default defineComponent({
  name: "FormSteps",
  components: {
    Modal,
    FormStep
  },
  data: function () {
    return {
      isModalVisible: false,
      editableStep: null
    }
  },
  props: {
    loadedSteps: Object as PropType<Array<Step>>
  },
  computed: {
    steps: function () {
      const mappedSteps: Array<Step> = this.loadedSteps.map((step) => {
        return {
          ...step
        }
      });

      return mappedSteps;
    }
  },
  methods: {
    showModal: function () {
      this.isModalVisible = true;
    },
    hideModal: function () {
      this.isModalVisible = false;
    },
    setStep(step: Step) {
      this.editableStep = step;
      this.isModalVisible = true;
    },
    stepId: function (step) {
      return `editable_step_${step.id}`;
    },
  }
})
</script>

<style scoped lang="scss">
  #editable_recipe_steps {
    height: 70%;
    margin: 0 1%;
    overflow-y: scroll;
    width: 100%;
  }

  #recipe_steps_action_btns {
    height: 40%;
    margin: 0 1%;
    padding: 1%;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
    .recipe-action-btn {
      width: 30%;
    }
    .remove-step-btn {
      background-color: red;
      margin: 0 1%;
    }

    .edit-ingredients-btn {
      margin: 0 1%;
    }
  }

  .step {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
  }

  .step-content {
    width: 75%;
  }
</style>