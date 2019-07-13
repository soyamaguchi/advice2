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
                    <div class="ui orange buttons">
                        <div class="ui button category">全て</div>
                        <div class="ui combo top right pointing dropdown icon button">
                            <i class="dropdown icon"></i>
                            <div class="menu">
                                <div class="item"><i class="edit icon"></i> Edit</div>
                                <div class="item"><i class="delete icon"></i> Delete</div>
                                <div class="item"><i class="hide icon"></i> Hide</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="column">
                    <div class="ui link four doubling cards">
                        <div class="red card">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">Test補償制度testtestetsttesttesttesttesttest</div>
                                <div class="meta"><span class="category">test-category</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：2019年7月7日</span>
                            </div>
                        </div>
                        <div class="orange card">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">Test補償制度01</div>
                                <div class="meta"><span class="category">test-category</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：2019年7月7日</span>
                            </div>
                        </div>
                        <div class="yellow card">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">Test補償制度01</div>
                                <div class="meta"><span class="category">test-category</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：2019年7月7日</span>
                            </div>
                        </div>
                        <div class="violet card">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">Test補償制度01</div>
                                <div class="meta"><span class="category">test-category</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：2019年7月7日</span>
                            </div>
                        </div>
                        <div class="pink card">
                            <div class="image center aligned">
                                <font-awesome-icon icon="graduation-cap" size="5x" class="fai"/>
                            </div>
                            <div class="content main-title">
                                <div class="header">Test補償制度01</div>
                                <div class="meta"><span class="category">test-category</span></div>
                            </div>
                            <div class="extra content">
                                <span><i class="sync alternate icon"></i>更新日：2019年7月7日</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };

    /** semantic ui color const */
    const colorArr = ["red", "orange", "yellow", "olive", "green", "teal", "blue", "violet", "purple", "pink", "brown", "grey", "black"];

    export default {
        data: function() {
            return {
                queryParams: {
                    city: 1,
                    category: "",
                },
                contents: []
            }
        },
        mounted() {
            /** ドロップダウンボタン */
            $('.combo.dropdown').dropdown({
                on: 'hover',
                action: 'combo'
            });

            /** 初期表示時 */
            this.getContents();
        },
        methods: {
            getContents: function() {
              axios.get('api/contents', { params: {q: this.queryParams } }).then((res) => {

              }, (err) => {
                  console.log(err)
              });
            },
        }
    }

</script>

<style scoped>
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
    .ui .buttons {
        margin: 20px 0px 20px 0px;
    }
    .ui.button.category {
        width: 130px;
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