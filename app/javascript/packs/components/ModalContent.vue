<template>
    <transition name="modal" appear>
        <div class="modal modal-overlay" @click.self="$emit('close')">
            <div class="modal-window">
                <header class="modal-header">
                    <slot name="header">
                        <a @click="$emit('close')">×</a>
                    </slot>
                </header>
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

        &-window {
            background: #fff;
            border-radius: 4px;
            overflow: hidden;
        }

        &-header {
            text-align: right;
            padding: 5px 10px;
            font-size: 25px;
        }

        &-content {
            padding: 10px 20px;
            size: 100px;
        }

        &-footer {
            background: #ccc;
            padding: 10px;
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