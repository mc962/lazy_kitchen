<template>
  <main id="page">
    <h1 class="recipe-heading">Add Recipe</h1>

    <resource-form v-bind:loaded-recipe="recipe" submit-btn-txt="Add Recipe" />
  </main>
</template>

<script lang="ts">
import ResourceForm from "../../components/recipes/form/ResourceForm.vue";
import {defineComponent} from "vue";

export default defineComponent({
  name: 'New',
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
  }
})
</script>

<style scoped lang="scss">

</style>