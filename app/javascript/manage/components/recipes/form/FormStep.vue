<template>
  <section id="editable_step" class="recipe-col">
    <label for="instruction">Instruction: </label>
    <textarea id="instruction" class="ingredient-instruction" v-model="step.instruction"></textarea>
    <section class="editable-ingredients-container" v-if="step.ingredients.length > 0">
      <label for="editable_ingredients">Ingredients</label>
      <ol id="editable_ingredients" class="col-items">
        <li class="editable-ingredient" v-for="ingredient in step.ingredients" v-bind:id="ingredientAttr(ingredient.id)">
          <div class="ingredient-info-container">
            <div class="ingredient-info-group ingredient-name-condition">
              <div class="form-ctrl-container">
                <label v-bind:for="ingredientAttr(ingredient.name)">Name</label>
                <input type="text" v-bind:id="ingredientAttr(ingredient.name)" class="form-ctrl" v-model="ingredient.name" placeholder="water" />
              </div>

              <div class="form-ctrl-container">
                <label v-bind:for="ingredientAttr(ingredient.condition)">Condition</label>
                <input type="text" v-bind:id="ingredientAttr(ingredient.condition)" class="form-ctrl" v-model="ingredient.condition" placeholder="warm" />
              </div>
            </div>
            <div class="ingredient-info-group ingredient-amount-unit">
              <div class="form-ctrl-container">
                <label v-bind:for="ingredientAttr(ingredient.amount)">Amount</label>
                <input type="number" v-bind:id="ingredientAttr(ingredient.amount)" class="form-ctrl" v-model="ingredient.amount" step="1" />
              </div>

              <div class="form-ctrl-container">
                <label v-bind:for="ingredientAttr(ingredient.unit)">Unit</label>
                <input type="text" v-bind:id="ingredientAttr(ingredient.unit)" class="form-ctrl" v-model="ingredient.unit" />
              </div>
            </div>
          </div>
          <button type="button" class="remove-ingredient-btn">X</button>
        </li>
      </ol>
    </section>
  </section>
  <section id="step_ingredients_action_btns">
    <button type="button" class="ingredient-action-btn add-step-btn">New Ingredient</button>
    <button type="button" class="ingredient-action-btn submit-steps-btn">Submit</button>
  </section>
</template>

<script lang="ts">
import {defineComponent, PropType} from "vue";
import {Step} from "manage/types/recipes/mapper";

export default defineComponent({
  name: "FormStep",
  props: {
    loadedStep: Object as PropType<Step>
  },
  computed: {
    step: function () {
      const mappedStep: Step = {
          ...this.loadedStep
        };

      return mappedStep;
    }
  },
  methods: {
    ingredientAttr: function (ingredient_attr) {
      return `editable_ingredient_${ingredient_attr}`
    }
  }
})
</script>

<style scoped lang="scss">
  #editable_step {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .ingredient-instruction {
    width: 70%;
  }

  .editable-ingredients-container {
    width: 70%;
  }
  #editable_ingredients {
    height: 35vh;
    margin: 1%;
    overflow-y: scroll;
    width: 100%;

    .editable-ingredient {
      display: flex;
      flex-direction: row;
      padding: 1%;
      border-bottom: 1px solid black;

      .ingredient-info-container {
        width: 100%;

        .ingredient-info-group {
          display: flex;
          flex-direction: row;
          justify-content: space-evenly;

          .form-ctrl-container {
            width: 30%;
            .form-ctrl {
              margin: 1%;
            }
          }
        }
      }

      .remove-ingredient-btn {
        align-self: center;
        text-align: center;
      }
    }
  }

  #step_ingredients_action_btns {
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    margin: 1%;

    .ingredient-action-btn {
      width: 25%;
    }
  }
</style>