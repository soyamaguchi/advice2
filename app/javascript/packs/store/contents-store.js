import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'

Vue.use(Vuex)

const contents = {
    namespaced: true,
    /** appの状態保持 */
    state: {
    },
    /** stateを更新する */
    mutations: {
    },
    /** ex. apiリクエスト後、responsedataを引数にmutationsを呼び出す */
    actions: {
    },
    getters: {
    },
}

export default new Vuex.Store({
    state: {
        isIndex: false,
        indexInitFlag: false,
    },
    mutations: {
        /** 表示画面識別 */
        isIndex(state, value) {
            state.isIndex = value
        },
        /** indexcomponent初期化 */
        indexInitFlag(state, value) {
            state.indexInitFlag = value
        },
    },
    modules: {
        contents,
    },
})