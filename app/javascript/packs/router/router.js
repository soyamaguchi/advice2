import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import Index from '../components/index'
import Terms from '../components/terms'
import Privacy from '../components/privacy'
import License from '../components/license'

Vue.use(VueRouter)

export default new VueRouter({
    scrollBehavior(to, from, savedPosition) {
        return savedPosition || { x: 0, y: 0 }
    },
    mode: 'history',
    routes: [
        { path: '/', component: Index },
        { path: '/terms', component: Terms },
        { path: '/privacy', component: Privacy },
        { path: '/license', component: License },
    ],
})