layui.use(['form', 'layer', 'table', 'laytpl'], function () {
  var form = layui.form,
      layer = parent.layer === undefined ? layui.layer : top.layer,
      $ = layui.jquery,
      laytpl = layui.laytpl,
      table = layui.table;

  //港口列表
  var tableIns = table.render({
      elem: '#portList',
      url: '../../json/portList.json',
      cellMinWidth: 95,
      page: true,
      height: "full-125",
      limit: 20,
      limits: [10, 15, 20, 25],
      id: "portListTable",
      cols: [[
          { type: "checkbox", fixed: "left", width: 50 },
          { field: 'portId', title: 'ID', width: 60, align: "center" },
          { field: 'portName', title: '港口名称' },
          { field: 'country', title: '所属国家' },
          { field: 'description', title: '描述' },
          {
              field: 'portStatus', title: '是否激活', align: 'center', width: 100, templet: function (d) {
                  return '<input type="checkbox" name="portStatus" lay-filter="portStatus" lay-skin="switch" lay-text="是|否" ' + d.portStatus + '>'
              }
          },
          { title: '操作', width: 170, templet: '#portListBar', fixed: "right", align: "center" }
      ]]
  });

  //是否激活
  form.on('switch(portStatus)', function (data) {
      var index = layer.msg('修改中，请稍候', { icon: 16, time: false, shade: 0.8 });
      setTimeout(function () {
          layer.close(index);
          if (data.elem.checked) {
              layer.msg("激活成功！");
          } else {
              layer.msg("取消激活成功！");
          }
      }, 500);
  })

  //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
  $(".search_btn").on("click", function () {
      if ($(".searchVal").val() != '') {
          table.reload("portListTable", {
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
  //添加港口
  function addPort(edit) {
      var index = layui.layer.open({
          title: "添加港口",
          type: 2,
          content: "portAdd.html",
          success: function (layero, index) {
              setTimeout(function () {
                  layui.layer.tips('点击此处返回港口列表', '.layui-layer-setwin .layui-layer-close', {
                      tips: 3
                  });
              }, 500)
          }
      })
      layui.layer.full(index);
      //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
      $(window).on("resize", function () {
          layui.layer.full(index);
      })
  }
  //编辑港口信息
  function editPort(edit) {
      var index = layui.layer.open({
          title: "编辑港口信息",
          type: 2,
          content: "portEdit.html",
          success: function (layero, index) {
              var body = layui.layer.getChildFrame('body', index);
              if (edit) {
                  body.find("#portId").val(edit.portId);
                  body.find("#portName").val(edit.portName);
                  body.find("#country").val(edit.country);
                  body.find("#description").val(edit.description);
                  body.find("#portStatus input[name='portStatus']").prop("checked", edit.portStatus);
                  form.render();
              }
              setTimeout(function () {
                  layui.layer.tips('点击此处返回港口列表', '.layui-layer-setwin .layui-layer-close', {
                      tips: 3
                  });
              }, 500)
          }
      })
      layui.layer.full(index);
      //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
      $(window).on("resize", function () {
          layui.layer.full(index);
      })
  }
  $(".add_btn").click(function () {
      addPort();
  })

  //批量删除
  $(".delAll_btn").click(function () {
      var checkStatus = table.checkStatus('portListTable'),
          data = checkStatus.data,
          portId = [];
      if (data.length > 0) {
          for (var i in data) {
              portId.push(data[i].portId);
          }
          layer.confirm('确定删除选中的港口？', { icon: 3, title: '提示信息' }, function (index) {
              // $.get("删除港口接口",{
              //     portId : portId  //将需要删除的portId作为参数传入
              // },function(data){
              tableIns.reload();
              layer.close(index);
              // })
          })
      } else {
          layer.msg("请选择需要删除的港口");
      }
  })

  //列表操作
  table.on('tool(portList)', function (obj) {
      var layEvent = obj.event,
          data = obj.data;

      if (layEvent === 'edit') { //编辑
          editPort(data);
      } else if (layEvent === 'del') { //删除
          layer.confirm('确定删除此港口？', { icon: 3, title: '提示信息' }, function (index) {
              // $.get("删除港口接口",{
              //     portId : data.portId  //将需要删除的portId作为参数传入
              // },function(data){
              tableIns.reload();
              layer.close(index);
              // })
          });
      }
  });

})