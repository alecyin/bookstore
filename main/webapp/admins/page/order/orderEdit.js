layui.config({
  base: '/wuliu/js/'
}).extend({
  "common": "common"
});
layui.use(['form', 'layer', 'common'], function () {
  var form = layui.form
  layer = layui.layer,
    laypage = layui.laypage,
    $ = layui.jquery,
    common = layui.common;
  $(function () {
    var config = {
      selectors: [
        {
          url: '../../json/customerList.json',
          target: '#customerName',
          value: 'customerId',
          text: 'customerName',
          key: 'customerName'
        },
        {
          url: '../../json/portList.json',
          target: '#loadPort',
          value: 'portId',
          text: 'portName',
          key: 'loadPort'
        },
        {
          url: '../../json/portList.json',
          target: '#destPort',
          value: 'portId',
          text: 'portName',
          key: 'destPort'
        }
      ],
      editItem: localStorage.getItem('editItem')
    };
    common.initSelector(config);
  });
  form.on("submit(editOrder)", function (data) {
    //弹出loading
    var index = layer.msg('数据提交中，请稍候', { icon: 16, time: false, shade: 0.8 });
    // 实际使用时的提交信息
    // $.post("上传路径",{
    //  这里是要上传的数据 
    // },function(res){
    //
    // })
    setTimeout(function () {
      layer.close(index);
      layer.msg("订单修改成功！");
      layer.closeAll("iframe");
      //刷新父页面
      parent.location.reload();
    }, 500);
    return false;
  });
});