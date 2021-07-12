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
          <li class="ingredient" v-for="step_ingredient in step_ingredients" v-bind:id="this.stepIngredientId(step_ingredient)">
            {{ step_ingredient.amount }}
            {{ step_ingredient.unit }}
            {{ step_ingredient_display_name }}
          </li>
        </ul>
      </section>

      <section id="recipe_steps" class="recipe-col">
        <label for="steps">Steps</label>
        <ol id="steps">
          <li class="step" v-for="step in recipe.steps" v-bind:id="this.stepId(step)">
            {{ step.instruction }}
          </li>
        </ol>
      </section>
    </section>
  </main>
</template>

<script lang="ts">
export default {
  name: "Edit",
  mounted() {
    this.$nextTick(async function () {
      const _this = this;
      try {
        const response = await fetch(
            `/recipes/1`,
            {
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              }
            }
        );

        const result = await response.json() as RecipeResponse;

        _this.recipe = recipeAPIToClient(result);
      } catch(err) {
        console.error(err);
      }
    });
  },
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
    step_ingredients: function () {
      const step_ingredients = this.recipe.steps.reduce((all_ingredient_steps, ingredient_steps) => {
        return [
            ...all_ingredient_steps,
            ...ingredient_steps
        ];
      }, []);

      return step_ingredients.flat();
    }
  },

  method: {
    stepIngredientId: function (step_ingredient) {
      return `ingredient_${step_ingredient.ingredient.id}`;
    },
    stepId: function (step) {
      return `step_${step.id}`;
    },
    step_ingredient_display_name: function (step_ingredient) {
      return [step_ingredient.ingredient.name, step_ingredient.condition].join(', ')
    }
  }
}
</script>

<style scoped lang="scss">

</style>