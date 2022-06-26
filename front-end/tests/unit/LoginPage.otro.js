import Vue from 'vue'
import LoginPage from '@/views/LoginPage'

describe('LoginPage.vue', () => {
    it('should render correct contents', () => {
        const Constructor = Vue.extend(LoginPage)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('#lbl_username').textContent).toEqual('Username or email address')
    })
})
