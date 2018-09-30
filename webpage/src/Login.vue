<style>
  .div-relative {
    position: relative;
    width: 100%;
  }

  .div-a {
    position: absolute;
    left: 38%;
    top: 20%;
    width: 350px;
    height: 100px
  }
</style>

<template>
  <div id="band" class="div-relative">
    <div class="div-a">
      <div style='margin-left: 10%'>
        <!-- <Icon  img="/static/logo.png" size="60" style="margin-top:5%"></Icon> -->
        <p style="margin-left: 20%;margin-top: -10%;font-size: 20px; color: #0066cc">yupaopao SQL 审核平台</p>
      </div>
      <br>
      <Card>
        <Tabs value="ldap">
           <TabPane label="用户登录" name="ldap">
            <Form ref="formInline" :model="formInline" :rules="ruleInline" inline>
              <Form-item prop="user" style="width: 100%">
                <Input v-model="formInline.user" placeholder="ldap_Username">
                </Input>
              </Form-item>
              <Form-item prop="password" style="width: 100%">
                <Input type="password" v-model="formInline.password" placeholder="ldap_Password"
                       @on-keyup.enter="authdata()">
                </Input>
              </Form-item>
              <Form-item style="width: 100%">
                <Button type="primary" @click="ldap_login()" style="width: 100%" size="large">登录</Button>
                <p style="margin-left: 22%;margin-top: 2%">如需注册账号请联系DBA</p>
                <p style="margin-left: 5%;">2018 Power By YPP DBA, 使用chrome获得最佳体验</p>
              </Form-item>
            </Form>
          </TabPane>
          <TabPane label="admin" name="custom">
            <Form ref="formInline" :model="formInline" :rules="ruleInline" inline>
              <Form-item prop="user" style="width: 100%">
                <Input v-model="formInline.user" placeholder="Username">
                </Input>
              </Form-item>
              <Form-item prop="password" style="width: 100%">
                <Input type="password" v-model="formInline.password" placeholder="Password">
                </Input>
              </Form-item>
              <Form-item style="width: 100%">
                <Button type="primary" @click="authdata()" style="width: 100%" size="large">登录</Button>
                <p style="margin-left: 22%;margin-top: 2%">后台管理员登录专用，请使用用户登录</p>
                <p style="margin-left: 5%;">2018 Power By YPP DBA, 使用chrome获得最佳体验</p>
              </Form-item>
            </Form>
          </TabPane>
        </Tabs>
      </Card>
    </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import util from './libs/util'
  import ICol from '../node_modules/iview/src/components/grid/col.vue'
  //
  export default {
    components: {
      ICol
    },
    name: 'Login',
    data () {
      return {
        formInline: {
          user: '',
          password: ''
        },
        ruleInline: {
          user: [{
            required: true,
            message: '请填写用户名',
            trigger: 'blur'
          }],
          password: [{
            required: true,
            message: '请填写密码',
            trigger: 'blur'
          },
            {
              type: 'string',
              min: 6,
              message: '密码长度不能小于6位',
              trigger: 'blur'
            }
          ]
        }
      }
    },
    methods: {
      authdata () {
        axios.post(util.auth, {
          'username': this.formInline.user,
          'password': this.formInline.password
        })
          .then(res => {
            axios.defaults.headers.common['Authorization'] = 'JWT ' + res.data['token']
            sessionStorage.setItem('user', this.formInline.user)
            sessionStorage.setItem('password', this.formInline.password)
            sessionStorage.setItem('jwt', `JWT ${res.data['token']}`)
            sessionStorage.setItem('auth', res.data['permissions'])
            let auth = res.data['permissions']
            if (auth === 'admin' || auth === 'perform') {
              sessionStorage.setItem('access', 0)
            } else {
              sessionStorage.setItem('access', 1)
            }
            this.$router.push({
              name: 'home_index'
            })
          })
          .catch(error => {
            util.ajanxerrorcode(this, error)
          })
      },
      ldap_login () {
        axios.post(`${util.url}/ldapauth`, {
          'username': this.formInline.user,
          'password': this.formInline.password
        })
          .then(res => {
            if (res.data['token'] === 'null') {
              this.$Notice.error({
                title: '警告',
                desc: res.data['res']
              })
            } else {
              axios.defaults.headers.common['Authorization'] = 'JWT ' + res.data['token']
              sessionStorage.setItem('user', this.formInline.user)
              sessionStorage.setItem('password', this.formInline.password)
              sessionStorage.setItem('jwt', `JWT ${res.data['token']}`)
              sessionStorage.setItem('auth', res.data['permissions'])
              let auth = res.data['permissions']
              if (auth === 'admin') {
                sessionStorage.setItem('access', 0)
              } else {
                sessionStorage.setItem('access', 1)
              }
              this.$router.push({
                name: 'home_index'
              })
            }
          })
          .catch(error => {
            util.ajanxerrorcode(this, error)
          })
      }
    },
    mounted () {
      window.particlesJS.load('band', '/static/particlesjs-config.json')
    }
  }
</script>
