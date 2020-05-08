<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>书籍列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/admins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/admins/css/public.css" media="all" />
</head>

<body class="childrenBody">
    <form class="layui-form">
        <blockquote class="layui-elem-quote quoteBox">
            <form class="layui-form">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input searchVal" placeholder="请输入搜索的内容" />
                    </div>
                    <a class="layui-btn search_btn" data-type="reload">搜索</a>
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="y">
                    </div>
                    <a class="layui-btn year_btn" data-type="reload">按年查询</a>
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="ym">
                    </div>
                    <a class="layui-btn month_btn" data-type="reload">按月查询</a>
                </div>
                <div class="layui-inline">
                    <a class="layui-btn layui-btn-normal restore_btn">查看初始数据</a>
                </div>
            </form>
        </blockquote>
        <table id="bookList" lay-filter="bookList"></table>
        <!--操作-->
        <script type="text/html" id="bookListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
    </form>
    <script type="text/javascript" src="/admins/layui/layui.js"></script>
    <script>
        layui.use(['form', 'layer', 'table', 'laytpl', 'upload', 'laydate'], function () {
            var form = layui.form,
                layer = parent.layer === undefined ? layui.layer : top.layer,
                $ = layui.jquery,
                laytpl = layui.laytpl,
                upload = layui.upload,
                laydate = layui.laydate,
                table = layui.table;
            laydate.render({
                elem: '#y'
                , type: 'year'
            });

            laydate.render({
                elem: '#ym'
                , type: 'month'
            });
            var colsData = [[{ type: 'checkbox', fixed: 'left', width: 50 },
            { field: 'id', title: 'ID', width: 60, align: 'center' },
            { field: 'name', title: '书籍名称' },
            { field: 'categoryName', title: '类别' },
            { field: 'price', title: '单价/元' },
            { field: 'weekAmount', title: '周销售/本' },
            { field: 'weekPrice', title: '周销量额/元' },
            { field: 'monthAmount', title: '月销售/本' },
            { field: 'monthPrice', title: '月销量额/元' },
            { field: 'yearAmount', title: '年销售/本' },
            { field: 'yearPrice', title: '年销量额/元' }
            ]];

            //书籍列表
            var tableIns = table.render({
                elem: '#bookList',
                url: '/books/sales-count',
                cellMinWidth: 95,
                page: true,
                height: "full-125",
                limit: 20,
                limits: [10, 15, 20, 25],
                id: "bookListTable",
                cols: colsData
            });


            // 数据表单时间戳转换为日期显示
            function DateFormat(sjc) {
                var date = new Date(sjc);
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? '0' + m : m;
                var d = date.getDate();
                d = d < 10 ? ("0" + d) : d;
                var h = date.getHours();
                h = h < 10 ? ("0" + h) : h;
                var min = date.getMinutes();
                min = min < 10 ? ("0" + min) : min;
                var s = date.getSeconds();
                s = s < 10 ? ("0" + s) : s;
                var str = y + "-" + m + "-" + d;
                return str;
            }

            $(".search_btn").on("click", function () {
                if ($(".searchVal").val() != '') {
                    table.reload("bookListTable", {
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

            $(".restore_btn").on("click", function () {
                colsData = [[{ type: 'checkbox', fixed: 'left', width: 50 },
                { field: 'id', title: 'ID', width: 60, align: 'center' },
                { field: 'name', title: '书籍名称' },
                { field: 'categoryName', title: '类别' },
                { field: 'price', title: '单价/元' },
                { field: 'weekAmount', title: '周销售/本' },
                { field: 'weekPrice', title: '周销量额/元' },
                { field: 'monthAmount', title: '月销售/本' },
                { field: 'monthPrice', title: '月销量额/元' },
                { field: 'yearAmount', title: '年销售/本' },
                { field: 'yearPrice', title: '年销量额/元' }
                ]];
                tableIns = table.render({
                    elem: '#bookList',
                    url: '/books/sales-count',
                    cellMinWidth: 95,
                    page: true,
                    height: "full-125",
                    limit: 20,
                    limits: [10, 15, 20, 25],
                    id: "bookListTable",
                    cols: colsData
                });
            });

            $(".year_btn").on("click", function () {
                colsData = [[{ type: 'checkbox', fixed: 'left', width: 50 },
                { field: 'id', title: 'ID', width: 60, align: 'center' },
                { field: 'name', title: '书籍名称' },
                { field: 'categoryName', title: '类别' },
                { field: 'price', title: '单价/元' },
                { field: 'yearAmount', title: '年销售/本' },
                { field: 'yearPrice', title: '年销量额/元' }
                ]];
                table.render({
                    elem: '#bookList',
                    url: '/books/sales-count?year=' + $("#y").val(),
                    cellMinWidth: 95,
                    page: true,
                    height: "full-125",
                    limit: 10,
                    limits: [10, 15, 20, 25],
                    id: "bookListTable",
                    cols: colsData
                });
            });

            $(".month_btn").on("click", function () {
                colsData = [[{ type: 'checkbox', fixed: 'left', width: 50 },
                { field: 'id', title: 'ID', width: 60, align: 'center' },
                { field: 'name', title: '书籍名称' },
                { field: 'categoryName', title: '类别' },
                { field: 'price', title: '单价/元' },
                { field: 'monthAmount', title: '月销售/本' },
                { field: 'monthPrice', title: '月销量额/元' }
                ]];
                table.render({
                    elem: '#bookList',
                    url: '/books/sales-count?month=' + $("#ym").val(),
                    cellMinWidth: 95,
                    page: true,
                    height: "full-125",
                    limit: 10,
                    limits: [10, 15, 20, 25],
                    id: "bookListTable",
                    cols: colsData
                });
            });

        })
    </script>
</body>

</html>