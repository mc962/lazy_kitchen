<template>
  <main id="page">
    <h1 class="recipe-heading">Update {{ recipe.name }}</h1>

    <!-- TODO consider just redirecting this to public page instead of maintaining separate view -->
    <section id="recipe-bio">
      <div class="recipe-profile-img-container">
        <img v-bind:src="recipe.image_url" v-bind:alt="imageURLAlt" class="recipe-profile-img"/>
      </div>
      <p aria-label="Recipe description" id="recipe_description">{{ recipe.description }}</p>
    </section>

    <section id="recipe_content">
      <section id="recipe_ingredients" class="recipe-col">
        <label for="ingredients">Ingredients</label>
        <ul id="ingredients">
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
        <ol id="steps">
          <li class="step" v-for="step in recipe.steps" v-bind:id="stepId(step)">
            {{ step.instruction }}
          </li>
        </ol>
      </section>
    </section>
  </main>
</template>

<script lang="ts">
import {recipeAPIToClient, RecipeResponse} from "../../types/recipes/mapper";

export default {
  name: "Show",
  data: function () {
    return {
      recipe: {
        name: '',
        image_url: '',
        description: '',
        steps: []
      }
    }
  },
  computed: {
    imageURLAlt: function () {
      return `A display of ${this.recipe.name}`
    }
  },
  methods: {
    loadRecipe: async function (id: string) {
      try {
        const response = await fetch(
            `/api/recipes/${id}`,
            {
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              }
            }
        );

        const result = await response.json() as RecipeResponse;

        this.recipe = recipeAPIToClient(result);

      } catch (err) {
        console.error(err);
      }
    },
    stepIngredientId: function (step_ingredient) {
      return `ingredient_${step_ingredient.id}`;
    },
    stepId: function (step) {
      return `step_${step.id}`;
    },
    stepIngredientDisplayName: function (step_ingredient) {
      return [step_ingredient.name, step_ingredient.condition].join(', ')
    }
  },
  created: async function() {
    await this.loadRecipe(this.$route.params.id.toString());
  }
}
</script>

<style scoped lang="scss">

</style>