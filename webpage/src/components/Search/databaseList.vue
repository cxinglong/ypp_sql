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
                  <Select v-model="dictionary.name" placeholder="请选择业务信息" style="width: 20%" @on-change="BaseList"
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
    }
  }
</script>
