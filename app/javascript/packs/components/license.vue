<template>
    <div class="ui container">
        <div class="ui raised segment">
            <h2 class="ui header title">ライセンス情報</h2>
            <p>Advice2で利用している素材や参考にしているデザイン等のライセンスを表記しています</p>
            <h3 class="ui header">Subtle Patterns</h3>
            <p>Background pattern from <a href="https://www.toptal.com/designers/subtlepatterns/" target="_blank">Toptal Subtle Patterns</a></p>
            <h3 class="ui header">Templated</h3>
            <p class="last-row">design from <a href="https://templated.co" target="_blank">Templated</a></p>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            /** init */
            this.setScreenIdentFlag()
        },
        methods: {
            setScreenIdentFlag: function() {
                this.$store.commit('isIndex', false)
            },
        },
    }
</script>

<style lang="scss" scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }

    /* SP縦横*/
    @media screen and (max-width: 599px) {
        .container .ui.container {
            margin: -1em 0 0 0 !important;
        }
    }

    /* container */
    .ui.container {
        display: flex;
        flex-direction: column;
        min-height: 60vh;
        margin-top: 50px;
        .ui.header.title {
            padding-top: 20px;
        }
        p {
            line-height: 2;
        }
        a {
            color: #25a2c3;
        }
        .last-row {
            padding-bottom: 20px;
        }
    }
</style>