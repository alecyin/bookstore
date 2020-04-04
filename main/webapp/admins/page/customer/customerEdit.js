layui.use(['form', 'layer'], function () {
  var form = layui.form
  layer = parent.layer === undefined ? layui.layer : top.layer,
    laypage = layui.laypage,
    $ = layui.jquery;
  form.verify({
    customerName: function (val) {
      if (val == '') {
        return "客户名称不能为空";
      }
    },
    customerEmail: function (val) {
      if (val == '') {
        return "客户邮箱不能为空";
      }
    },
    customerTel : function(val){
      if(val == ''){
          return "联系电话不能为空";
      }
  }
  });
  //监听指定开关
  form.on('switch(customerStatus)', function(data){
    var self = this;
    setTimeout(function(){
      if(self.checked){
        layer.msg("激活成功");
      }else{
        layer.msg("取消激活成功");
      }
    },500);
  });
  
  form.on("submit(editCustomer)", function (data) {
    //弹出loading
    var index = top.layer.msg('数据提交中，请稍候', { icon: 16, time: false, shade: 0.8 });
    // 实际使用时的提交信息
    // $.post("上传路径",{
    //     customerId : $("#customerId").val(),  //客户Id
    //     customerName : $("#customerName").val(),  //客户名称
    //     customerEmail : $("#customerEmail").val(),//客户邮箱
    //     customerTel : $("#customerTel").val(),  //联系电话
    //     customerStatus : $("#customerStatus").val(),    //激活状态
    // },function(res){
    //
    // })
    setTimeout(function () {
      top.layer.close(index);
      top.layer.msg("客户添加成功！");
      layer.closeAll("iframe");
      //刷新父页面
      parent.location.reload();
    }, 500);
    return false;
  });
});