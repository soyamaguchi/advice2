<template>
    <div>
        <div class="ui grid container">
            <div class="row">
                <div class="column">
                    <section>
                        <h1 class="ui header">知っておいて損はないお得な自治体情報</h1>
                        <p class="sub-header">知らないことで損をしないために</p>
                    </section>
                </div>
            </div>
            <div class="row">
                <div class="column center aligned">
                    <div class="ui floating dropdown labeled icon orange button">
                        <i class="filter icon"></i>
                        <span class="text">　全て　</span>
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
                    <div class="ui link four stackable cards">
                        <div v-for="(c, i) in contents" :id="'isModalActive' + i" :class="[color(i), 'card']" @click="openModalContent">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">{{ c.main_title }}</div>
                                <div class="meta"><span class="category">{{ c.category_name }}</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：{{ c.update_time }}</span>
                            </div>

                            <ModalContent @close="closeModalContent" v-if="ModalActiveArr.isModalActive0">
                                <p>Vue.js Modal Window!</p>
                                <div>TestSample</div>
                                <template slot="footer">
                                    <p>下記の出典元情報を加工して掲載しております</p>
                                    <a :href="c.url">出典：{{ c.prefecture }} {{ c.city }}{{ c.ward }}のサイト</a>
                                </template>
                            </ModalContent>

<!--                            <div :class="['modal', {'active': isModalActive}]">-->
<!--                                modal test-->
<!--                            </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import ModalContent from './ModalContent';
    import axios from 'axios';
    import Qs from "qs";
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
                /** categories */
                categories: {
                    1: ["行政オンラインサービス", "妊娠・出産", "子育て", "教育", "結婚・離婚", "引越し・住まい", "就職・退職", "介護・高齢者", "ご不幸", "台風21号関連", "大阪府北部を震源とする地震関連", "安全・安心", "戸籍・住民票・印鑑登録", "税", "国民健康保健", "国民年金", "水道・ガス・電気", "交通", "駐輪・駐車", "都市計画", "ごみ・環境保全", "食品・衛生", "ペット・動物", "消費生活", "健康・医療・福祉", "文化・スポーツ・生涯学習", "市民活動"],
                },
                /** modal activeflag */
                ModalActiveArr: {
                },
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
        computed: {
        },
        mounted() {
            /** dropdown button */
            $('.combo.dropdown').dropdown({
                // on: 'hover',
                action: 'combo'
            });

            /** init */
            this.getContents();
        },
        methods: {
            getContents: function() {
                axios.get('api/contents', { params: { q: this.queryParams }, paramsSerializer: (params) => Qs.stringify(params, { arrayFormat: 'brackets' }) }).then((res) => {
                    [...Array(this.contents.length)].forEach((_, i) => this.$delete(this.ModalActiveArr, "isModalActive" + i))
                    this.contents.splice(0)
                    res.data.contents.forEach((v, i) => {
                        this.contents.push(v)
                        this.$set(this.ModalActiveArr, "isModalActive" + i, false)
                    })
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
                this.ModalActiveArr[contentDom.id] = true
            },
            closeModalContent: function() {
                // this.isModalActive
            },
            color: function(i) {
                const colorLength = this.colorArr.length
                if (i < colorLength) return this.colorArr[i]
                return this.colorArr[i - colorLength]
            },
        }
    }

</script>

<style lang="scss" scoped>
    /* 全体 */
    [v-cloak] {
        display: none;
    }
    .ui.container {
        margin-top: 60px;
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
        margin: 20px 0px 20px 0px;
    }

    /* content */
    .card .image {
        height: 130px;
    }
    .card .fai {
        margin-top: 30px;
    }
    .card .content.main-title {
        height: 140px;
    }
    .card .content .header {
        word-break : break-all;
    }
    .card .content .meta {
        margin-left: 3px;
        margin-top: 3px;
    }
</style>