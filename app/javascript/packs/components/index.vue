<template>
    <div class="ui grid container">
        <div class="row">
            <div class="column">
                <section>
                    <h1 class="ui header">知っておいて損はない<br>お得な自治体情報</h1>
                    <p class="sub-header">知らないことで損をしないために</p>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="column center aligned">
                <div class="ui floating dropdown labeled icon orange button">
                    <i class="filter icon"></i>
                    <span class="category text">全て</span>
                    <div class="menu">
                        <div class="ui icon search input">
                            <i class="search icon"></i>
                            <input type="text" placeholder="カテゴリ検索">
                        </div>
                        <div class="divider"></div>
                        <div class="header"><i class="tags icon"></i>カテゴリ</div>
                        <div class="scrolling menu">
                            <div v-for="(category, i) in categories[city]" :id="i" @click="categoryContents" class="item">
                                <div :class="[color(i), 'ui', 'empty', 'circular', 'label']"></div>
                                {{ category }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="column">
                <div class="ui raised link four stackable cards">
                    <div v-for="(c, i) in contents" :id="i" class="raised link card" @click="openModalContent">
                        <div class="content main-title center aligned">
                            <i :class="['big circular', color(c.category_id), icons[c.city_id][c.category_id], 'icon', transparentColor(c.category_id)]"></i>
                            <div class="header">{{ c.main_title }}</div>
                            <div class="meta"><span class="category">{{ c.category_name }}</span></div>
                        </div>
                        <div class="extra content">
                            <span><i class="sync alternate icon"></i>更新日：{{ c.update_time }}</span>
                        </div>
                    </div>
                </div>
                <ModalContent @close="closeModalContent" v-if="targetModalContent">
                    <template slot="header">
                        <a @click="closeModalContent" href="javascript:void(0)" class="close-modal">×</a>
                    </template>
                    <template slot="title">
                        <p class="modal main-title">{{ targetModalContent.main_title }}</p>
                        <div :class="['ui', targetModalContent.color, 'ribbon label']">
                            <i :class="[icons[targetModalContent.city_id][targetModalContent.category_id], 'icon']"></i>{{ targetModalContent.category_name }}
                        </div>
                    </template>
                    <p class="modal sub-title" v-if="targetModalContent.sub_title">{{ targetModalContent.sub_title }}</p>
                    <p class="modal content">{{ targetModalContent.content }}</p>
                    <template slot="footer">
                        <p>下記の出典元情報を加工して掲載しております</p>
                        <a :href="targetModalContent.url" target="_blank">
                            <i class="book icon"></i> 出典：{{ targetModalContent.prefecture }} {{ targetModalContent.city }}{{ targetModalContent.ward }}のサイト
                        </a>
                    </template>
                </ModalContent>
            </div>
        </div>
    </div>
</template>

<script>
    import ModalContent from './ModalContent';
    import axios from 'axios';
    import Qs from 'qs';
    /*import { mapActions, mapGetters, mapMutations, mapState } from 'vuex';*/
    axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };

    export default {
        components: {
          ModalContent
        },
        data: function() {
            return {
                /** semantic ui colors */
                colorArr: ["red", "orange", "yellow", "olive", "green", "teal", "blue", "violet", "purple", "pink", "brown", "grey", "black"],
                transparentColorArr: ["transparent-red", "transparent-orange", "transparent-yellow", "transparent-olive", "transparent-green", "transparent-teal", "transparent-blue", "transparent-violet", "transparent-purple", "transparent-pink", "transparent-brown", "transparent-grey", "transparent-black"],
                /** categories */
                categories: {
                    1: ["行政オンラインサービス", "妊娠・出産", "子育て", "教育", "結婚・離婚", "引越し・住まい", "就職・退職", "介護・高齢者", "ご不幸", "台風21号関連", "大阪府北部を震源とする地震関連", "安全・安心", "戸籍・住民票・印鑑登録", "税", "国民健康保健", "国民年金", "水道・ガス・電気", "交通", "駐輪・駐車", "都市計画", "ごみ・環境保全", "食品・衛生", "ペット・動物", "消費生活", "健康・医療・福祉", "文化・スポーツ・生涯学習", "市民活動"],
                },
                /** icons */
                icons: {
                    1: ["desktop", "female", "sign language", "edit", "bell outline", "home", "building", "wheelchair", "bed", "certificate", "chart area", "shield alternate", "clone outline", "yen sign", "medkit", "money bill alternate outline", "tint", "road", "car", "globe", "trash", "utensil spoon", "paw", "shopping cart", "stethoscope", "play", "handshake outline"],
                },
                /** indexcomponen init exist*/
                indexInitFlag: this.$store.state.indexInitFlag,
                /** modal active content */
                targetModalContent: null,
                /** queryparameter */
                queryParams: {
                    city: 1,
                    category: "",
                },
                /** responsedata */
                contents: [],
                city: "",
            }
        },
        mounted() {
            if (this.indexInitFlag) {
                location.reload();
            } else {
                /** dropdown button */
                $('.combo.dropdown').dropdown({
                    action: 'combo'
                });

                /** init */
                this.setScreenIdentFlag();
                this.setIndexInitFlag();
                this.getContents();
            }
        },
        methods: {
            getContents: function() {
                axios.get('api/contents', { params: { q: this.queryParams }, paramsSerializer: (params) => Qs.stringify(params, { arrayFormat: 'brackets' }) }).then((res) => {
                    this.contents.splice(0)
                    res.data.contents.forEach(v => this.contents.push(v))
                    this.city = (this.contents.length > 0) ? this.contents[0].city_id : 1
                }, (err) => {
                    this.contents.splice(0)
                    console.log(err)
                });
            },
            categoryContents: function(e) {
                this.$set(this.queryParams, "category", e.target.id)
                this.getContents()
            },
            openModalContent: function(e) {
                const contentDom = e.target.offsetParent || e.target.parentElement.offsetParent || e.target.parentElement.parentElement.offsetParent
                this.targetModalContent = this.contents[contentDom.id]
                this.$set(this.targetModalContent, "color", contentDom.firstChild.firstChild.className.split(" ").slice(-1)[0])
            },
            closeModalContent: function() {
                this.targetModalContent = null
            },
            color: function(i) {
                const colorLength = this.colorArr.length
                if (i < colorLength) return this.colorArr[i]
                const incr = Math.floor(i / 13)
                return this.colorArr[i - colorLength * incr]
            },
            transparentColor: function(i) {
                const transparentColorLength = this.transparentColorArr.length
                if (i < transparentColorLength) return this.transparentColorArr[i]
                const incr = Math.floor(i / 13)
                return this.transparentColorArr[i - transparentColorLength * incr]
            },
            setScreenIdentFlag: function() {
                this.$store.commit('isIndex', true)
            },
            setIndexInitFlag: function() {
                this.$store.commit('indexInitFlag', true)
            },
            /*...mapActions('contents', {
                'isIndex': 'isIndex'
            }),*/
        }
    }
