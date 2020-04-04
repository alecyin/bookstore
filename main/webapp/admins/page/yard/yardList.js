layui.config({
  base: '/wuliu/js/'
}).extend({
  "common": "common"
});
layui.use(['form', 'layer', 'table', 'laytpl', 'common'], function () {
  var form = layui.form,
    layer = layui.layer,
    $ = layui.jquery,
    laytpl = layui.laytpl,
    table = layui.table,
    common = layui.common;

  //场站列表
  var tableIns = table.render({
    elem: '#yardList',
    url: '../../json/yardList.json',
    cellMinWidth: 95,
    page: true,
    height: "full-125",
    limits: [10, 15, 20, 25],
    limit: 20,
    id: "yardListTable",
    cols: [[
      { type: "checkbox", fixed: "left", width: 50 },
      { field: 'yardId', title: 'ID', minWidth: 100, align: "center", sort: true },
      { field: 'yardName', title: '场站名称', minWidth: 100, align: "center", sort: true },
      { field: 'codeName', title: '代号', minWidth: 100, align: "center", sort: true },
      {
        field: 'yardStatus', title: '是否激活', align: 'center', width: 100, templet: function (d) {
            return '<input type="checkbox" name="yardStatus" lay-filter="yardStatus" lay-skin="switch" lay-text="是|否" ' + d.yardStatus + '>'
        }
    },
      { title: '操作', minWidth: 135, templet: '#yardListBar', fixed: "right", align: "center" }
    ]]
  });

  //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
  $(".search_btn").on("click", function () {
    if ($(".searchVal").val() != '') {
      table.reload("yardListTable", {
        page: {
          curr: 1 //重新从第 1 页开始
        },
        where: {
          key: $(".searchVal").val()  //搜索的关键字
        }
      })
    } else {
      layer.msg("请输入搜索的内容");
    }
  });
  //新建场站
  function addYard(edit) {
    var index = layui.layer.open({
      title: "添加场站",
      type: 2,
      content: "yardAdd.html",
      success: function (layero, index) {
        setTimeout(function () {
          layui.layer.tips('点击此处返回场站列表', '.layui-layer-setwin .layui-layer-close', {
            tips: 3
          });
        }, 500)
      }
    });
    layui.layer.full(index);
    //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
    $(window).on("resize", function () {
      layui.layer.full(index);
    })
  }
  //编辑场站信息
  function editYard(edit) {
    var index = layui.layer.open({
      title: "编辑场站信息",
      type: 2,
      content: "yardEdit.html",
      success: function (layero, index) {
        var body = layui.layer.getChildFrame('body', index);
        body.find("#yardId").val(edit.yardId);  //场站ID
        body.find("#yardName").val(edit.yardName);  //场站名称
        body.find('#codeName').val(edit.codeName);//代号
        body.find("#yardStatus input[name='yardStatus']").prop("checked", edit.yardStatus);//激活状态
        form.render();
        setTimeout(function () {
          layui.layer.tips('点击此处返回场站列表', '.layui-layer-setwin .layui-layer-close', {
            tips: 3
          });
        }, 500)
      }
    });
    layui.layer.full(index);
    //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
    $(window).on("resize", function () {
      layui.layer.full(index);
    })
  }
  $(".add_btn").click(function (event) {
    addYard();
  });

  //批量删除
  $(".delAll_btn").click(function () {
    var checkStatus = table.checkStatus('yardListTable'),
      data = checkStatus.data,
      yardId = [];
    if (data.length > 0) {
      for (var i in data) {
        yardId.push(data[i].noticeId);
      }
      layer.confirm('确定删除选中的入货通知吗？', { icon: 3, title: '提示信息' }, function (index) {
        // $.get("删除入货通知接口",{
        //     yardId : yardId  //将需要删除的yardId作为参数传入
        // },function(data){
        tableIns.reload();
        layer.close(index);
        // })
      })
    } else {
      layer.msg("请选择需要删除的入货通知");
    }
  })

  //列表操作
  table.on('tool(yardList)', function (obj) {
    var layEvent = obj.event,
      data = obj.data;
    if (layEvent === 'edit') { //编辑
      editYard();
    } else if (layEvent === 'del') { //删除
      layer.confirm('确定删除此场站？', { icon: 3, title: '提示信息' }, function (index) {
        // $.get("删除入货通知接口",{
        //     yardId : data.yardId  //将需要删除的yardId作为参数传入
        // },function(data){
        tableIns.reload();
        layer.close(index);
        // })
      });
    }
  });

})