<template>
    <div class="ui segment">
        <div class="ui text menu">
            <div class="item title">
                <router-link to="/">
                    <font-awesome-icon icon="graduation-cap" size="3x"/>
                </router-link>
            </div>
            <div class="item title text">
                <router-link to="/">
                    <h2>Advice2</h2>
                </router-link>
            </div>
            <div class="ui right dropdown item">
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
</template>

<script>
    export default {
        data: function () {
            return {
            }
        },
        mounted() {
            /** show dropdown on hover */
            $('.ui.dropdown').dropdown({
                on: 'hover'
            });
        },
        methods: {
        }
    }
</script>

<style scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }

    /* header */
    .segment {
        padding: 0px 150px 0px 150px;
    }
    .ui.text.menu {
        padding-top: 0px;
    }

    /* title */
    .title a {
        color: #FF773E;
    }
    .title.text a {
        margin-left: -5px;
    }

</style>
