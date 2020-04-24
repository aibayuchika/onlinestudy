<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <!-- 引入 Bootstrap -->
    <link href="../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 Shiv 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
    <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    [endif]-->
    <style type="text/css">

    </style>
</head>
<body>
<div class="container">
    <!--左上角标题-->
    <h2>Online Study</h2>
    <h4><a href="" >游客进入</a></h4>
    <!--标题结束-->
    <div class="row">
        <!--登录框-->
        <div class="col-md-3"></div>

        <div class="col-md-6" style="background: ">
            <form action="/loginAction">
                <table class="table table-hover">
                    <caption>欢迎登录，还没注册？<a href="">点我注册</a></caption>
                    <tr>
                        <td>${loginerrormsg!""}</td>
                    </tr>
                    <tr>
                        <td>帐号：</td>
                        <td><input type="text" class="" id="userid" name="userid" onchange="checkID()"></td>
                        <td><span id="id_error"></span></td>
                    </tr>
                    <tr>
                        <td>密码：</td>
                        <td><input type="password" class="" id="passwd" name="passwd" onchange="checkPass()"></td>
                        <td><span id="pass_error"></span></td>
                    </tr>
                    <tr>
                        <td>
    <#--                        <button id="loginbtn" class="btn" onclick="login()">LOGIN</button>-->
                            <input type="submit" class="btn" value="LOGIN"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <!--登陆框结束-->

        <div class="col-md-3"></div>
    </div>

</div>
<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function checkID() {
        var id = $("#userid").val();
        if(id === ''){
            $("#id_error").html("用户名不能为空");
            $("#id_error").css("color", "#oranged");
        }else {
            $("#id_error").html("");
            $("#id_error").css("color", "");
        }
    }
    function checkPass() {
        var id = $("#passwd").val();
        if(id === ''){
            $("#pass_error").html("密码不能为空");
            $("#pass_error").css("color", "#oranged");
        }else {
            $("#pass_error").html("");
            $("#pass_error").css("color", "");
        }
    }
    function login() {
        var userid = $("#userid").val();
        var passwd = $("#passwd").val();
        if(userid === '' || passwd === ''){
            alert("帐号或密码不能为空！");
            return ;
        }else {
            $.ajax({
                url: "/loginAction",
                method: "post",
                data: {
                    "userid": userid,
                    "passwd": passwd
                },
                success: function () {
                    alert("登录成功，正在跳转！");
                    // window.open("/index");
                    window.location.reload();
                },
                error: function () {
                    alert("账号或密码错误");
                }
            });
        }
    }
</script>
</body>
</html>