<style lang="less">
  @import '../../styles/common.less';
  @import '../order/components/table.less';
</style>
<template>
  <div>
    <Row>
      <Card>
        <p slot="title">
          <Icon type="md-send"></Icon>
          审核记录
        </p>
        <Row>
          <Col span="24">
            <Table border :columns="tabcolumns" :data="TableDataNew" class="tabletop"
                   style="background: #5cadff"></Table>
            <br>
            <Page :total="this.pagenumber" show-elevator @on-change="splicpage" :page-size="10" ref="page"></Page>
          </Col>
        </Row>
      </Card>
    </Row>
  </div>
</template>
<script>
  import axios from 'axios'
  import util from '../../libs/util'
  //
  export default {
    name: 'Record',
    data () {
      return {
        tabcolumns: [
          {
            title: '工单',
            key: 'work_id'
          },
          {
            title: '工单说明',
            key: 'text'
          },
          {
            title: '申请时间',
            key: 'date',
            sortType: 'desc'
          },
          {
            title: '申请人',
            key: 'username',
            width: 120
          },
          {
            title: 'DBA',
            key: 'executor',
            width: 120
          },
          {
            title: '执行时间',
            key: 'exe_date'
          },
          {
            title: '执行区域',
            key: 'computer_room'
          },
          {
            title: '业务信息',
            key: 'connection_name'
          },
          {
            title: '库名',
            key: 'basename'
          },
          {
            title: '状态',
            key: 'status',
            render: (h, params) => {
              const row = params.row
              let color = ''
              let text = ''
              if (row.status === 2) {
                color = 'primary'
                text = '待Leader审核'
              } else if (row.status === 0) {
                color = 'error'
                text = '驳回'
              } else if (row.status === 1) {
                color = 'success'
                text = '已执行'
              } else if (row.status === 4) {
                color = 'error'
                text = '执行或备份失败'
              } else if (row.status === 5) {
                color = 'warning'
                text = '执行成功有警告'
              } else if (row.status === 6) {
                color = 'primary'
                text = '待DBA执行'
              } else {
                color = 'warning'
                text = '执行中'
              }

              return h('Tag', {
                props: {
                  type: 'dot',
                  color: color
                }
              }, text)
            },
            sortable: true,
            filters: [{
              label: '已执行',
              value: 1
            },
              {
                label: '驳回',
                value: 0
              },
              {
                label: '待Leader审核',
                value: 2
              },
              {
                label: '执行中',
                value: 3
              },
              {
                label: '执行失败',
                value: 4
              },
              {
                label: '待DBA执行',
                value: 6
              }
            ],
            //            filterMultiple: false 禁止多选,
            filterMethod (value, row) {
              if (value === 1) {
                return row.status === 1
              } else if (value === 2) {
                return row.status === 2
              } else if (value === 0) {
                return row.status === 0
              } else if (value === 3) {
                return row.status === 3
              } else if (value === 6) {
                return row.status === 6
              } else if (value === 5) {
                return row.status === 5
              } else {
                return row.status === 4
              }
            }
          },
          {
            title: '操作',
            key: 'action',
            align: 'center',
            render: (h, params) => {
              return h('div', [
                h('Button', {
                  props: {
                    size: 'small',
                    type: 'text'
                  },
                  on: {
                    click: () => {
                      this.$router.push({
                        name: 'orderlist',
                        query: {workid: params.row.work_id, id: params.row.id, status: params.row.status, type: params.row.type}
                      })
                    }
                  }
                }, '详细信息')
              ])
            }
          }
        ],
        TableDataNew: [],
        pagenumber: 1
      }
    },
    methods: {
      getrecordinfo (vl = 1) {
        axios.get(`${util.url}/record/all?page=${vl}&username=${sessionStorage.getItem('user')}`)
          .then(res => {
            this.TableDataNew = res.data.data
            this.pagenumber = res.data.page
          })
          .catch(error => {
            util.err_notice(error)
          })
      },
      splicpage (page) {
        this.getrecordinfo(page)
      }
    },
    mounted () {
      this.getrecordinfo()
    }
  }
</script>
