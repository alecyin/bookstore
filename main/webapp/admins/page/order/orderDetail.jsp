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
        <table id="bookList" lay-filter="bookList"></table>
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

            //书籍列表
            var tableIns = table.render({
                elem: '#bookList',
                url: '/orders/getDetail/' + '${id}',
                cellMinWidth: 95,
                page: false,
                height: "full-125",
                id: "bookListTable",
                cols: [[
                    { field: 'name', title: '书籍名称' },
                    { field: 'author', title: '作者' },
                    { field: 'categoryName', title: '类别' },
                    { field: 'isbn', title: '出版社' },
                    {
                        field: 'pubdate', title: '出版日期', templet: function (d) {
                            return DateFormat(d.pubdate);
                        }
                    },
                    {
                        field: 'thumbnail',
                        title: '展示缩略图',
                        width: 100,
                        align: 'center',
                        templet: function (d) {
                            var url = "/admins/images/" + d.thumbnail + ".jpg";
                            return '<a href="' + url + '" target="_blank " title="点击查看">' +
                                '<img src="' + url + '" style="height:20px;" />' +
                                '</a>';
                        }
                    },
                    { field: 'price', title: '单价/元' },
                    { field: 'amount', title: '数量' },

                    { field: 'smallCnt', title: '小计/元' }
                ]]
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

        })
    </script>
</body>

</html>