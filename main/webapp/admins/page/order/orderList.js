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

    //订单列表
    var tableIns = table.render({
        elem: '#orderList',
        url: '../../json/orderList.json',
        cellMinWidth: 95,
        page: true,
        height: "full-125",
        limits: [10, 15, 20, 25],
        limit: 20,
        id: "orderListTable",
        cols: [[
            { type: "checkbox", fixed: "left"},
            { field: 'orderId', title: 'ID',align: "center", sort: true },
            { field: 'customerName', title: '客户名称', align: "center", sort: true },
            { field: 'bussinessType', title: '业务类型', align: 'center', sort: true },
            { field: 'vessel', title: '船名', align: 'center', sort: true },
            { field: 'voyage', title: '航次', align: 'center', sort: true },
            { field: 'BLNo', title: '提单号码', align: 'center', sort: true },
            { field: 'loadPort', title: '起运港', align: 'center', sort: true },
            { field: 'destPort', title: '目的港', align: 'center', sort: true },
            { field: 'jdDate', title: '截单日期', align: 'center', sort: true },
            { field: 'jgDate', title: '截港日期', align: 'center', sort: true },
            { field: 'containerCount', title: '集装箱量', align: 'center', sort: true },
            { field: 'stationName', title: '场站名称', align: 'center', sort: true },
            { field: 'contact', title: '联系人', align: 'center', sort: true },
            { field: 'tel', title: '电话', align: 'center' },
            { title: '操作', minWidth: 135, templet: '#orderListBar', fixed: "right", align: "center" }
        ]]
    });

    //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
    $(".search_btn").on("click", function () {
        if ($(".searchVal").val() != '') {
            table.reload("orderListTable", {
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
    //新建订单
    function add(edit) {
        var index = layui.layer.open({
            title: "新建订单",
            type: 2,
            content: "orderAdd.html",
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回订单列表', '.layui-layer-setwin .layui-layer-close', {
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
    //编辑订单
    function edit(edit) {
        var index = layui.layer.open({
            title: "编辑订单",
            type: 2,
            content: "orderEdit.html",
            success: function (layero, index) {
                var body = layui.layer.getChildFrame('body', index);
                localStorage.setItem("editItem", JSON.stringify(edit));
                console.log(edit.bussinessType);
                body.find("#bussinessType").val(edit.bussinessType);
                body.find("#orderId").val(edit.orderId);  //入货通知编号
                body.find("#vessel").val(edit.vessel);  //船名
                body.find('#voyage').val(edit.voyage);//航次
                body.find('#BLNo').val(edit.BLNo);//提单号码
                body.find('#loadPort').val(edit.loadPort);//起运港
                body.find('#destPort').val(edit.destPort);//目的港
                body.find('#jdDate').val(edit.jdDate);//截单日期
                body.find('#jgDate').val(edit.jgDate);//截港日期
                body.find('#containerCount').val(edit.containerCount);//集装箱量
                body.find('#stationName').val(edit.stationName);//场站名称
                body.find('#contact').val(edit.contact);//联系人
                body.find('#tel').val(edit.tel);//联系电话
                form.render();
                setTimeout(function () {
                    layui.layer.tips('点击此处返回入货通知列表', '.layui-layer-setwin .layui-layer-close', {
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
        add();
    });

    //批量删除
    $(".delAll_btn").click(function () {
        var checkStatus = table.checkStatus('orderListTable'),
            data = checkStatus.data,
            orderId = [];
        if (data.length > 0) {
            for (var i in data) {
                orderId.push(data[i].orderId);
            }
            layer.confirm('确定删除选中的订单吗？', { icon: 3, title: '提示信息' }, function (index) {
                // $.get("删除入货通知接口",{
                //     orderId : orderId  //将需要删除的orderId作为参数传入
                // },function(data){
                tableIns.reload();
                layer.close(index);
                // })
            })
        } else {
            layer.msg("请选择需要删除的订单");
        }
    })

    //列表操作
    table.on('tool(orderList)', function (obj) {
        var layEvent = obj.event,
            data = obj.data;
        if (layEvent === 'edit') { //编辑
            edit(data);
        } else if (layEvent === 'del') { //删除
            layer.confirm('确定删除此订单？', { icon: 3, title: '提示信息' }, function (index) {
                // $.get("删除订单接口",{
                //     orderId : data.orderId  //将需要删除的orderId作为参数传入
                // },function(data){
                tableIns.reload();
                layer.close(index);
                // })
            });
        }
    });

})