<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>修改密码</title>
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
	<form class="layui-form layui-row changePwd">
		<div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
			<div class="layui-input-block layui-red pwdTips">新密码必须两次输入一致才能提交</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-block">
					<input type="text" value="${user.name}" disabled class="layui-input layui-disabled">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">旧密码</label>
				<div class="layui-input-block">
					<input type="password" value="" id="oldPwd" placeholder="请输入旧密码" lay-verify="required|oldPwd"
						class="layui-input pwd">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">新密码</label>
				<div class="layui-input-block">
					<input type="password" value="" placeholder="请输入新密码" lay-verify="required|newPwd" id="newPwd"
						class="layui-input pwd">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">确认密码</label>
				<div class="layui-input-block">
					<input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd"
						class="layui-input pwd">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" onclick="changePwd()">立即修改</button>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript" src="/admins/layui/layui.js"></script>
	<script type="text/javascript" src="/admins/js/jquery-3.3.1.min.js"></script>
</body>

</html>
<script>
	layui.use(['form', 'layer', 'laydate', 'table', 'laytpl'], function () {
		var form = layui.form,
			layer = parent.layer === undefined ? layui.layer : top.layer,
			$ = layui.jquery,
			laydate = layui.laydate,
			laytpl = layui.laytpl,
			table = layui.table;

		//添加验证规则
		form.verify({
			oldPwd: function (value, item) {
				if (value == "") {
					return "旧密码不能为空！";
				}
			},
			newPwd: function (value, item) {
				if (value.length < 6) {
					return "密码长度不能小于6位";
				}
			},
			confirmPwd: function (value, item) {
				if (!new RegExp($("#newPwd").val()).test(value)) {
					return "两次输入密码不一致，请重新输入！";
				}
			}
		})

		//控制表格编辑时文本的位置【跟随渲染时的位置】
		$("body").on("click", ".layui-table-body.layui-table-main tbody tr td", function () {
			$(this).find(".layui-table-edit").addClass("layui-" + $(this).attr("align"));
		});

	})
	function changePwd() {
		$.ajax({
			url: "/admins/changePwd",
			type: 'post',
			dataType: 'json',
			data: JSON.stringify({
				newPass: $("#newPwd").val(),
				oldPass: $("#oldPwd").val()
			}),
			cache: false,
			headers: {
				'Content-Type': 'application/json'
			},
			success: function (res) {
				if (res.code == 0) {
					layer.msg('修改失败，原密码错误');
					return;
				}
				layer.msg('修改成功');
			},
			error: function (e) {
				layer.msg('修改失败，稍后重试');
			}
		});
	}
</script>