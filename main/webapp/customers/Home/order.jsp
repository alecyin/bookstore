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
    <script src="/customers/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
    <script src="/customers/bootstrap-3.3.4/dist/js/bootstrap.min.js"></script>
    <script src="/customers/Flat-UI-master/dist/js/flat-ui.min.js"></script>
    <title></title>
    <style>
        .row {
            margin-left: 20px;
            margin-right: 20px;
            ;
        }

        .line-center {
            line-height: 50px;
            text-align: center;
        }

        .row input {
            width: 50px;
        }

        .list-group-item:hover {
            background: #27ae60;

        }

        .list-group-item div:first-child:hover {

            cursor: pointer;
        }
    </style>
    <script>
        function myClick(n) {
            location.href = "OrderInfo.html";
        }
        function btnClick() {
            alert("btn");
            return false;
        }
        $(function () {

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
                    <li class="active"><a href="/c/order">我的订单</a></li>
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
        <div class="row thumbnail center">
            <div class="col-sm-12">
                <h1 class="text-center" style="margin-bottom: 30px;font-size: 40px;">我的订单</h1>
            </div>
            <div class="col-sm-12 thumbnail">
                <div class="col-sm-3 line-center">订单编号</div>
                <div class="col-sm-3 line-center">订单状态</div>
                <div class="col-sm-3 line-center">订单总价</div>
                <div class="col-sm-3 line-center">操作</div>
            </div>
            <div class="list-group">
                <c:if test="${not empty orderList}">
                    <p style="text-indent:4em;color: blue;">
                        <c:forEach var="list1" begin="0" items="${orderList}">
                            <div class="col-sm-12  list-group-item">
                                <div class="col-sm-3 line-center">${list1.orderNumber}</div>
                                <div class="col-sm-3 line-center">${list1.status}</div>
                                <div class="col-sm-3 line-center">${list1.total}元</div>
                                <div class="col-sm-3 line-center">
                                    <button class="btn btn-danger" onclick="delOrder('${list1.id}')">删除订单</button>
                                    <button class="btn btn-success" onclick="detailOrder('${list1.id}')">查看详情</button>

                                </div>
                            </div>
                        </c:forEach>
                    </p>
                </c:if>


            </div>
        </div>


        <!--footer-->
        <div style="text-align: center;line-height: 50px;" class="navbar navbar-default navbar-static-bottom">
    copyright @2020 Recover
</div>
</body>

</html>
<script>
    function delOrder(id) {
        $.ajax({
            url: "/orders/del",
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                id: id
            }),
            async: true,
            cache: false,
            headers: {
                'Content-Type': 'application/json'
            },
            success: function (res) {
                alert("删除成功");
                location.reload();
            },
            error: function (e) {
                alert("删除成功");
                location.reload();
            }
        });
        location.reload();
    }
    function detailOrder(id) {
        window.location.href = "/c/orderInfo/" + id;
    }
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