</script>

<style lang="scss" scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }
    .ui.grid.container {
        display: flex;
        flex-direction: column;
        min-height: 65vh;
        margin-top: 20px;
    }

    /* description */
    .ui.header {
        margin-bottom: 5px;
    }
    .sub-header {
        font-size: 20px;
        color: rgba(0, 0, 0, 0.5);
    }

    /* category button */
    .ui.button {
        margin: 20px 0px 25px 0px;
        width: 320px;
        .category.text {
            width: 100%;
            text-align: center;
        }
    }

    /* content card */
    .card .content.main-title {
        height: 230px;
    }
    .card .big.icon {
        margin-bottom: 25px;
    }
    .card i.circular.icon {
        -webkit-box-shadow: initial;
        box-shadow: initial;
    }
    .card .content .header {
        word-break: break-all;
    }
    .card .content .meta {
        margin-top: 3px;
    }

    /* modal「×」button color */
    a.close-modal {
        color: rgba(0, 0, 0, 0.2);
    }
    /* modal maintitle */
    .modal.main-title {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        font-size: 22px;
    }
    /* modal subtitle */
    .modal.sub-title {
        margin-bottom: 10px;
        font-size: 18px;
    }
    /* modal content */
    .modal.content {
        font-size: 16px;
        color: rgba(0, 0, 0, 0.7);
    }

    /* semantic-ui cardのmargin上書き */
    @media only screen and (max-width: 767px) {
        .ui.stackable.cards .card {
            margin: 2em 1em;
        }
    }

    /* SP(狭い画面用) */
    @media screen and (max-width: 379px) {
        .ui.header {
            font-size: 24px;
        }
        .ui.button {
            width: 87%;
        }
    }
    /* SP縦 */
    @media screen and (min-width: 380px) and (max-width: 479px) {
        .ui.header {
            font-size: 24px;
        }
        .ui.button {
            width: 87%;
        }
        .ui.stackable.cards .card {
            margin: 2em 2em;
        }
        .column .ui.stackable.cards .card {
            width: calc(100% - 4em) !important;
        }
    }
    /* SP横 */
    @media screen and (min-width: 480px) and (max-width: 599px) {
        .ui.header {
            font-size: 24px;
        }
        .ui.stackable.cards .card {
            margin: 2em 4em;
        }
        .column .ui.stackable.cards .card {
            width: calc(100% - 8em) !important;
        }
    }
    /* tablet */
    @media screen and (min-width: 600px) and (max-width: 959px) {
    }
</style>