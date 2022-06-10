<template>
  <div class="container">
    <div class="row justify-content-center">
      <div class="form">
        <form @submit.prevent="submitForm">
          <div v-show="errorMessage" class="alert alert-danger failed">{{ errorMessage }}</div>
          <div class="form-group">
            <label for="username">Username min:{{$v.form.username.$params.minLength.min}} dirty:{{$v.form.username.$dirty}}</label>
            <input type="text" class="form-control" id="username" v-model="form.username">
            <div class="alert" v-if="$v.form.username.$dirty">
              <div class="alert alert-danger" v-if="!$v.form.username.required">Username is required</div>
              <div class="alert alert-danger" v-if="!$v.form.username.alphaNum">Username can only contain letters and numbers</div>
              <div class="alert alert-danger" v-if="!$v.form.username.minLength">Username must have at least {{$v.form.username.$params.minLength.min}} letters.</div>
              <div class="alert alert-danger" v-if="!$v.form.username.maxLength">Username is too long. It can contains maximium {{$v.form.username.$params.maxLength.max}} letters.</div>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">Create account</button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
import { required, minLength, maxLength, alphaNum } from 'vuelidate/lib/validators'

export default {
  name: 'TestPage',
  data: function () {
    return {
      form: {
        username: ''
      },
      errorMessage: ''
    }
  },
  validations: {
    form: {
      username: {
        required,
        minLength: minLength(12),
        maxLength: maxLength(50),
        alphaNum
      }
    }
  },
  methods: {
    submitForm () {
      console.log('SNI entra al submit')
      this.$v.$touch()
      if (this.$v.$invalid) {
        console.log('SNI Error inválido 1')
        console.log('SNI this.$v.$invalid ' + this.$v.$invalid)
        console.log('SNI Error inválido 2')
        return
      }
      console.log('SNI Fin llamando al web service')
    }
  }
}
</script>

<style lang="scss">
.accept-terms {
  margin: 20px 0 40px 0;
}
.sni-error {
  font-style: oblique;
  color: red;
}
</style>
