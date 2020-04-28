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
				<a class="layui-btn layui-btn-normal add_btn">添加书籍</a>
			</div>

			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
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
	layui.use(['form', 'layer', 'table', 'laytpl','upload'], function () {
		var form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laytpl = layui.laytpl,
				upload = layui.upload,
				table = layui.table;

		//书籍列表
		var tableIns = table.render({
			elem: '#bookList',
			url: '/books/table-data',
			cellMinWidth: 95,
			page: true,
			height: "full-125",
			limit: 20,
			limits: [10, 15, 20, 25],
			id: "bookListTable",
			cols: [[
				{ type: "checkbox", fixed: "left", width: 50 },
				{ field: 'id', title: 'ID', width: 60, align: "center" },
				{ field: 'name', title: '书籍名称' },
				{ field: 'author', title: '作者' },
				{ field: 'categoryName', title: '类别' },
				{ field: 'isbn', title: 'ISBN' },
				{ field: 'publish', title: '出版社' },
				{ field: 'pubdate', title: '出版日期',templet:function (d){
						return DateFormat(d.pubdate);
					} },
				{
					field: 'thumbnail',
					title: '展示缩略图',
					width: 100,
					align: 'center',
					templet: function(d) {
						var url ="/admins/images/"+d.thumbnail+".jpg";
						return '<a href="' + url + '" target="_blank " title="点击查看">' +
								'<img src="' + url + '" style="height:20px;" />' +
								'</a>';
					}
				},
				{ field: 'sketch', title: '简介' },
				{ field: 'price', title: '单价/元' },
				{ field: 'sales', title: '销量/本' },
				{ title: '操作', width: 170, templet: '#bookListBar', fixed: "right", align: "center" }
			]]
		});


		// 数据表单时间戳转换为日期显示
		function DateFormat(sjc){
			var date = new Date(sjc);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			m = m<10?'0'+m:m;
			var d = date.getDate();
			d = d<10?("0"+d):d;
			var h = date.getHours();
			h = h<10?("0"+h):h;
			var min = date.getMinutes();
			min = min<10?("0"+min):min;
			var s = date.getSeconds();
			s = s<10?("0"+s):s;
			var str = y+"-"+m+"-"+d;
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
		
		//添加书籍
		function addBook(edit) {
			var index = layui.layer.open({
				title: "添加书籍",
				type: 2,
				content: "/books/bookAdd",
				success: function (layero, index) {
					setTimeout(function () {
						layui.layer.tips('点击此处返回书籍列表', '.layui-layer-setwin .layui-layer-close', {
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
		//编辑书籍信息
		function editBook(edit) {
			var index = layui.layer.open({
				title: "编辑书籍信息",
				type: 2,
				content: "/books/bookEdit/" + edit.id,
				success: function (layero, index) {
					var body = layui.layer.getChildFrame('body', index);
					body.find("#id").val(edit.id);
					body.find("#name").val(edit.name);
					body.find("#author").val(edit.author);
					body.find("#pubdate").val(DateFormat(edit.pubdate));
					body.find("#sketch").val(edit.sketch);
					body.find("#isbn").val(edit.isbn);
					body.find("#publish").val(edit.publish);
					body.find("#price").val(edit.price);
					body.find("#category").val(edit.category);
					form.render();
					setTimeout(function () {
						layui.layer.tips('点击此处返回书籍列表', '.layui-layer-setwin .layui-layer-close', {
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
			addBook();
		})

		//批量删除
		$(".delAll_btn").click(function () {
			var checkStatus = table.checkStatus('bookListTable'),
					data = checkStatus.data,
					ids = "";
			if (data.length > 0) {
				for (var i in data) {
					ids += "-" + data[i].id;
				}
				layer.confirm('确定删除选中的书籍？', { icon: 3, title: '提示信息' }, function (index) {
					 $.get("/books/del",{
						 ids : ids  //将需要删除的bookId作为参数传入
					 },function(data){
					tableIns.reload();
					layer.close(index);
					 })
				})
			} else {
				layer.msg("请选择需要删除的书籍");
			}
		})

		//列表操作
		table.on('tool(bookList)', function (obj) {
			var layEvent = obj.event,
					data = obj.data;

			if (layEvent === 'edit') { //编辑
				editBook(data);
			} else if (layEvent === 'del') { //删除
				layer.confirm('确定删除此书籍？', { icon: 3, title: '提示信息' }, function (index) {
					$.get("/books/del",{
					     ids : data.id  //将需要删除的bookId作为参数传入
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