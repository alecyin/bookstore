<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/admins/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/admins/css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text" class="layui-input searchVal" placeholder="请输入搜索的内容"/>
                </div>
                <a class="layui-btn search_btn" data-type="reload">搜索</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal add_btn">添加管理员</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
            </div>
        </form>
    </blockquote>
    <table id="adminList" lay-filter="adminList"></table>
    <!--操作-->
    <script type="text/html" id="adminListBar">
        <a class="layui-btn layui-btn-xs" lay-event="resetPass">重置密码</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </script>
</form>
<script type="text/javascript" src="/admins/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer', 'table', 'laytpl', 'upload'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            laytpl = layui.laytpl,
            upload = layui.upload,
            table = layui.table;

        //管理员列表
        var tableIns = table.render({
            elem: '#adminList',
            url: '/admins/table-data',
            cellMinWidth: 95,
            page: true,
            height: "full-125",
            limit: 20,
            limits: [10, 15, 20, 25],
            id: "adminListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 50},
                {field: 'id', title: 'ID', width: 60, align: "center"},
                {field: 'name', title: '管理员名称'},
                {title: '操作', width: 300, templet: '#adminListBar', fixed: "right", align: "center"}
            ]]
        });

        //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn").on("click", function () {
            if ($(".searchVal").val() != '') {
                table.reload("adminListTable", {
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

        //添加管理员
        function addAdmin(edit) {
            var index = layui.layer.open({
                title: "添加管理员",
                type: 2,
                content: "/admins/adminAdd",
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回管理员列表', '.layui-layer-setwin .layui-layer-close', {
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

        //编辑管理员信息
        function editAdmin(edit) {
            var index = layui.layer.open({
                title: "编辑管理员信息",
                type: 2,
                content: "/admins/adminEdit",
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    body.find("#name").val(edit.name);
                    body.find("#id").val(edit.id);
                    form.render();
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回管理员列表', '.layui-layer-setwin .layui-layer-close', {
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

        $(".add_btn").click(function () {
            addAdmin();
        });

        //批量删除
        $(".delAll_btn").click(function () {
            var checkStatus = table.checkStatus('adminListTable'),
                data = checkStatus.data,
                ids = "";
            if (data.length > 0) {
                for (var i in data) {
                    ids += "-" + data[i].id;
                }
                layer.confirm('确定删除选中的管理员？', {icon: 3, title: '提示信息'}, function (index) {
                    $.get("/admins/del", {
                        ids: ids  //将需要删除的adminId作为参数传入
                    }, function (data) {
                        tableIns.reload();
                        layer.close(index);
                    })
                })
            } else {
                layer.msg("请选择需要删除的管理员");
            }
        });

        //列表操作
        table.on('tool(adminList)', function (obj) {
            var layEvent = obj.event,
                data = obj.data;

            if (layEvent === 'edit') { //编辑
                editAdmin(data);
            } else if (layEvent === 'del') { //删除
                layer.confirm('确定删除此管理员？', {icon: 3, title: '提示信息'}, function (index) {
                    $.get("/admins/del", {
                        ids: data.id  //将需要删除的adminId作为参数传入
                    }, function (data) {
                        tableIns.reload();
                        layer.close(index);
                    })
                });
            } else if (layEvent === 'resetPass') {
                layer.confirm('确定重置此管理员密码？', {icon: 3, title: '提示信息'}, function (index) {
                    $.get("/admins/resetPass", {
                        id: data.id
                    }, function (data) {
                        tableIns.reload();
                        layer.close(index);
                    })
                });
            }
        });

    })
</script>
</body>
</html>