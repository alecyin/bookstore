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

        th {
            text-align: right;
            width: 200px;
            ;
        }

        td {
            text-align: left;
            padding: 10px;
        }

        .table th {
            text-align: center;
        }

        .table td {
            text-align: center;
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
                    <li class="active"><a href="/">首页</a></li>
                    <li><a href="/c/order">我的订单</a></li>
                    <li><a href="/c/info">个人中心</a></li>
                    <li><a href="FriendLink.html">友情链接</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right hidden-sm">
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
        <div class="row thumbnail center col-sm-12">
            <div class="col-sm-12">
                <h1 class="text-center" style="font-size: 40px;margin-bottom: 30px">订单详情</h1>
            </div>

            <div class="col-sm-12 ">
                <table>
                    <tr>
                        <th>订单编号：</th>
                        <td>${orderDetail.orderNumber}</td>
                    </tr>
                    <tr>
                        <th>订单状态：</th>
                        <td>${orderDetail.status}</td>
                    </tr>
                    <tr>
                        <th>收货人姓名：</th>
                        <td>${orderDetail.contacts}</td>
                    </tr>
                    <tr>
                        <th>收货人电话：</th>
                        <td>${orderDetail.phone}</td>

                    </tr>
                    <tr>
                        <th>收货人地址：</th>
                        <td>${orderDetail.detail}</td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-12">
                <table class="table table-striped table-condensed">
                    <tr>
                        <th>书名</th>
                        <th>单价</th>
                        <th>数量/本</th>
                        <th>小计/元</th>
                    </tr>
                    <c:if test="${not empty orderDetail.book}">
            
                        <c:forEach var="bookList" begin="0" items="${orderDetail.book}">
                            <tr>
                                <td>${bookList.bookName}</td>
                                <td>${bookList.price}</td>
                                <td>${bookList.amount}</td>
                                <td>${bookList.smallCnt}</td>
                            </tr>
                        </c:forEach>
 
                </c:if>
                    <tr></tr>
                </table>
            </div>

            <div class="col-sm-12 ">
                <table>
                    <tr>
                        <th> </th>
                        <th></th>
                        <th>商品总数：</th>
                        <td>${orderDetail.amountAll}</td>
                        <th>订单总价：</th>
                        <td><span class="text-danger">${orderDetail.total}元</span></label></td>
                    </tr>
                </table>
            </div>
        </div>
        <div></div>
        <c:if test="${orderDetail.status != '已完结'}">
            <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
                <div class="col-sm-6 btn btn-success btn-block" onclick="finishOrder('${orderDetail.id}')">完结订单</div>
            </div>
        </c:if>
        <c:if test="${orderDetail.status == '已完结'}">
            <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">

            </div>
        </c:if>
    </div>

    <!--footer-->
    <div class="navbar navbar-default navbar-static-bottom ">
        版权声明区
    </div>
</body>

</html>
<script>
    function finishOrder(id) {
        $.ajax({
            url: "/orders/finish",
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                id: id
            }),
            async:false,
            cache: false,
            headers: {
                'Content-Type': 'application/json'
            },
            success: function () {
                alert("完结成功");
                location.reload();
            },
            error: function (e) {
                alert("完结成功");
                location.reload();
            }
        });
    }
</script>