<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>订单列表</title>
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
		<table id="orderList" lay-filter="orderList"></table>
		<!--操作-->
		<script type="text/html" id="orderListBar">
		<a class="layui-btn layui-btn-xs" lay-event="detail">查看购买详情</a>
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

			//订单列表
			var tableIns = table.render({
				elem: '#orderList',
				url: '/orders/table-data',
				cellMinWidth: 95,
				page: true,
				height: "full-125",
				limit: 20,
				limits: [10, 15, 20, 25],
				id: "orderListTable",
				cols: [[
					{ type: "checkbox", fixed: "left", width: 50 },
					{ field: 'id', title: 'ID', width: 60, align: "center" },
					{ field: 'orderNumber', title: '订单号' },
					{ field: 'status', title: '订单状态' },
					{ field: 'customerName', title: '顾客名称' },
					{ field: 'address', title: '收货地址' },
					{ field: 'total', title: '总价格/元' },
					{ field: 'finish', title: '完结时间',templet:function (d){
						if (d.finish === "" || d.finish === undefined) {
							return "未完结";
						}
						return DateFormat(d.finish);
					} },
					{ title: '操作', width: 250, templet: '#orderListBar', fixed: "right", align: "center" }
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

			//添加订单
			function addOrder(edit) {
				var index = layui.layer.open({
					title: "添加订单",
					type: 2,
					content: "/orders/orderAdd",
					success: function (layero, index) {
						setTimeout(function () {
							layui.layer.tips('点击此处返回订单列表', '.layui-layer-setwin .layui-layer-close', {
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
			//编辑订单信息
			function editOrder(edit) {
				var index = layui.layer.open({
					title: "编辑订单信息",
					type: 2,
					content: "/orders/orderEdit/" + edit.id,
					success: function (layero, index) {
						var body = layui.layer.getChildFrame('body', index);
						body.find("#id").val(edit.id);
						body.find("#total").val(edit.total);
						body.find("#orderNumber").val(edit.orderNumber);
						body.find("#customerName").val(edit.customerName);
						body.find("#address").val(edit.address);
						// body.find("#finish").val(DateFormat(edit.finish));
						form.render();
						setTimeout(function () {
							layui.layer.tips('点击此处返回订单列表', '.layui-layer-setwin .layui-layer-close', {
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

			function orderDetail(edit) {
				var index = layui.layer.open({
					type: 2,
					title: '书籍购买详情',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['893px', '600px'],
					content: '/orders/detail/' + edit.id
				});

				//改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
				$(window).on("resize", function () {
					layui.layer.full(index);
				})
			}

			$(".add_btn").click(function () {
				addOrder();
			})

			//批量删除
			$(".delAll_btn").click(function () {
				var checkStatus = table.checkStatus('orderListTable'),
					data = checkStatus.data,
					ids = "";
				if (data.length > 0) {
					for (var i in data) {
						ids += "-" + data[i].id;
					}
					layer.confirm('确定删除选中的订单？', { icon: 3, title: '提示信息' }, function (index) {
						$.get("/orders/del", {
							ids: ids  //将需要删除的orderId作为参数传入
						}, function (data) {
							tableIns.reload();
							layer.close(index);
						})
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
					editOrder(data);
				} else if (layEvent === 'del') { //删除
					layer.confirm('确定删除此订单？', { icon: 3, title: '提示信息' }, function (index) {
						$.get("/orders/del", {
							ids: data.id  //将需要删除的orderId作为参数传入
						}, function (data) {
							tableIns.reload();
							layer.close(index);
						})
					});
				} else if (layEvent === 'detail') {
					orderDetail(data);
				}
			});

		})
	</script>
</body>

</html>