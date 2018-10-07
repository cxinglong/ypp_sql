<style lang="less">
  @import '../../styles/common.less';
  @import '../order/components/table.less';
</style>
<template>
  <div>
    <Col span="24">
      <Card>
        <p slot="title">
          <Icon type="md-apps" />
          数据库详情表
        </p>
        <div class="edittable-con-1">
          <Table :columns="columns" :data="rowdata" height="550"></Table>
        </div>
        <br>
        <Page :total="pagenumber" show-elevator @on-change="mountdata" :page-size="10" ref="totol"></Page>
      </Card>
    </Col>
    <Col span="24">
      <Card>
        <Tabs value="name1">
          <TabPane label="数据库字段" icon="load-b" name="name1">
            <div class="edittable-testauto-con">
              <Form :model="dictionary" :label-width="320" ref="generation">
                <FormItem label="业务信息:" prop="dic">
                  <Select v-model="dictionary.name" placeholder="请选择业务信息" style="width: 100%" @on-change="BaseList"
                          transfer>
                    <Option v-for="i in rowdata" :value="i.id" :key="i.connection_name">{{i.connection_name}}</Option>
                  </Select>
                </FormItem>
                <FormItem label="数据库名:">
                  <Checkbox :indeterminate="dictionary.indeterminate" :value="dictionary.checkAll"
                            @click.prevent.native="dicCheckAll">全选
                  </Checkbox>
                  <CheckboxGroup v-model="dictionary.databases">
                    <Checkbox :label="c" :key="c" v-for="c in dictionary.databasesList"></Checkbox>
                  </CheckboxGroup>
                </FormItem>
              </Form>
            </div>
          </TabPane>
        </Tabs>
      </Card>
    </Col>
  </div>
