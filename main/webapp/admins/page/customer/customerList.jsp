<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>顾客列表</title>
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
				<a class="layui-btn layui-btn-normal add_btn">添加顾客</a>
			</div>

			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="customerList" lay-filter="customerList"></table>
	<!--操作-->
	<script type="text/html" id="customerListBar">
		<a class="layui-btn layui-btn-xs" lay-event="resetPass">重置密码</a>
<%--		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
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

		//顾客列表
		var tableIns = table.render({
			elem: '#customerList',
			url: '/customers/table-data',
			cellMinWidth: 95,
			page: true,
			height: "full-125",
			limit: 20,
			limits: [10, 15, 20, 25],
			id: "customerListTable",
			cols: [[
				{ type: "checkbox", fixed: "left", width: 50 },
				{ field: 'id', title: 'ID', width: 60, align: "center" },
				{ field: 'name', title: '用户名' },
				{ field: 'address1', title: '地址一' },
				{ field: 'address2', title: '地址二' },
				{ field: 'address3', title: '地址三' },
				{ title: '操作', width: 170, templet: '#customerListBar', fixed: "right", align: "center" }
			]]
		});
		upload.render({ //允许上传的文件后缀
			elem: '#upload_btn'
			,url: '/upload/'
			,accept: 'file' //普通文件
			,exts: 'xls|xlsx' //只允许excel文件
			,done: function(res){
				console.log(res)
			}
		});
		//是否激活
		form.on('switch(customerStatus)', function (data) {
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
				table.reload("customerListTable", {
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
		//添加顾客
		function addCustomer(edit) {
			var index = layui.layer.open({
				title: "添加顾客",
				type: 2,
				content: "/customers/customerAdd",
				success: function (layero, index) {
					setTimeout(function () {
						layui.layer.tips('点击此处返回顾客列表', '.layui-layer-setwin .layui-layer-close', {
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
		//编辑顾客信息
		function editCustomer(edit) {
			var index = layui.layer.open({
				title: "编辑顾客信息",
				type: 2,
				content: "customerEdit.jsp",
				success: function (layero, index) {
					var body = layui.layer.getChildFrame('body', index);
					body.find("#customerId").val(edit.customerId);
					body.find("#customerName").val(edit.customerName);
					body.find("#customerEmail").val(edit.customerEmail);
					body.find("#customerTel").val(edit.customerTel);
					body.find("#customer input[name='customerStatus']").prop("checked", edit.customerStatus);
					form.render();
					setTimeout(function () {
						layui.layer.tips('点击此处返回顾客列表', '.layui-layer-setwin .layui-layer-close', {
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
			addCustomer();
		})

		//批量删除
		$(".delAll_btn").click(function () {
			var checkStatus = table.checkStatus('customerListTable'),
					data = checkStatus.data,
					ids = "";
			if (data.length > 0) {
				for (var i in data) {
					ids += "-" + data[i].id;
				}
				layer.confirm('确定删除选中的顾客？', { icon: 3, title: '提示信息' }, function (index) {
					 $.get("/customers/del",{
						 ids : ids  //将需要删除的customerId作为参数传入
					 },function(data){
					tableIns.reload();
					layer.close(index);
					 })
				})
			} else {
				layer.msg("请选择需要删除的顾客");
			}
		})

		//列表操作
		table.on('tool(customerList)', function (obj) {
			var layEvent = obj.event,
					data = obj.data;

			if (layEvent === 'edit') { //编辑
				editCustomer(data);
			} else if (layEvent === 'del') { //删除
				layer.confirm('确定删除此顾客？', { icon: 3, title: '提示信息' }, function (index) {
					$.get("/customers/del",{
					     ids : data.id  //将需要删除的customerId作为参数传入
					 },function(data){
					tableIns.reload();
					layer.close(index);
					})
				});
			} else if (layEvent === 'resetPass') {
				layer.confirm('确定重置此顾客密码？', { icon: 3, title: '提示信息' }, function (index) {
					$.get("/customers/resetPass",{
						id : data.id
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