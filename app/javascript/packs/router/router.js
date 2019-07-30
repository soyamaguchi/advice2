import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import Index from '../components/index'
import Terms from '../components/terms'
import Privacy from '../components/privacy'

Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: Index },
        { path: '/terms', component: Terms },
        { path: '/privacy', components: Privacy },
    ],
})