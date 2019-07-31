<template>
    <div class="ui vertical footer">
        <div class="ui container center aligned developer">
            <h2 class="footer-title">管理者</h2>
            <ul>
                <li><a href="https://github.com/soyamaguchi" target="_blank"><i class="github icon"></i>GitHub</a></li>
                <li><a href="#" target="_blank"><i class="twitter icon"></i>Twitter</a></li>
                <li><a href="mailto:soyamaguchi.d@gmail.com"><i class="paper plane icon"></i>soyamaguchi.d@gmail.com</a></li>
            </ul>
        </div>
        <div class="ui container center aligned site-info">
            <router-link to="/terms" class="terms">利用規約</router-link>
            <router-link to="/privacy" class="privacy">プライバシーポリシー</router-link>
            <router-link to="/license" class="license">ライセンス</router-link>
        </div>
        <div class="ui container center aligned copyright">
            © 2019 Advice2.com
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
        .developer {
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
        .site-info {
            width: 40%;
            border-top: 1px solid rgba(255, 255, 255, 0.3);
            padding-top: 10px;
            a {
                margin: 20px;
                color: #c8e7f0;
                font-size: 14px;
            }
        }
        .copyright {
            margin-top: 20px;
            color: #a7d9e7;
        }
    }
</style>
