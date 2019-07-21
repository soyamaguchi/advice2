<template>
    <transition name="modal" appear>
        <div class="modal modal-overlay" @click.self="$emit('close')">
            <div class="modal-window">
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
    .modal.modal-overlay {
        display: flex;
        align-items: center;
        justify-content: center;
        position: fixed;
        z-index: 30;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
    }
    .modal-window {
        background-color: #fff;
        border-radius: 4px;
        overflow: hidden;
    }
    .modal-content {
        padding: 10px 20px;
    }
    .modal-footer {
        background-color: #ccc;
        padding: 10px;
        text-align: left;
    }

    /* overlay transition */
    .modal-enter-active,
    .modal-leave-active {
        transition: opacity 0.3s;
    }
    /* overlay modalwindow transition */
    .modal-enter-active .modal-window
    .modal-leave-active .modal-window {
        transition: opacity 0.3s ease 0.3s;
    }
    /* delay */
    .modal-leave-active {
        transition: opacity 0.6s ease 0.4s;
    }

    .modal-enter
    .modal-leave-to {
        opacity: 0;
    }
    .modal-enter .modal-window
    .modal-leave-to .modal-window {
        opacity: 0;
        transform: translateY(-20px);
    }
</style>