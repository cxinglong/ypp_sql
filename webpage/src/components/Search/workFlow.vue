<template>
  <div>
    <Row>
      <Card>
        <div class="step-header-con">
          <h3>{{ stepData.title }}</h3>
          <h5>{{ stepData.describe }}</h5>
        </div>
        <p class="step-content"></p>
        <Row>
          <i-col span="8">
            <Alert type="warning" show-icon>
              使用说明:
              <span slot="desc">
              1.目前仅开放 隔离只读 环境的select权限，与生产隔离且关键字段已脱敏。
              <br>
              2.所有提交的查询语句均会进行后台审计记录。
              <br>
              3.仅支持select语句,不可使用非查询语句。
              <br>
              4.已限制最大limit 100，如自己输入的limit数大于平台配置的最大limit数则已平台配置的Limit数为准。
            </span>
            </Alert>
          </i-col>
          <i-col span="6">
            <Form ref="step" :model="step" :rules="stepRules" :label-width="150">
              <FormItem label="环境:" prop="computer_room">
                <Select v-model="step.computer_room"  @on-change="Connection_Name">
                  <Option v-for="i in datalist.computer_roomlist" :key="i" :value="i">{{i}}</Option>
                </Select>
              </FormItem>
              <Form-item label="业务信息:" prop="connection_name">
                <Select v-model="step.connection_name" filterable>
                  <Option v-for="i in datalist.connection_name_list" :value="i.connection_name" :key="i.connection_name">{{ i.connection_name }}</Option>
                </Select>
              </Form-item>
              <FormItem label="">
                <Button @click="handleSubmit" style="width:100px;" type="primary">进入查询页</Button>
              </FormItem>
            </Form>
          </i-col>
        </Row>
      </Card>
    </Row>
  </div>
</template>

<script>
  //
  import axios from 'axios'
  import util from '../../libs/util'

  export default {
    name: 'work_flow',
    props: ['msg'],
    data () {
      return {
        stepData: {
          title: '比心数据库集中查询平台',
          describe: `欢迎你！ ${sessionStorage.getItem('user')}`
        },
        step: {
          remark: '',
          computer_room: '',
          connection_name: ''
        },
        stepList1: [
          {
            title: '提交',
            describe: '提交查询申请'
          },
          {
            title: '审核',
            describe: '等待审核结果'
          },
          {
            title: '查询',
            describe: '审核完毕，进入查询页面'
          }
        ],
        stepRules: {
          computer_room: [{
            required: true,
            message: '环境地址不得为空',
            trigger: 'change'
          }],
          connection_name: [{
            required: true,
            message: '业务信息不得为空',
            trigger: 'change'
          }],
          basename: [{
            required: true,
            message: '数据库名不得为空',
            trigger: 'change'
          }]
        },
        item: {},
        datalist: {
          connection_name_list: [],
          basenamelist: [],
          sqllist: [],
          computer_roomlist: util.computer_room
        }
      }
    },
    methods: {
      Connection_Name (val) {
        this.datalist.connection_name_list = []
        this.datalist.basenamelist = []
        this.step.connection_name = ''
        this.step.basename = ''
        if (val) {
          this.ScreenConnection(val)
        }
      },
      ScreenConnection (val) {
        this.datalist.connection_name_list = this.item.filter(item => {
          if (item.computer_room === val) {
            this.$set(this.step, 'connection_name', item.connection_name)
            return item
          }
        })
      },
      handleSubmit () {
        this.$refs['step'].validate((valid) => {
          if (valid) {
            axios.put(`${util.url}/query_worklf`, {
              'mode': 'put',
              'connection_name': this.step.connection_name,
              'computer_room': this.step.computer_room
            })
              .then(() => {
                this.$router.push({
                  name: 'queryready'
                })
              })
          }
        })
      }
    },
    mounted () {
      axios.put(`${util.url}/workorder/connection`, {'permissions_type': 'query'})
        .then(res => {
          this.item = res.data['connection']
          this.datalist.computer_roomlist = res.data['custom']
          this.$set(this.step, 'computer_room', this.datalist.computer_roomlist[2])
          this.ScreenConnection(this.datalist.computer_roomlist[2])
        })
        .catch(error => {
          util.err_notice(error)
        })
      axios.put(`${util.url}/query_worklf`, {'mode': 'status'})
        .then(res => {
          if (res.data === 1) {
            this.$router.push({
              name: 'querypage'
            })
          } else if (res.data === 2) {
            this.$router.push({
              name: 'queryready'
            })
          }
        })
    }
  }
</script>

<style lang="less">
  .step {
    &-header-con {
      text-align: center;
      h3 {
        margin: 10px 0;
      }
      h5 {
        margin: 0 0 5px;
      }
    }
    &-content {
      padding: 5px 20px 26px;
      margin-bottom: 20px;
      border-bottom: 1px solid #dbdddf;
    }
    &-form {
      padding-bottom: 10px;
      border-bottom: 1px solid #dbdddf;
      margin-bottom: 20px;
    }
  }
</style>
