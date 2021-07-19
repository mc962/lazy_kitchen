<template>
  <form id="recipe_form" v-bind:action="submitURL" @submit="handleSubmit">
    <!-- TODO Slot -->
    <section id="recipe-bio">
      <div class="form-ctrl-container">
        <label for="recipe_name" class="form-ctrl-lbl">Name: </label>
        <input type="text" id="recipe_name" class="form-ctrl" v-model="recipe.name" />
      </div>

      <div class="recipe-profile-img-container">
        <img v-if="recipe.image_url" v-bind:src="recipe.image_url" v-bind:alt="imageURLAlt" class="recipe-profile-img"/>
      </div>
      <div class="form-ctrl-container">
        <label for="recipe_picture" class="form-ctrl-lbl">Recipe Picture: </label>
        <input type="text" id="recipe_picture" class="form-ctrl" v-model="recipe.image_url" />
      </div>

      <div class="form-ctrl-container">
        <label for="recipe_description" class="form-ctrl-lbl">Description: </label>
        <textarea id="recipe_description" v-model="recipe.description" class="form-ctrl-text"></textarea>
      </div>
    </section>

    <section id="recipe_content" class="editable">
      <section id="recipe_ingredients" class="recipe-col">
        <label for="ingredients">Ingredients</label>
        <ul id="ingredients" class="col-items">
          <template v-for="step in recipe.steps">
            <li v-for="step_ingredient in step.ingredients" :key="step_ingredient.id" class="ingredient" v-bind:id="stepIngredientId(step_ingredient)">
              {{ step_ingredient.amount }}
              {{ step_ingredient.unit }}
              {{ step_ingredient_display_name(step_ingredient) }}
            </li>
          </template>
        </ul>
      </section>

      <section id="recipe_steps" class="recipe-col">
        <label for="steps">Steps</label>
        <ol id="steps" class="col-items">
          <li class="step" v-for="step in recipe.steps" v-bind:id="stepId(step)">
            {{ step.instruction }}
          </li>
        </ol>
        <button type="button" @click="handleUpdateStepsBtn">Update Steps</button>
      </section>
    </section>

    <input type="submit" class="submit-btn" v-bind:value="submitBtnTxt" />
  </form>

</template>

<script lang="ts">
import {defineComponent, PropType} from 'vue'
import { Recipe } from '../../types/recipes/mapper'

export default defineComponent({
  name: 'ResourceForm',
  data: function () {
    return {};
  },
  props: {
    loadedRecipe: Object as PropType<Recipe>,
    submitBtnTxt: String
  },
  computed: {
    recipe: function () {
      const recipe: Recipe = {
        name: this.loadedRecipe.name,
        image_url: this.loadedRecipe.image_url,
        description: this.loadedRecipe.description,
        steps: this.loadedRecipe.steps
      }

      return recipe;
    },
    imageURLAlt: function () {
      return `A display of ${this.recipe.name}`
    },
    submitURL: function () {
      return `/api/recipes/${this.$route.params.id}`
    }
  },
  methods: {
    handleUpdateStepsBtn: function (event) {
      event.preventDefault()

      alert('Updating recipe steps is not implemented yet!');
    },
    handleSubmit: async function (event) {
      event.preventDefault();

      const payload = {
        recipe: {
          name: this.recipe.name,
          image_url: this.recipe.image_url,
          description: this.recipe.description,
          //  TODO trigger steps updates -> trigger step_ingredients updates -> trigger ingredients updates
        }
      }

      try {
        const response = await fetch(
            `/api/recipes/${this.$route.params.id}`,
            {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
              },
              body: JSON.stringify(payload)
            }
        );
        const result = response.json();
        console.log(result);
      } catch (err) {
        console.error(err);
      }

      //  TODO submit form data
      console.log(this.recipe);
    },
    stepIngredientId: function (step_ingredient) {
      return `ingredient_${step_ingredient.id}`;
    },
    stepId: function (step) {
      return `step_${step.id}`;
    },
    step_ingredient_display_name: function (step_ingredient) {
    return [step_ingredient.name, step_ingredient.condition].join(', ')
  }
  }
})
</script>

<style scoped lang="scss">
  #recipe_form {
    width: 100%;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    .form-ctrl {
      //width: 40%;
    }
    .form-ctrl-lbl {
      align-self: flex-start;
      margin: 0 2%;
    }

    .form-ctrl-text {
      height: 30vh;
      padding: 1%;
    }

    .form-ctrl-container {
      display: flex;
      flex-direction: row;
      width: 70%;
      margin: 1% 0;
    }

    .submit-btn {
      width: 40%;
    }
  }

  #recipe_content.editable {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;
    height: 100vh;
    //border: 1px solid red;
    margin: 1% 0;
    .recipe-col {
      display: flex;
      flex-direction: column;
      height: 100%;
      .col-items {
        padding: 2%;
        border: 1px solid black;
        border-radius: 10px;
        height: 100vh;
        overflow-y: scroll;
      }
    }
  }
</style>