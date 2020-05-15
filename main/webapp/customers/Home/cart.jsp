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
                <a class="navbar-brand" href="/">图书商城</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="/">首页</a></li>
                    <li><a href="/more">搜索</a></li>
                    <li><a href="/c/order">我的订单</a></li>
                    <li><a href="/c/info">个人中心</a></li>
                    <li><a href="/c/recommend">我的推荐</a></li>
                </ul>
                <ul id="loginBar" class="nav navbar-nav navbar-right hidden-sm">
                    <li><a href="/c/login">登录</a></li>
                    <li><a href="/c/reg">注册</a></li>
                    <li class="active">
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
                <h3 class="text-center" style="margin-bottom: 30px">购物车</h3>
            </div>
            <div class=" list-group">

                <div class="col-sm-12 ">
                    <div class="col-sm-3 line-center">图书</div>
                    <div class="col-sm-2 line-center">单价/元</div>
                    <div class="col-sm-3 line-center">数量 </div>
                    <div class="col-sm-2 line-center">小计/元</div>
                    <div class="col-sm-1 line-center">操作</div>
                </div>
                <key id="point"></key>


                <div class="col-sm-12 thumbnail">
                    <div class=" col-sm-offset-4 col-sm-2 text-right">总数/本：</div>
                    <div class="col-sm-2" id="amountAll">0</div>
                    <div class="col-sm-2 text-right">总价/元：</div>
                    <div class="col-sm-2" id="cntAll">0</div>
                </div>
            </div>
            <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
                <div class="col-sm-6  btn btn-success btn-block" onclick="subOrder()">提交订单</div>
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

                        <select id="addressSelect" name="addressSelect" multiple class="form-control">

                            <c:if test="${not empty addressList}">
                                <c:forEach var="list1" begin="0" items="${addressList}" varStatus="status">
                                    <option value="${list1.id}">
                                        <address>
                                            收货地址${status.index + 1} :
                                            <strong>${list1.contacts}</strong><br>
                                            <abbr title="Phone"></abbr> ${list1.phone}<br>
                                            ${list1.detail}<br><br><br>
                                            <hr />
                                        </address>
                                    </option>
                                </c:forEach>
                            </c:if>
                        </select>

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
    var storage = window.localStorage;
    var customerId = window.localStorage.getItem("customerId");
    var htmls = "";

    for (var i = 0, len = storage.length; i < len; i++) {
        var key = storage.key(i);
        if (key.indexOf(customerId + "-book-") == -1) {
            continue;
        }
        var value = storage.getItem(key);
        let bookId = value.split("-")[0];
        let name = value.split("-")[1];
        let price = value.split("-")[2];
        let thumbnail = value.split("-")[3];
        htmls += "<s id='s" + bookId + "'><div class='col-sm-12  list-group-item'><div class='col-sm-1 line-center' style='width: 50px;height: 50px;'>"
            + "<img src='/admins/images/" + thumbnail + ".jpg' style='height: 100%;' alt=''/></div>"
            + "<div class='col-sm-3 line-center'>" + name + "</div><div id=price" + bookId + " class='col-sm-1 line-center'>" + price + "</div><div class='col-sm-4 line-center'>"
            + "<button type='button' onclick='subNum(" + bookId + ")' class='btn btn-default'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span>"
            + "</button><input name='amount' id=amount" + bookId + " type='text' class='small' value='0'/><button type='button' onclick='addNum(" + bookId + ")' class='btn btn-default'>"
            + "<span class='glyphicon glyphicon-plus' aria-hidden='true'></span></button></div><div name='cntOne' id=cntOne" + bookId + " class='col-sm-2 line-center'></div>"
            + "<div class='col-sm-1 line-center'><button class='btn btn-danger' onclick='delS(" + bookId + ")'>删除</button></div></div></s>";

    }
    $("#point").append(htmls);
    for (var i = 0, len = storage.length; i < len; i++) {
        var key = storage.key(i);
        if (key.indexOf(customerId + "-book-") == -1) {
            continue;
        }
        var value = storage.getItem(key);
        let bookId = value.split("-")[0];
        $("#amount" + bookId).bind("input", function () { amountCnt(bookId); });
    }

    function subNum(sId) {
        if (parseInt($("#amount" + sId).val()) > 0) {
            $("#amount" + sId).val(parseInt($("#amount" + sId).val()) - 1);
            amountCnt(sId);
        }
    }
    function addNum(sId) {
        $("#amount" + sId).val(parseInt($("#amount" + sId).val()) + 1);
        amountCnt(sId);
    }
    function amountCnt(bookId) {
        if (bookId != -1)
            $("#cntOne" + bookId).text(plusFloat($("#amount" + bookId).val(), $("#price" + bookId).text()));
        var a = 0;
        $("input[name='amount']").each(function (j, item) {
            a += parseInt(item.value);
        });
        $("#amountAll").text(a);
        var b = 0;
        $("div[name='cntOne']").each(function (j, item) {
            b = numAdd(b, item.innerText);
        });
        $("#cntAll").text(b);
    }
    function delS(sId) {
        $("#s" + sId).remove();
        amountCnt(-1)
    }
    function numAdd(num1, num2) {
        var baseNum, baseNum1, baseNum2;
        try {
            baseNum1 = num1.toString().split(".")[1].length;
        } catch (e) {
            baseNum1 = 0;
        }
        try {
            baseNum2 = num2.toString().split(".")[1].length;
        } catch (e) {
            baseNum2 = 0;
        }
        baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
        return (num1 * baseNum + num2 * baseNum) / baseNum;
    }
    function plusFloat(arg1, arg2) {
        var m = 0, s1 = arg1.toString(), s2 = arg2.toString();

        try {
            m += s1.split(".")[1].length;
        } catch (e) { }
        try {
            m += s2.split(".")[1].length;
        } catch (e) { }
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    }
    function subOrder() {
        ShowCreateModal("选择收货地址");
    }

    function ShowCreateModal(title) {
        $("#createFileTitle").text(title);
        $('#createFileMModal').modal('show');
    }
    $("#createFileSureBut").click(function () {
        var res = "";
        for (var i = 0, len = storage.length; i < len; i++) {
            var key = storage.key(i);
            var value = storage.getItem(key);
            let bookId = value.split("-")[0];
            var amount = $("#amount" + bookId).val();
            if (amount != 0 && amount != undefined) {
                res += "|" + bookId + "-" + amount;
            }
        }
        if (res == null || res == "") {
            alert("请选择书籍");
            return;
        }
        if ($("#addressSelect option:selected").val() == null || $("#addressSelect option:selected").val() == undefined) {
            alert("请选择地址");
            return;
        }
        $("#createFileMModal").modal("hide");
        $.ajax({
            url: "/orders/add",
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                books: res,
                addressId: $("#addressSelect option:selected").val(),
                total: $("#cntAll").text()
            }),
            cache: false,
            headers: {
                'Content-Type': 'application/json'
            },
            success: function (res) {
                if (res.code == 0) {
                    alert("提交失败");
                    return;
                }
                alert("提交成功");
                delSs();
            },
            error: function (e) {
                alert("稍后重试");
            }
        });
    });
    function delSs() {
        var storage = window.localStorage;
        var delIds = "";
        var customerId = window.localStorage.getItem("customerId");
        for (var j = 0, len = storage.length; j < len; j++) {
            var key = storage.key(j);
            if (key.indexOf(customerId + "-book-") != -1) {
                 delIds += "|" + key;
             }
        }
        for (i=0;i < delIds.split("|").length ;i++ )
        {
            if (delIds.split("|")[i] != "") {
                storage.removeItem(delIds.split("|")[i]);
            }
            
        }
        location.reload();
    }
    if (window.localStorage.getItem("customer") != null) {
        $("#loginBar").html("<li><a href='#' onclick='logout()'>退出登录</a></li><li class='active'><a href='/c/cart'>"
            + "<span class='glyphicon glyphicon-shopping-cart'>购物车</span></a></li>");
    }
    function logout() {
        window.location.href = "/customers/signOut";
        localStorage.removeItem("customerId");
        localStorage.removeItem("customer");
        localStorage.removeItem("customerId");
        localStorage.removeItem("customer");
    }
</script>