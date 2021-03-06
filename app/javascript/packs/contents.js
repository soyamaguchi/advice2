import Vue from 'vue/dist/vue.esm'
import store from './store/contents-store'
import Router from './router/router'
import Header from './components/header'
import Footer from './components/footer'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(fas)

Vue.component('font-awesome-icon', FontAwesomeIcon)

var app = new Vue({
    router: Router,
    el: '#app',
    components: {
        'navbar': Header,
        'footerinfo': Footer,
    },
    store,
});
