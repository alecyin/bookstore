layui.use(['form', 'layer'], function () {
  var form = layui.form
  layer = parent.layer === undefined ? layui.layer : top.layer,
    laypage = layui.laypage,
    $ = layui.jquery;
  //监听指定开关
  form.on('switch(portStatus)', function (data) {
    var self = this;
    setTimeout(function () {
      if (self.checked) {
        layer.msg("激活成功");
      } else {
        layer.msg("取消激活成功");
      }
    }, 500);
  });

  form.on("submit(addPort)", function (data) {
    //弹出loading
    var index = top.layer.msg('数据提交中，请稍候', { icon: 16, time: false, shade: 0.8 });
    // 实际使用时的提交信息
    // $.post("上传路径",{
    //    portId : $("#portId").val(),  //港口Id
    //    portName : $("#portName").val(),  //港口
    //    country : $("#country").val(),//所属国家
    //    description : $("#description").val(),  //描述
    //    portStatus : $("#portStatus").val(),    //激活状态
    // },function(res){
    //
    // })
    setTimeout(function () {
      top.layer.close(index);
      top.layer.msg("港口信息添加成功！");
      layer.closeAll("iframe");
      //刷新父页面
      parent.location.reload();
    }, 500);
    return false;
  });
});