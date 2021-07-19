<template>
  <main id="page">
    <h1 class="recipe-heading">Update {{ recipe.name }}</h1>

    <resource-form v-bind:loaded-recipe="recipe" submit-btn-txt="Add Recipe" />
  </main>
</template>

<script lang="ts">
import { recipeAPIToClient, RecipeResponse } from "manage/types/recipes/mapper";
import { defineComponent } from "vue";
import ResourceForm from "manage/components/recipes/ResourceForm.vue";

export default defineComponent({
  name: 'Edit',
  components: {
    ResourceForm
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
    }
  },
  created: async function() {
    await this.loadRecipe(this.$route.params.id.toString());
  },
});
</script>

<style scoped lang="scss">

</style>