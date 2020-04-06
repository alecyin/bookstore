<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>留言列表</title>
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
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="msgList" lay-filter="msgList"></table>
	<!--操作-->
	<script type="text/html" id="msgListBar">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="/admins/layui/layui.js"></script>
<script>
	layui.use(['form', 'layer', 'table', 'laytpl','upload'], function () {
		var form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laytpl = layui.laytpl,
				upload = layui.upload,
				table = layui.table;

		//留言列表
		var tableIns = table.render({
			elem: '#msgList',
			url: '/messages/table-data',
			cellMinWidth: 95,
			page: true,
			height: "full-125",
			limit: 20,
			limits: [10, 15, 20, 25],
			id: "msgListTable",
			cols: [[
				{ type: "checkbox", fixed: "left", width: 50 },
				{ field: 'id', title: 'ID', width: 60, align: "center" },
				{ field: 'customerName', title: '顾客名称' },
				{ field: 'bookName', title: '书籍名称' },
				{ field: 'content', title: '留言内容' },
				{ title: '操作', width: 170, templet: '#msgListBar', fixed: "right", align: "center" }
			]]
		});

		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click", function () {
			if ($(".searchVal").val() != '') {
				table.reload("msgListTable", {
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

		//批量删除
		$(".delAll_btn").click(function () {
			var checkStatus = table.checkStatus('msgListTable'),
					data = checkStatus.data,
					ids = "";
			if (data.length > 0) {
				for (var i in data) {
					ids += "-" + data[i].id;
				}
				layer.confirm('确定删除选中的留言？', { icon: 3, title: '提示信息' }, function (index) {
					 $.get("/messages/del",{
						 ids : ids  //将需要删除的msgId作为参数传入
					 },function(data){
					tableIns.reload();
					layer.close(index);
					 })
				})
			} else {
				layer.msg("请选择需要删除的留言");
			}
		})

		//列表操作
		table.on('tool(msgList)', function (obj) {
			var layEvent = obj.event,
					data = obj.data;

			if (layEvent === 'edit') { //编辑
				editCategory(data);
			} else if (layEvent === 'del') { //删除
				layer.confirm('确定删除此留言？', { icon: 3, title: '提示信息' }, function (index) {
					$.get("/messages/del",{
					     ids : data.id  //将需要删除的msgId作为参数传入
					 },function(data){
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