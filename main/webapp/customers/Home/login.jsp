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
                <li><a href="Order.html">我的订单</a></li>
                <li><a href="UserInfo.html">个人中心</a></li>
                <li><a href="FriendLink.html">友情链接</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <li><a href="login.jsp">登录</a></li>
                <li><a href="/c/reg">注册</a></li>
                <li>
                    <a href="Cart.html"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<div class="container">
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style=" font-size: 25px; margin-bottom: 30px">用户登录</h1>
        </div> 
        <div class="col-sm-6 col-sm-offset-3">
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
                    <div class="col-sm-offset-4 col-sm-5">
                        <button type="button" onclick="login()" class="btn btn-success btn-block">登录</button>
                    </div>
                </div>
            </form>
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
    function login() {
        $.ajax({
            url: "/login/customers",
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
                if (res.code == 0) {
                    alert("用户名或密码错误");
                } else {
                    alert("登录成功");
                    window.location.href = "/";
                }
            },
            error: function (e) {
            }
        });
    }
</script>