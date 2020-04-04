<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>添加类别</title>
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
<form class="layui-form layui-row layui-col-space10">
	<div class="layui-col-md9 layui-col-xs12">
        <div class="layui-form-item magt3">
					<label class="layui-form-label">类别名</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" id="categoryName" lay-verify="categoryName" placeholder="请输入类别名称">
					</div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label"></label>
          <div class="layui-input-block">
              <a class="layui-btn layui-btn-sm" lay-filter="addCategory" lay-submit>保存</a>
          </div>
        </div>
			</div>	
		</div>
	</div>
</form>
<script type="text/javascript" src="/admins/layui/layui.js"></script>
<script>
	layui.use(['form', 'layer'], function () {
		var form = layui.form
		layer = parent.layer === undefined ? layui.layer : top.layer,
				laypage = layui.laypage,
				$ = layui.jquery;
		form.verify({
			categoryName: function (val) {
				if (val == '') {
					return "类别名称不能为空";
				}
			}
		});

		form.on("submit(addCategory)", function (data) {
			//弹出loading
			var index = top.layer.msg('数据提交中，请稍候', { icon: 16, time: false, shade: 0.8 });
			$.ajax({
				url: "/categories/add",
				type: 'post',
				dataType: 'json',
				data: JSON.stringify({
					name : $("#categoryName").val(),  //类别名称
					pwd : $("#pwd").val()
				}),
				cache: false,
				headers: {
					'Content-Type': 'application/json'
				},
				success: function (res) {
				},
				error: function (e) {
				}
			});
			setTimeout(function () {
				top.layer.close(index);
				top.layer.msg("类别添加成功！");
				layer.closeAll("iframe");
				//刷新父页面
				parent.location.reload();
			}, 500);
			return false;
		});
	});
</script>
</body>
</html>