webpackJsonp([14],{192:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var o=n(4),s=n.n(o),r=n(2);t.default={name:"work_flow",props:["msg"],data:function(){return{stepData:{title:"比心数据库自动化平台",describe:"欢迎你！ "+sessionStorage.getItem("user")},step:{remark:"",computer_room:"",connection_name:"",person:"",export:"0"},stepList1:[{title:"提交",describe:"提交查询申请"},{title:"审核",describe:"等待审核结果"},{title:"查询",describe:"审核完毕，进入查询页面"}],stepRules:{opinion:[{required:!0,message:"请填写查询说明",trigger:"blur"}],computer_room:[{required:!0,message:"环境地址不得为空",trigger:"change"}],connection_name:[{required:!0,message:"业务信息不得为空",trigger:"change"}],basename:[{required:!0,message:"数据库名不得为空",trigger:"change"}],person:[{required:!0,message:"审核人不得为空",trigger:"change"}]},item:{},personlist:[],datalist:{connection_name_list:[],basenamelist:[],sqllist:[],computer_roomlist:r.a.computer_room}}},methods:{Connection_Name:function(e){this.datalist.connection_name_list=[],this.datalist.basenamelist=[],this.step.connection_name="",this.step.basename="",e&&this.ScreenConnection(e)},ScreenConnection:function(e){this.datalist.connection_name_list=this.item.filter(function(t){if(t.computer_room===e)return t})},handleSubmit:function(){var e=this;this.$refs.step.validate(function(t){t&&s.a.put(r.a.url+"/query_worklf",{mode:"put",instructions:e.step.opinion,connection_name:e.step.connection_name,computer_room:e.step.computer_room,export:e.step.export,audit:e.step.person}).then(function(){e.$router.push({name:"queryready"})})})}},mounted:function(){var e=this;s.a.put(r.a.url+"/workorder/connection",{permissions_type:"query"}).then(function(t){e.item=t.data.connection,e.personlist=t.data.assigend,e.datalist.computer_roomlist=t.data.custom}).catch(function(e){r.a.err_notice(e)}),s.a.put(r.a.url+"/query_worklf",{mode:"status"}).then(function(t){1===t.data?e.$router.push({name:"querypage"}):2===t.data&&e.$router.push({name:"queryready"})})}}},193:function(e,t,n){t=e.exports=n(75)(!0),t.push([e.i,".step-header-con{text-align:center}.step-header-con h3{margin:10px 0}.step-header-con h5{margin:0 0 5px}.step-content{padding:5px 20px 26px}.step-content,.step-form{margin-bottom:20px;border-bottom:1px solid #dbdddf}.step-form{padding-bottom:10px}","",{version:3,sources:["/Users/vincent/Desktop/ypp_sql/webpage/src/components/search/workFlow.vue"],names:[],mappings:"AACA,iBACE,iBAAmB,CACpB,AACD,oBACE,aAAe,CAChB,AACD,oBACE,cAAgB,CACjB,AACD,cACE,qBAAuB,CAGxB,AACD,yBAHE,mBAAoB,AACpB,+BAAiC,CAMlC,AAJD,WACE,mBAAqB,CAGtB",file:"workFlow.vue",sourcesContent:["\n.step-header-con {\n  text-align: center;\n}\n.step-header-con h3 {\n  margin: 10px 0;\n}\n.step-header-con h5 {\n  margin: 0 0 5px;\n}\n.step-content {\n  padding: 5px 20px 26px;\n  margin-bottom: 20px;\n  border-bottom: 1px solid #dbdddf;\n}\n.step-form {\n  padding-bottom: 10px;\n  border-bottom: 1px solid #dbdddf;\n  margin-bottom: 20px;\n}\n"],sourceRoot:""}])},212:function(e,t,n){var o=n(193);"string"==typeof o&&(o=[[e.i,o,""]]),o.locals&&(e.exports=o.locals);n(76)("21fe86f0",o,!0,{})},214:function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",[n("Row",[n("Card",[n("div",{staticClass:"step-header-con"},[n("h3",[e._v(e._s(e.stepData.title))]),e._v(" "),n("h5",[e._v(e._s(e.stepData.describe))])]),e._v(" "),n("p",{staticClass:"step-content"}),e._v(" "),n("Row",[n("i-col",{attrs:{span:"8"}},[n("Alert",{attrs:{type:"warning","show-icon":""}},[e._v("\n            注意事项:\n            "),n("span",{attrs:{slot:"desc"},slot:"desc"},[e._v("\n            1.必须填写查询说明\n            "),n("br"),e._v("\n            2.根据查询条件预估所需的查询时间\n            "),n("br"),e._v("\n            3.所有提交的查询语句均会进行审计记录\n            "),n("br"),e._v("\n            4.仅支持select语句,不可使用非查询语句\n            "),n("br"),e._v("\n            5.已限制最大limit数，如自己输入的limit数大于平台配置的最大limit数则已平台配置的Limit数为准\n          ")])])],1),e._v(" "),n("i-col",{attrs:{span:"12"}},[n("Form",{ref:"step",attrs:{model:e.step,rules:e.stepRules,"label-width":150}},[n("FormItem",{attrs:{label:"环境:",prop:"computer_room"}},[n("Select",{on:{"on-change":e.Connection_Name},model:{value:e.step.computer_room,callback:function(t){e.$set(e.step,"computer_room",t)},expression:"step.computer_room"}},e._l(e.datalist.computer_roomlist,function(t){return n("Option",{key:t,attrs:{value:t}},[e._v(e._s(t))])}))],1),e._v(" "),n("FormItem",{attrs:{label:"业务信息:",prop:"connection_name"}},[n("Select",{attrs:{filterable:""},model:{value:e.step.connection_name,callback:function(t){e.$set(e.step,"connection_name",t)},expression:"step.connection_name"}},e._l(e.datalist.connection_name_list,function(t){return n("Option",{key:t.connection_name,attrs:{value:t.connection_name}},[e._v(e._s(t.connection_name)+"\n                ")])}))],1),e._v(" "),n("FormItem",{attrs:{label:"审核人:",prop:"person"}},[n("Select",{attrs:{filterable:""},model:{value:e.step.person,callback:function(t){e.$set(e.step,"person",t)},expression:"step.person"}},e._l(e.personlist,function(t){return n("Option",{key:t,attrs:{value:t}},[e._v(e._s(t))])}))],1),e._v(" "),n("FormItem",{attrs:{label:"是否需要导出数据:",prop:"export"}},[n("RadioGroup",{model:{value:e.step.export,callback:function(t){e.$set(e.step,"export",t)},expression:"step.export"}},[n("Radio",{attrs:{label:"1"}},[e._v("是")]),e._v(" "),n("Radio",{attrs:{label:"0"}},[e._v("否")])],1)],1),e._v(" "),n("FormItem",{attrs:{label:"查询说明：",prop:"opinion"}},[n("Input",{attrs:{type:"textarea",autosize:{minRows:4,maxRows:8},placeholder:"请填写查询说明"},model:{value:e.step.opinion,callback:function(t){e.$set(e.step,"opinion",t)},expression:"step.opinion"}})],1),e._v(" "),n("FormItem",{attrs:{label:""}},[n("Button",{staticStyle:{width:"100px"},attrs:{type:"primary"},on:{click:e.handleSubmit}},[e._v("提交")])],1)],1)],1)],1),e._v(" "),n("Steps",{staticStyle:{"margin-left":"10%"}},e._l(e.stepList1,function(e){return n("Step",{key:e.title,attrs:{title:e.title,content:e.describe}})}))],1)],1)],1)},staticRenderFns:[]}},77:function(e,t,n){function o(e){n(212)}var s=n(1)(n(192),n(214),o,null,null);e.exports=s.exports}});
//# sourceMappingURL=14.ef19fe24e5d813265499.js.map