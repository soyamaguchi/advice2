<template>
    <div class="ui vertica footer segment">
        <div class="ui center aligned container">
            <div class="ui stackable inverted divided grid">
                <h2 class="footer-title">運営者</h2>
                <ul>
                    <li><a href="https://github.com/soyamaguchi"><i class="github icon"></i>GitHub</a></li>
                    <li><a href="#"><i class="twitter icon"></i>Twitter</a></li>
                    <li><a href="mailto:d.soyamaguchi@gmail.com"><i class="paper plane icon"></i>d.soyamaguchi@gmail.com</a></li>
                </ul>
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
        },
        methods: {
        }
    }
</script>

<style lang="scss" scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }

    /* footer */
    .footer {
        margin-top: 130px;
        height: 200px;
        background-color: #25a2c3;
        a {
            color: #c8e7f0;
        }
    }



</style>
