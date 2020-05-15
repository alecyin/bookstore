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
            width: 10%;
            ;
            padding: 10px;
        }

        td {
            text-align: left;
            width: 30%;
            ;
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
                    <li class="active"><a href="/c/info">个人中心</a></li>
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
        <div class="row thumbnail center col-sm-12">
            <div class="col-sm-12">
                <h1 class="text-center" style="margin-bottom: 30px">个人中心</h1>
            </div>

            <ul class="nav nav-tabs nav-justified" id="myTabs">
                <li class="active"><a href="#userHome">收货地址</a></li>
                <li><a href="#editPassword">密码修改</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content" style="padding: 50px;">
                <div role="tabpanel" class="tab-pane active" id="userHome">
                    <div class="btn-group" role="group" aria-label="...">
                        <a onclick="addAddress()">添加地址</a>
                        <p style="font-size: 12px;">Tips:最多添加三个地址</p>
                    </div>
                    <hr />
                    <c:if test="${not empty addressList}">
                        <c:forEach var="list1" begin="0" items="${addressList}">
                            <address>
                                <strong>${list1.contacts}</strong><br>
                                <abbr title="Phone"></abbr> ${list1.phone}<br>
                                ${list1.detail}<br>
                                <a style="font-size: 14px;" onclick="editAddress('${list1.id}' + '-' +
                                 '${list1.contacts}'  + '-' + '${list1.phone}' + '-' + '${list1.detail}')">修改</a>
                                <a style="font-size: 14px;" onclick="delAddress('${list1.id}')">删除</a>
                            </address>
                        </c:forEach>
                    </c:if>
                </div>
                <div role="tabpanel" class="tab-pane" id="editPassword">
                    <div class="row center">
                        <div class="col-sm-6 col-sm-offset-3">
                            <form class="form-horizontal caption">
                                <div class="form-group">
                                    <label for="oldPass" class="col-sm-3 control-label">原密码</label>
                                    <div class="col-sm-8">
                                        <input style="width:200px;" type="text" required class="form-control" id="oldPass">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd1" class="col-sm-3 control-label">新密码</label>
                                    <div class="col-sm-8">
                                        <input style="width:200px;" type="password" required class="form-control" id="pwd1">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd2" class="col-sm-3 control-label">确认密码</label>
                                    <div class="col-sm-8">
                                        <input style="width:200px;" type="password" required class="form-control" id="pwd2">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-4 col-sm-5">
                                        <button type="button" onclick="editPass()"
                                            class="btn btn-success">修改</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="orderManager">订单管理</div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="createFileMModal" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <input type="text" id="msgId" style="display: none;" />
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createFileTitle">创建文件</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="text" style="display: none;" id="addressId" />
                        <div class="form-group">
                            <label for="contacts" class="col-form-label">联系人</label>
                            <div class="form-group">
                                <input type="text" class="form-control" id="contacts" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-form-label">手机号码</label>
                            <div class="form-group">
                                <input type="text" class="form-control" id="phone" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="detail" class="col-form-label">详细地址</label>
                            <div class="form-group">
                                <textarea id="detail" autofocus class="form-control" rows="3"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="createFileSureBut">确定</button>
                </div>
            </div>
        </div>
    </div>

    <!--footer-->
    <div style="text-align: center;line-height: 50px;" class="navbar navbar-default navbar-static-bottom">
    copyright @2020 Recover
</div>
</body>

</html>
<script>

    function addAddress() {
        ShowCreateModal("添加地址", null);
    }
    function editAddress(str) {
        ShowCreateModal("修改地址");
        $("#detail").val(str.split("-")[3]);
        $("#phone").val(str.split("-")[2]);
        $("#contacts").val(str.split("-")[1]);
        $("#addressId").val(str.split("-")[0]);
    }
    function delAddress(id) {
        $.ajax({
            url: "/addresses/del",
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                id: id
            }),
            cache: false,
            headers: {
                'Content-Type': 'application/json'
            },
            success: function (res) {
                if (res.code == 0) {
                    alert("删除失败");
                }
                location.reload();
            },
            error: function (e) {
            }
        });
    }
    function ShowCreateModal(title) {
        $("#createFileTitle").text(title);
        $('#createFileMModal').modal('show');
    }
    $("#createFileSureBut").click(function () {
        if ($("#addressId").val() != "") {
            $.ajax({
                url: "/addresses/edit",
                type: 'post',
                dataType: 'json',
                data: JSON.stringify({
                    detail: $("#detail").val(),
                    phone: $("#phone").val(),
                    contacts: $("#contacts").val(),
                    id: $("#addressId").val()
                }),
                cache: false,
                headers: {
                    'Content-Type': 'application/json'
                },
                success: function (res) {
                    if (res.code == 0) {
                        alert("修改失败");
                    }
                    $("#detail").val("");
                    $("#phone").val("");
                    $("#contacts").val("");
                    $("#addressId").val()
                    location.reload();
                },
                error: function (e) {
                    $("#detail").val("");
                    $("#phone").val("");
                    $("#contacts").val("");
                    $("#addressId").val()
                    location.reload();
                }
            });
        } else {
            $.ajax({
                url: "/addresses/add",
                type: 'post',
                dataType: 'json',
                data: JSON.stringify({
                    detail: $("#detail").val(),
                    phone: $("#phone").val(),
                    contacts: $("#contacts").val()
                }),
                cache: false,
                headers: {
                    'Content-Type': 'application/json'
                },
                success: function (res) {
                    if (res.code == 0) {
                        alert("添加失败");
                    }
                    $("#detail").val("");
                    $("#phone").val("");
                    $("#contacts").val("");
                    location.reload();
                },
                error: function (e) {
                    $("#detail").val("");
                    $("#phone").val("");
                    $("#contacts").val("");
                    location.reload();
                }
            });
        }
        $("#createFileMModal").modal("hide");
    });
    function editPass() {
        if ($("#pwd1").val() != $("#pwd2").val()) {
            alert("两次密码输入不一致");
            return;
        }
        $.ajax({
                url: "/c/editPass",
                type: 'post',
                dataType: 'json',
                data: JSON.stringify({
                    oldPass: $("#oldPass").val(),
                    newPass: $("#pwd1").val()
                }),
                cache: false,
                headers: {
                    'Content-Type': 'application/json'
                },
                success: function (res) {
                    if (res.code == 0) {
                        alert("原密码错误");
                    } else {
                        alert("修改成功");
                    }
                },
                error: function (e) {
                    alert("修改失败");
                }
            });
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