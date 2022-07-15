<template>
  <div class="container public">
    <div class="row justify-content-center">
      <div class="form">
        <MainLogo/>
        <form @submit.prevent="submitForm">
          <div v-show="errorMessage" class="alert alert-danger failed">{{ errorMessage }}</div>
          <div class="form-group">
            <label for="username">Username 2 {{$v.form.username.$params.minLength.min}} {{$v.form.username.$dirty}}</label>
            <input type="text" class="form-control" id="username" v-model="form.username">
            <div class="field-error" v-if="$v.form.username.$dirty">
              <div class="error" v-if="true">Prueba true</div>
              <div class="error" v-if="!false">Prueba !false</div>
              <div class="error" v-if="1==1">Prueba 1=1</div>
              <div class="error" v-if="!$v.form.username.required">Username is required</div>
              <div class="error" v-if="!$v.form.username.alphaNum">Username can only contain letters and numbers</div>
              <div class="error" v-if="!$v.form.username.minLength">Username must have at least {{$v.form.username.$params.minLength.min}} letters.</div>
              <div class="error" v-if="!$v.form.username.maxLength">Username is too long. It can contains maximium {{$v.form.username.$params.maxLength.max}} letters.</div>
            </div>
          </div>
          <div class="form-group">
            <label for="emailAddress">Email address</label>
            <input type="email" class="form-control" id="emailAddress" v-model="form.emailAddress">
            <div class="field-error" v-if="$v.form.emailAddress.$dirty">
              <div class="error" v-if="!$v.form.emailAddress.required">Email address is required</div>
              <div class="error" v-if="!$v.form.emailAddress.email">This is not a valid snishi email address</div>
              <div class="error" v-if="!$v.form.emailAddress.maxLength">Email address is too long. It can contains maximium {{$v.form.emailAddress.$params.maxLength.max}} letters.</div>
            </div>
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" v-model="form.password">
            <div class="field-error" v-if="$v.form.password.$dirty">
              <div class="error" v-if="!$v.form.password.required">Password is required</div>
              <div class="error" v-if="!$v.form.password.minLength">Password is too short. It can contains at least {{$v.form.password.$params.minLength.min}} letters.</div>
              <div class="error" v-if="!$v.form.password.maxLength">Password is too long. It can contains maximium {{$v.form.password.$params.maxLength.max}} letters.</div>
            </div>
          </div>
          <div class="form-group">
            <label>Validation status:</label>
            <ul>
              <li v-if="$v.form.username.$invalid">Field A is <kbd>$invalid</kbd>.</li>
              <li v-if="$v.form.username.$error">Field A has <kbd>$error</kbd> and <kbd>$anyError</kbd>.</li>
              <li v-if="$v.$invalid">Form is <kbd>$invalid</kbd>.</li>
              <li v-else>All fine.</li>
              <li v-if="$v.$error"><strong>Form has <kbd>$error</kbd>.</strong></li>
              <li v-if="$v.$anyError"><strong>Form has <kbd>$anyError</kbd>.</strong></li>
            </ul>
          </div>
          <button type="submit" class="btn btn-primary btn-block">Create account</button>
          <p class="accept-terms text-muted">By clicking “Create account”, you agree to our <a href="#">terms of service</a> and <a href="#">privacy policy</a>.</p>
          <p class="text-center text-muted">Already have an account? <a href="/login">Sign in</a></p>
        </form>
      </div>
    </div>
    <PageFooter/>
  </div>
</template>
<script>
import { required, email, minLength, maxLength, alphaNum } from 'vuelidate/lib/validators'
import registrationService from '@/services/registration'
import MainLogo from '@/components/MainLogo.vue'
import PageFooter from '@/components/PageFooter.vue'

export default {
  name: 'RegisterPage',
  data: function () {
    return {
      form: {
        username: '',
        emailAddress: '',
        password: ''
      },
      errorMessage: ''
    }
  },
  components: {
    MainLogo,
    PageFooter
  },
  validations: {
    form: {
      username: {
        required,
        minLength: minLength(12),
        maxLength: maxLength(50),
        alphaNum
      },
      emailAddress: {
        required,
        email,
        maxLength: maxLength(100)
      },
      password: {
        required,
        minLength: minLength(6),
        maxLength: maxLength(30)
      }
    }
  },
  methods: {
    submitForm () {
      console.log('SNI entra al submit')
      this.$v.$touch()
      if (this.$v.$invalid) {
        console.log('SNI Error inválido 1')
        consolcd ..e.log('SNI this.$v.$invalid ' + this.$v.$invalid)
        console.log('SNI Error inválido 2')
        return
      }
      console.log('SNI llamando a registrationService.register')
      registrationService.register(this.form).then(() => {
        console.log('SNI registrationService.register promesa recibida')
        this.$router.push({ name: 'login' })
      }).catch((error) => {
        console.log('SNI error llamando al web service')
        this.errorMessage = 'Failed to register user. ' + error.message
      })
      console.log('SNI Fin llamando al web service')
    }
  }
}
</script>

<style lang="scss">
.accept-terms {
  margin: 20px 0 40px 0;
}
</style>
