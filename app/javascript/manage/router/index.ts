import {createRouter, createWebHashHistory, RouteRecordRaw} from "vue-router";
import Edit from "manage/views/recipes/Edit.vue";
import Show from "manage/views/recipes/Show.vue";
import New from "manage/views/recipes/New.vue";

const routes: Array<RouteRecordRaw> = [
    {
       path: '/recipes/:id',
       name: 'Show',
       component: Show
    },
    {
       path: '/recipes/:id/edit',
       name: 'Edit',
       component: Edit
    },
   {
      path: '/recipes/new',
      name: 'New',
      component: New
   }
];

const router = createRouter({

   history: createWebHashHistory(
       `/manage`,
   ),
   routes
});

export default router;