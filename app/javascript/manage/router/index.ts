import {createRouter, createWebHashHistory, RouteRecordRaw} from "vue-router";
import Edit from "manage/views/recipes/Edit.vue";
import Show from "manage/views/recipes/Show.vue";

const routes: Array<RouteRecordRaw> = [
   {
      path: '/recipes/:id/edit',
      name: 'Edit',
      component: Edit
   },
   {
      path: '/recipes/:id',
      name: 'Show',
      component: Show
   }
];

const router = createRouter({

   history: createWebHashHistory(
       `/manage`,
   ),
   routes
});

export default router;