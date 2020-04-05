<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        .center{
            text-align: center;
        }
    </style>
    <script>
        $(function () {
            $('#myTabs a').click(function (e) {
                $(this).tab('show')
            });
        })
    </script>
</head>
<body>

<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">这什么东西</span>
            </button>
            <a class="navbar-brand" href="/">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/">首页</a></li>
                <li><a href="Order.html">我的订单</a></li>
                <li><a href="UserInfo.html">个人中心</a></li>
                <li><a href="FriendLink.html">友情链接</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <li><a href="/c/login">登录</a></li>
                <li><a href="/c/reg">注册</a></li>
                <li>
                    <a href="Cart.html"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<!--content-->
<div class="row thumbnail">
    <div class="col-sm-3">
            <img style="width: 100%; height: 500px; display: block;" src="/admins/images/${book.thumbnail}.jpg"  data-holder-rendered="true">
            <div class="caption right">
                <pp>${book.name}</p>
                <p>作者：${book.author}</p>
                <p>出版社：${book.isbn}</p>
                <p>价格：${book.price} 元</p>
                <p>出版日期：<fmt:formatDate value="${book.pubdate}" pattern="yyyy年MM月dd日" /></p>
                <p><a class="btn btn-info btn-block" role="button" href="#">加入购物车</a></p>
            </div>
    </div>
    <div class="col-sm-8">
        <div class="caption">
                <h4>图书简介</h4>
                <p style="text-indent:2em;">${book.sketch}</p>
                <div class="page-header">
                </div>
                <form role="form">
                    <div class="form-group">
                        <textarea class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="btn-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-info">留言</button>
                        </div>
                    </div>      
                </form>  
                <ul class="list-group">
                    <li class="list-group-item">Cras justo odio</li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li>
                  </ul>
        </div>

    </div>

</div>

<!--footer-->
<div class="navbar navbar-default navbar-static-bottom">
    版权声明区
</div>
</body>
</html>