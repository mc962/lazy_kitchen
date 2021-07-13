import {createRouter, createWebHashHistory, RouteRecordRaw} from "vue-router";
import Edit from "manage/views/recipes/Edit.vue";

const routes: Array<RouteRecordRaw> = [
   {
      path: '/:id/edit',
      name: 'Recipes',
      component: Edit
   },
];

const router = createRouter({

   history: createWebHashHistory(
       `/recipes/manage`,
   ),
   routes
});

export default router;