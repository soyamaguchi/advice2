<template>
    <div class="ui segment">
        <div class="ui container">
            <div class="ui text menu">
                <div class="item title">
                    <router-link to="/">
                        <font-awesome-icon icon="graduation-cap" size="3x"/>
                    </router-link>
                </div>
                <div class="item title text">
                    <router-link to="/">Advice2</router-link>
                </div>
                <div class="ui right item" v-show="isIndex">
                    <span>
                        自治体：
                        <div class="ui inline dropdown">
                            <div class="text">大阪府 大阪市</div>
                            <i class="dropdown icon"></i>
                            <div class="menu">
                                <div class="item">大阪府 大阪市</div>
                            </div>
                        </div>
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data: function () {
            return {
            }
        },
        computed: {
            isIndex() {
                return this.$store.state.isIndex
            }
        },
        mounted() {
            /** dropdown button */
            $('.ui.dropdown').dropdown({
            });
        },
        methods: {
        },
    }
</script>

<style scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }

    /* header */
    .segment {
        padding: 0;

    }
    .item.title.text {
        font-size: 26px;
        font-weight: bold;
    }

    /* title */
    .title a {
        color: #FF773E;
    }
    .title.text a {
        margin-left: -10px;
    }

    /* SP縦横 */
    @media screen and (max-width: 599px) {
        /* header */
        .ui.text.menu {
            margin: 0;
        }
        .item.title {
            font-size: 8px;
        }
        .item.title.text {
            font-size: 16px;
        }

        /* municipality */
        .ui.right.item {
            font-size: 12px;
        }
    }
</style>
