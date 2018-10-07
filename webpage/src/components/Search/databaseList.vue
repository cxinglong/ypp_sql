<style lang="less">
  @import '../../styles/common.less';
  @import '../order/components/table.less';
</style>
<template>
  <div class="edittable-con-1">
    <Col span="24">
      <Card>
        <div>
          <Table :columns="columns" :data="rowdata" height="550"></Table>
        </div>
        <br>
        <Page :total="pagenumber" show-elevator @on-change="mountdata" :page-size="10" ref="totol"></Page>
      </Card>
    </Col>
    <Col span="24">
      <Card>
        <Tabs value="name1">
          <TabPane label="库字典查询" icon="load-b" name="name1">
            <div class="edittable-testauto-con">
              <Form :model="dictionary" :label-width="320" ref="generation">
                <FormItem label="业务信息:" prop="dic">
                  <Select v-model="dictionary.name" placeholder="请选择业务信息" style="width: 25%" @on-change="BaseList"
                          transfer>
                    <Option v-for="i in rowdata" :value="i.id" :key="i.connection_name">{{i.connection_name}}</Option>
                  </Select>
                </FormItem>
                <FormItem label="存在的数据库:">
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
            title: '环境',
            key: 'computer_room'
          },
          {
            title: '数据库地址',
            key: 'ip'
          },
          {
            title: '端口',
            key: 'port'
          }
        ],
        rowdata: [],
        modal: false,
        // 添加数据库信息
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
        }
      }
    },
    methods: {
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
      }
    },
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
      }
  }
</script>
