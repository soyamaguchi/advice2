<template>
    <transition name="modal" appear>
        <div class="modal modal-overlay" @click.self="$emit('close')">
            <div class="modal-window">
                <header class="modal-header">
                    <slot name="header">
                        <a @click="$emit('close')">×</a>
                    </slot>
                </header>
                <div class="modal-title">
                    <slot name="title"></slot>
                </div>
                <div class="modal-content">
                    <slot></slot>
                </div>
                <footer class="modal-footer">
                    <slot name="footer">
                        <a @click="$emit('close')">screenTransition</a>
                    </slot>
                </footer>
            </div>
        </div>
    </transition>
</template>

<script>
</script>

<style lang="scss" scoped>
    /* modal */
    .modal {
        &.modal-overlay {
            display: flex;
            align-items: center;
            justify-content: center;
            position: fixed;
            z-index: 30;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
        }
        /* Background pattern from Toptal Subtle Patterns */
        &-window {
            position: fixed;
            background-image: url("/imgs/email-pattern.png");
            border-radius: 4px;
            overflow: hidden;
            /* SP縦横 */
            @media screen and (max-width: 599px) {
                height: 80%;
                width: 90%;
            }
            /* tablet */
            @media screen and (min-width: 600px) and (max-width: 959px) {
                height: 60%;
                width: 70%;
            }
            /* 小型PC */
            @media screen and (min-width:960px) and (max-width:1279px) {
                height: 40%;
                width: 60%;
            }
            height: 60%;
            width: 40%;
        }
        &-header {
            height: 5%;
            text-align: right;
            padding: 5px 10px;
            font-size: 25px;
        }
        &-title {
            padding: 10px 20px;
            height: 15%;
        }
        &-content {
            overflow-y: auto;
            -ms-overflow-style: none;
            padding: 10px 20px;
            margin-top: 15px;
            height: 57%;
        }
        &-content::-webkit-scrollbar {
            display: none;
        }
        &-footer {
            position: absolute;
            bottom: 0;
            background: rgba(204, 204, 204, 0.2);
            width: 100%;
            height: 20%;
            /* SP(狭い画面用) */
            @media screen and (max-width: 359px) {
                padding: 10px;
            }
            padding: 20px;
            text-align: left;
        }
    }

    /* overlay transition(animation) */
    .modal-enter-active, .modal-leave-active {
        transition: opacity 0.1s;

        /* modalwindow transition */
        .modal-window {
            transition: opacity 0.1s, transform 0.1s;
        }
    }

    /* delay */
    .modal-leave-active {
        transition: opacity 0.1s ease 0.1s;
    }

    .modal-enter, .modal-leave-to {
        opacity: 0;

        .modal-window {
            opacity: 0;
            transform: translateY(-20px);
        }
    }
</style>