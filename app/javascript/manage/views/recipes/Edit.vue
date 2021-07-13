<template>
  <main id="page">
    <h1 class="recipe-heading">Update {{ recipe.name }}</h1>

    <section id="recipe-bio">
      <label for="recipe_name">Name: </label>
      <input type="text" id="recipe_name" v-model="recipe.name" />

      <label for="recipe_picture">Recipe Picture: </label>
      <img v-bind:src="recipe.image_url" v-bind:alt="image_url_alt" class="recipe-profile-img"/>
      <input type="text" id="recipe_picture" v-model="recipe.image_url" />

      <label for="recipe_description">Description: </label>
      <textarea id="recipe_description" v-model="recipe.description"></textarea>
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
import { recipeAPIToClient, RecipeResponse } from "manage/recipes/mapper";
import { defineComponent } from "vue";

export default defineComponent({
  name: 'Edit',
  components: {},
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
    image_url_alt: function () {
      return `A display of ${this.recipe.name}`
    },
  },

  methods: {
    loadRecipe: async function(id: string) {
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

      } catch(err) {
        console.error(err);
      }
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
  },
  created: async function() {
    await this.loadRecipe(this.$route.params.id.toString());
  },
});
</script>

<style scoped lang="scss">

</style>