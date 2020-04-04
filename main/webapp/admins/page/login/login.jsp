<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="loginHtml">
<head>
	<meta charset="utf-8">
	<title>管理系统</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="/admins/favicon.ico">
	<link rel="stylesheet" href="/admins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="/admins/css/public.css" media="all" />
</head>
<body class="loginBody">
	<form class="layui-form">
		<div class="layui-form-item input-item">
			<label for="name">用户名</label>
			<input type="text" placeholder="请输入用户名" autocomplete="off" id="name" name="name" class="layui-input" lay-verify="required">
		</div>
		<div class="layui-form-item input-item">
			<label for="pwd">密码</label>
			<input type="password" placeholder="请输入密码" autocomplete="off" id="pwd" name="pwd" class="layui-input" lay-verify="required">
		</div>
		<div class="layui-form-item">
			<button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
		</div>
	</form>
	<script type="text/javascript" src="/admins/layui/layui.js"></script>
	<script>
		layui.use(['form', 'layer', 'jquery'], function () {
			var form = layui.form,
					layer = parent.layer === undefined ? layui.layer : top.layer
			$ = layui.jquery;
			//登录按钮
			form.on("submit(login)", function (data) {
				$(this).text("登录中...").attr("disabled", "disabled").addClass("layui-disabled");
				$.ajax({
					url: '/login/admins',
					type: 'post',
					dataType: 'json',
					data: JSON.stringify(data.field),
					cache: false,
					headers: {
						'Content-Type': 'application/json'
					},
					success: function (res) {
						console.log(res);
						if (res.code == 1) {
							var data = res.data;
							setTimeout(function () {
								if (typeof data != "string") {
									data = JSON.stringify(data);
								}
								layer.msg('登录成功');
								localStorage.setItem("user", data);
								window.location.href = "/admins";
							}, 1000);
						} else {
							layer.msg('用户名或密码错误');
						}
					},
					error: function (e) {
					}
				});
				$(this).text("登录").removeAttr("disabled", "disabled").removeClass("layui-disabled");
				return false;
			})

			//表单输入效果
			$(".loginBody .input-item").click(function (e) {
				e.stopPropagation();
				$(this).addClass("layui-input-focus").find(".layui-input").focus();
			})
			$(".loginBody .layui-form-item .layui-input").focus(function () {
				$(this).parent().addClass("layui-input-focus");
			})
			$(".loginBody .layui-form-item .layui-input").blur(function () {
				$(this).parent().removeClass("layui-input-focus");
				if ($(this).val() != '') {
					$(this).parent().addClass("layui-input-active");
				} else {
					$(this).parent().removeClass("layui-input-active");
				}
			})
		})

	</script>
	<script type="text/javascript" src="/admins/js/cache.js"></script>
</body>
</html>