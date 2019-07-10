import Vue from 'vue/dist/vue.esm'
import Header from './components/header'
import Router from './router/router'
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
    }
});