</template>
<script>
  import '../../assets/tablesmargintop.css'
  import axios from 'axios'
  import util from '../../libs/util'
  import ICol from '../../../node_modules/iview/src/components/grid/col'

  export default {
    components: {
      ICol
    },
    name: 'sqlist',
    data () {
      return {
        columns: [
          {
            title: '业务信息',
            key: 'connection_name'
          },
          {
            title: '数据库地址',
            key: 'ip'
          },
          {
            title: '环境',
            key: 'computer_room'
          }
        ],
        rowdata: [],
        modal: false,
        // 添加数据库信息
        formItem: {
          name: '',
          ip: '',
          add: '',
          username: '',
          password: '',
          port: ''
        },
        // 添加表单验证规则
        ruleInline: {
          name: [{
            required: true,
            message: '请填写业务信息',
            trigger: 'blur'
          }],
          ip: [{
            required: true,
            message: '请填写连接地址',
            trigger: 'blur'
          }],
          username: [{
            required: true,
            message: '请填写用户名',
            trigger: 'blur'
          }],
          port: [{
            required: true,
            message: '请填写端口',
            trigger: 'blur'
          }],
          password: [{
            required: true,
            message: '请填写密码',
            trigger: 'blur'
          }]
        },
        // 生成字典规则
        dataset: [],
        Generate: {
          textarea: '',
          add: '',
          name: ''
        },
        dictionary: {
          name: '',
          add: '',
          databases: [],
          databasesList: [],
          indeterminate: false,
          checkAll: false,
          getdellist: [],
          getdel: [],
          delname: ''
        },
        delbaseModal: false,
        delbasename: '',
        delconfirmbasename: '',
        pagenumber: 1,
        addDingding: false,
        dingdingbeforetext: '',
        dingdingaftertext: '',
        dingname: '',
        dingdingid: null,
        tmp_id: null,
        diclist: [],
        baseinfo: false,
        editbaseinfo: {}
      }
    },
    methods: {
      del () {
        this.modal = false
        this.formItem = {}
      },
      testlink () {
        axios.put(util.url + '/management_db/test', {
          'ip': this.formItem.ip,
          'user': this.formItem.username,
          'password': this.formItem.password,
          'port': this.formItem.port
        })
          .then(res => {
            util.notice(res.data)
          })
          .catch(error => {
            util.err_notice(error)
          })
      },
      add () {
        for (let i of this.rowdata) {
          if (i.connection_name === this.formItem.name) {
            util.err_notice('业务信息重复,请更改为其他!')
            return
          }
        }
        this.$refs['formValidate'].validate((valid) => {
          if (valid) {
            let data = {
              'connection_name': this.formItem.name,
              'ip': this.formItem.ip,
              'computer_room': this.formItem.add,
              'username': this.formItem.username,
              'password': this.formItem.password,
              'port': this.formItem.port
            }
            axios.post(util.url + '/management_db/', {
              'data': JSON.stringify(data)
            })
              .then(() => {
                util.notice('数据库信息添加成功,请对相应用户赋予该数据库访问权限!')
                this.$refs.totol.currentPage = 1
                this.mountdata()
              })
              .catch(error => {
                util.err_notice(error)
              })
            this.del()
          }
        })
      },
      edit_tab (index) {
        this.baseinfo = true
        this.editbaseinfo = this.rowdata[index]
      },
      // 删除数据库
      deldatabases (index) {
        this.delbaseModal = true
        this.delbasename = this.rowdata[index].connection_name
      },
      // 删除数据库字典
      Deletedic () {
        if (this.dictionary.delname.length === 0) {
          this.$Message.error({
            content: '请选择相应的数据库再删除!',
            duration: 5
          })
        } else {
          if (this.dictionary.getdel.length === 0) {
            this.$Message.error({
              content: '请选择相应的数据表再删除!',
              duration: 5
            })
          } else {
            this.$Loading.start()
            axios.put(`${util.url}/adminsql/deldic`, {
              'name': this.dictionary.delname,
              'basename': this.dictionary.getdel
            })
              .then(res => {
                util.notice(res.data)
                this.$Loading.finish()
                this.cleardata()
              })
              .catch(error => {
                util.err_notice(error)
                this.$Loading.error()
              })
          }
        }
      },
      // 生成数据库字典
      Commit () {
        if (this.dictionary.databases.length === 0) {
          this.$Message.error({
            content: '请选择相应的数据库再生成数据字典!',
            duration: 5
          })
        } else {
          this.$Spin.show({
            render: (h) => {
              return h('div', [
                h('Icon', {
                  props: {
                    size: 30,
                    type: 'ios-loading'
                  },
                  style: {
                    animation: 'ani-demo-spin 1s linear infinite'
                  }
                }),
                h('div', '数据库字典正在生成中,请稍后........')
              ])
            }
          })
          axios.put(`${util.url}/adminsql/Generation`, {
            'id': this.tmp_id,
            'basename': JSON.stringify(this.dictionary.databases)
          })
            .then(res => {
              util.notice(res.data)
              this.$Spin.hide()
              this.cleardata()
            }).catch(error => {
            util.err_notice(error)
            this.$Spin.hide()
          })
        }
      },
      // 生成数据库全部库名
      BaseList (vl) {
        if (vl.length === 0) {
          return
        }
        this.tmp_id = vl
        axios.put(`${util.url}/workorder/basename`, {
          'id': vl
        })
          .then(res => {
            this.dictionary.databasesList = res.data
          })
          .catch(() => {
            util.err_notice('数据库信息获取失败,请检查网络状态.')
          })
      },
      // 全选
      dicCheckAll () {
        if (this.dictionary.indeterminate) {
          this.dictionary.checkAll = false
        } else {
          this.dictionary.checkAll = !this.dictionary.checkAll
        }
        this.dictionary.indeterminate = false

        if (this.dictionary.checkAll) {
          this.dictionary.databases = this.dictionary.databasesList
        } else {
          this.dictionary.databases = []
        }
      },
      // 生成已生成字典的库列表
      getdiclist (val) {
        if (val.length === 0) {
          return
        }
        axios.put(`${util.url}/sqldic/getdiclist`, {
          'name': val
        })
          .then(res => {
            this.dictionary.getdellist = res.data
          })
          .catch(error => {
            util.err_notice(error)
          })
      },
      // 重置
      cleardata () {
        this.dictionary.name = ''
        this.dictionary.databases = []
        this.dictionary.databasesList = []
        this.dictionary.getdellist = []
        this.dictionary.getdel = []
        this.dictionary.delname = ''
      },
      delbaselink () {
        if (this.delbasename === this.delconfirmbasename) {
          axios.delete(`${util.url}/management_db/${this.delbasename}`)
            .then(res => {
              util.notice(res.data)
              this.delbaseModal = false
              this.delconfirmbasename = ''
              this.$refs.totol.currentPage = 1
              this.mountdata()
            })
            .catch(error => {
              util.err_notice(error)
            })
        } else {
          this.$Message.error({
            content: '请确认输入的业务信息一致！'
          })
        }
      },
      mountdata (vl = 1) {
        axios.get(`${util.url}/management_db/all/?page=${vl}&permissions_type=base`)
          .then(res => {
            this.rowdata = res.data.data
            this.pagenumber = parseInt(res.data.page)
            this.diclist = res.data.diclist
            this.dataset = res.data['custom']
          })
          .catch(error => {
            util.err_notice(error)
          })
      },
      dingding (vl) {
        this.dingname = vl.connection_name
        axios.get(`${util.url}/dingding?connection_name=${this.dingname}`)
          .then(res => {
            this.dingdingid = res.data.id
            this.dingdingbeforetext = res.data.before
            this.dingdingaftertext = res.data.after
          })
          .catch(error => {
            util.err_notice(error)
          })
        this.addDingding = true
      },
      savedingding () {
        axios.post(`${util.url}/dingding/`, {
          'before': this.dingdingbeforetext,
          'after': this.dingdingaftertext,
          'id': this.dingdingid
        })
          .then(() => {
            util.notice('钉钉推送消息已设置成功!')
            this.addDingding = false
          })
          .catch(error => {
            util.err_notice(error)
          })
      },
      update_base () {
        axios.put(`${util.url}/management_db/update`, {
          'data': JSON.stringify(this.editbaseinfo)
        })
          .then(res => util.notice(res.data))
          .catch(err => util.err_notice(err))
      }
    },
    mounted () {
      this.mountdata()
    }
  }
</script>
