layui.config({
  base: '/wuliu/js/'
}).extend({
  "common":"common"
});
layui.use(['form', 'layer','common','laydate'], function () {
  var form = layui.form
  layer = layui.layer,
    laypage = layui.laypage,
    $ = layui.jquery,
    common = layui.common,
    laydate = layui.laydate;
    laydate.render(
      {
        elem:"#jdDate"
      }
    );
    laydate.render(
      {
        elem:"#jgDate"
      }
    );
    $(function(){
      var config = {
        selectors:[
          {
            url: '../../json/customerList.json',
            target: '#customerName',
            value: 'customerId',
            text: 'customerName',
            key:'customerName'
          },
          {
            url: '../../json/portList.json',
            target: '#loadPort',
            value: 'portId',
            text: 'portName',
            key:'loadPort'
          },
          {
            url: '../../json/portList.json',
            target: '#destPort',
            value: 'portId',
            text: 'portName',
            key:'destport'
          }
        ]
      };
      common.initSelector(config);
    });
  form.on("submit(addOrder)", function (data) {
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
      top.layer.msg("订单创建成功！");
      layer.closeAll("iframe");
      //刷新父页面
      parent.location.reload();
    }, 500);
    return false;
  });
});