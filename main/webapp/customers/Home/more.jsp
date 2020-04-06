<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">

    <link rel="stylesheet" href="/customers/bootstrap-3.3.4/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/customers/Flat-UI-master/dist/css/flat-ui.min.css" />
    <script src="/customers/bootstrap-3.3.4/dist/js/jquery-1.11.3.min.js"></script>
    <script src="/customers/bootstrap-3.3.4/dist/js/bootstrap.min.js"></script>
    <script src="/customers/Flat-UI-master/dist/js/flat-ui.min.js"></script>
    <title></title>
    <style>
        .row {
            margin-top: 20px;
        ;
        }

        .center {
            text-align: center;
        }

        .pagination {
            background: #cccccc;
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
                <li><a href="/">首页</a></li>
                <li class="active"><a href="/more">搜索</a></li>
                <li><a href="/c/order">我的订单</a></li>
                <li><a href="/c/info">个人中心</a></li>
                <li><a href="/c/recommend">我的推荐</a></li>
            </ul>
            <ul id="loginBar" class="nav navbar-nav navbar-right hidden-sm">
                <li><a href="/c/login">登录</a></li>
                <li><a href="/c/reg">注册</a></li>
                <li>
                    <a href="/c/cart"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</div>

<!--content-->
<div class="container">
    <div class="row">
        <div class="col-lg-6  col-lg-offset-3">
            <div class="input-group">
              <input type="text" id="keyword" class="form-control" placeholder="书名/作者/出版社">
              <span class="input-group-btn">
                <button class="btn btn-default" type="button" onclick="search()">搜索</button>
              </span>
            </div><!-- /input-group -->
          </div><!-- /.col-lg-6 -->
      </div><!-- /.row -->
      <br/>
    <ul class="nav nav-tabs" id="myTabs">
        <c:if test="${not empty actived}">
            <c:forEach var="list1" begin="0" items="${caList}">
                <c:choose>
                    <c:when test="${actived == list1.id}">
                        <li class="active"><a href="/more/${list1.id}">${list1.name}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/more/${list1.id}">${list1.name}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
        <c:if test="${empty actived}">
            <li class="active"><a href="/more/${caList[0].id}">${caList[0].name}</a></li>
            <c:forEach var="list1" begin="1" items="${caList}">
                <li><a href="/more/${list1.id}">${list1.name}</a></li>
            </c:forEach>
        </c:if>
        <!-- <a style="float: right;" class="btn btn-primary btn-sm" href="/more/${actived}" role="button">查看更多</a> -->
    </ul>
    <div class="row">
        <c:forEach var="list2" items="${bList}">
            <div class="col-sm-4 col-md-2">
                <div class="thumbnail">
                    <a href="/info/${list2.id}">
                        <img style="width: 100%; height: 200px; display: block;" alt="100%x200"
                             src="/admins/images/${list2.thumbnail}.jpg" data-src="holder.js/100%x200"
                             data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <p><span>${list2.name}</span></p>
                        <p style="font-size: 12px;"><span>价格:</span><span>${list2.price} 元</span></p>
                        <p><a class="btn btn-primary btn-block  btn-sm" role="button" href="/info/${list2.id}">查看详情</a>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<!--footer-->
<div style="text-align: center;line-height: 50px;" class="navbar navbar-default navbar-static-bottom">
    copyright @2020 Recover
</div>
</body>

</html>
<script>
    function search() {
        window.location.href = "/more/${actived}/keyword/" + $("#keyword").val();
    }
    if (window.localStorage.getItem("customer") != null) {
        $("#loginBar").html("<li><a href='#' onclick='logout()'>退出登录</a></li><li><a href='/c/cart'>"
        + "<span class='glyphicon glyphicon-shopping-cart'>购物车</span></a></li>");
    }
    function logout() {
        window.location.href = "/customers/signOut";
        localStorage.clear();
    }
</script>