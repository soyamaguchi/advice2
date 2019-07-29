<template>
    <div class="ui vertical footer">
        <div class="ui container center aligned">
            <h2 class="footer-title">運営者</h2>
            <ul>
                <li><a href="https://github.com/soyamaguchi" target="_blank"><i class="github icon"></i>GitHub</a></li>
                <li><a href="#" target="_blank"><i class="twitter icon"></i>Twitter</a></li>
                <li><a href="mailto:soyamaguchi.d@gmail.com"><i class="paper plane icon"></i>soyamaguchi.d@gmail.com</a></li>
            </ul>
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
        height: 250px;
        background-color: #25a2c3;
        .footer-title {
            padding-top: 30px;
            color: #FFFFFF;
            font-size: 26px;
        }
        ul {
            padding: 0;
            list-style: none;
        }
        li {
            margin: 10px;
            a {
                color: #c8e7f0;
                font-size: 17px;
                i {
                    color: #FF773E;
                }
            }
        }
    }
</style>
