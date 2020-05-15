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

        .line-limit-length {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
                    <li ><a href="/more">搜索</a></li>
                    <li><a href="/c/order">我的订单</a></li>
                    <li><a href="/c/info">个人中心</a></li>
                    <li class="active"><a href="/c/recommend">我的推荐</a></li>
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
            <c:forEach var="recommend" begin="0" items="${recommendList}">
                <div class="col-sm-4 col-md-2">
                    <div class="thumbnail">
                        <a href="/info/${recommend.book.id}">
                            <img style="width: 100%; height: 200px; display: block;" alt="100%x200"
                                src="/admins/images/${recommend.book.thumbnail}.jpg" data-src="holder.js/100%x200"
                                data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <p class="line-limit-length"><span>${recommend.book.name}</span></p>
                            <p>类别<span>${recommend.categoryName}</span></p>
                            <p style="font-size: 12px;"><span>价格:</span><span>${recommend.book.price} 元</span></p>
                            <p style="font-size: 12px;"><span>销量:</span><span>${recommend.book.sales} 本</span></p>
                            <p><a class="btn btn-primary btn-block  btn-sm" role="button"
                                    href="/info/${recommend.book.id}">查看详情</a>
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

if (window.localStorage.getItem("customer") != null) {
        $("#loginBar").html("<li><a href='#' onclick='logout()'>退出登录</a></li><li><a href='/c/cart'>"
        + "<span class='glyphicon glyphicon-shopping-cart'>购物车</span></a></li>");
    }
    function logout() {
        window.location.href = "/customers/signOut";
        localStorage.removeItem("customerId");
        localStorage.removeItem("customer");
    }
</script>