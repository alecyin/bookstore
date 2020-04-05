<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">

    <link rel="stylesheet" href="/customers/bootstrap-3.3.4/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/customers/Flat-UI-master/dist/css/flat-ui.min.css"/>
    <script src="/customers/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
    <script src="/customers/bootstrap-3.3.4/dist/js/bootstrap.min.js"></script>
    <script src="/customers/Flat-UI-master/dist/js/flat-ui.min.js"></script>
    <title></title>
    <style>
        .row{
            margin-left: 20px;
            margin-right: 20px;;
        }
    </style>
</head>
<body>
<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">这什么东西</span>
            </button>
            <a class="navbar-brand" href="index.jsp">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="FriendLink.html">友情链接</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <li><a href="login.jsp">登录</a></li>
                <li><a href="register.jsp">注册</a></li>
                <li>
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<div class="container">
    <div class="row thumbnail">
        <div class="col-sm-12">
             <h1 class="text-center" style=" font-size: 25px; margin-bottom: 30px">用户注册</h1>
        </div>
        <div class="col-sm-6">
            <form class="form-horizontal caption">
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">用户名</label>
                    <div class="col-sm-8">
                        <input type="text" required class="form-control" id="name" placeholder="用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">密码</label>
                    <div class="col-sm-8">
                        <input type="password" required class="form-control" id="pwd" placeholder="密码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">确认密码</label>
                    <div class="col-sm-8">
                        <input type="password" required class="form-control" id="pwd2" placeholder="确认密码">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-5">
                        <button type="button" onclick="reg()" class="btn btn-success btn-block">注册</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-sm-6">
            <div class="caption">
                <h3>注意事项</h3>
                <p>请务必保存好登录信息</p>

            </div>

        </div>

    </div>
</div>


<!--footer-->
<div class="navbar navbar-default navbar-static-bottom">
    版权声明区
</div>
</body>
</html>
<script>
    function reg() {
        if ($("#pwd").val() != $("#pwd2").val()) {
            alert("两次密码输入不同");
            return;
        }
        $.ajax({
            url: "/customers/reg",
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                name : $("#name").val(),  //类别名称
                pwd : $("#pwd").val()
            }),
            cache: false,
            headers: {
                'Content-Type': 'application/json'
            },
            success: function (res) {
                alert("注册成功");
            },
            error: function (e) {
            }
        });
    }
</script>