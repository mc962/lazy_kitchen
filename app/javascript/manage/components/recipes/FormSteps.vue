<template>
  <section id="editable_recipe_steps" class="recipe-col">
    <label for="editable_steps">Steps</label>
    <ol id="editable_steps" class="col-items">
      <li class="step" v-for="step in steps" v-bind:id="stepId(step)">
        <textarea class="step-content" v-model="step.instruction"></textarea>
      </li>
    </ol>
  </section>
</template>

<script lang="ts">
import {PropType} from "vue";
import {Step} from "../../types/recipes/mapper";

export default {
  name: "FormSteps",
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
    stepId: function (step) {
      return `editable_step_${step.id}`;
    }
  }
}
</script>

<style scoped lang="scss">
  #editable_recipe_steps {
    height: 100%;
    overflow-y: scroll;
    width: 100%;
  }

  .step {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }

  .step-content {
    width: 95%;
  }
</style>