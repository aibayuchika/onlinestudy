<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册用户</title>
    <!-- 引入 Bootstrap -->
    <link href="../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 Shiv 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
    <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    [endif]-->
    <style>
        body{
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>
</head>
<body>
<!--header start-->
<#--<#include "/header.ftl"/>-->
<!--header end-->

<div class="container">
    <div class="col-md-2"></div>

    <div class="col-md-8">
        <div class="col-lg-3">
            <a href="/tologin">
                <button class="btn btn-sm btn-primary">返回登录</button>
            </a>
            <button class="btn btn-primary btn-sm">直接进入主页</button>
        </div>
        <br>
        <div class="">
            <form action="">
                <table class="table table-striped table-hover">
                    <tr>
                        <td>现在开始注册吧！</td>
                    </tr>
                    <tr>
                        <td><font color="#ff4500">*号表示必填</font></td>
                    </tr>
                    <tr>
                        <td><font color="#ff4500">*</font>您的名字：</td>
                        <td>
                            <input type="text" class="text-left" name="username" id="username"
                                   placeholder="输入您的姓名" autocomplete="off"
<#--                                   onkeyup="checkName()" -->
                                   maxlength="20" required>
                        </td>
                        <td>
                            <span id="usernameerror"></span>
                        </td>
                    </tr>
                    <tr>
                        <td><font color="#ff4500">*</font>您的手机：</td>
                        <td>
                            <input type="tel" class="text-left" name="userid" id="userid"
                                   placeholder="请输入手机号" autocomplete="off" required
                                   onkeyup="checkPhone()" maxlength="11">
                        </td>
                        <td><span id="phoneerror"></span></td>
                    </tr>
                    <tr>
                        <td>您的昵称：</td>
                        <td>
                            <input type="text" class="text-left" name="nickname" id="nickname"
                                   placeholder="输入您的昵称" autocomplete="off"
                                   maxlength="20">
                        </td>
                        <td><font color="#ff4500">*若不填写，则默认姓名为昵称</font></td>
                    </tr>
                    <tr>
                        <td><font color="#ff4500">*</font>您的性别：</td>
                        <td>
                            <input type="radio" id="usersex" name="usersex" value="male">男&nbsp;
                            <input type="radio" id="usersex" name="usersex" value="female">女&nbsp;
                            <input type="radio" id="usersex" name="usersex" value="unknown" checked>暂不透露
                        </td>
                    </tr>
                    <tr>
                        <td><font color="#ff4500">*</font>您的密码：</td>
                        <td>
                            <input type="password" class="text-left" name="passwd" id="passwd"
                                   placeholder="输入 6 - 18 位密码" autocomplete="off"
                                   minlength="6" maxlength="18" required
<#--                                   onkeyup="checkPasswd()"-->
                            >
                        </td>
                        <td><span id="passwderror"></span></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="password" class="text-left" name="repasswd" id="repasswd"
                                   placeholder="再次输入密码" autocomplete="off"
                                   minlength="6" maxlength="18" required onkeyup="checkrePasswd()">
                        </td>
                        <td><span id="passtips"></span></td>
                    </tr>
                    <tr>
                        <td>您的邮箱：</td>
                        <td>
                            <input type="email" class="text-left" name="email" id="email"
                                   placeholder="请输入邮箱" autocomplete="off"
<#--                                   onkeyup="checkMail()"-->
                            >
                        </td>
                        <td><span id="mailerror"><font color="green">邮箱可选填</font></span></td>
                    </tr>
                    <tr>
                        <td>
                            <button class="btn btn-primary btn-sm" id="registbtn"
                                    onclick="" disabled>注册</button>
                        </td>
                        <td>
                            <button class="btn btn-warning btn-sm" type="reset">重置</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

    <div class="col-md-2"></div>
</div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../static/bootstrap/js/bootstrap.min.js"></script>

<script>
    function regist() {
        var username = $("#username").val();
        var userid = $("#userid").val();
        var nickname = $("#nickname").val();
        var usersex = $("input[name='usersex']:checked").val();
        var passwd = $("#passwd").val();
        var email = $("#email").val();

        if(username == '' || userid == '' || passwd == ''){
            alert("请检查下是否有地方遗漏未填");
            return;
        }else {
            $.ajax({
                url: "/userregist",
                method: "post",
                data: {
                    "username": username,
                    "userid": userid,
                    "nickname": nickname,
                    "usersex": usersex,
                    "passwd": passwd,
                    "email": email
                },
                success: function (responseText) {
                    if(responseText == "registSuccess"){
                        alert("注册成功，正在跳转登录页面！");
                        window.location.assign("localhost:8080/tologin");
                    }
                },
                error: function (responseText) {
                    if(responseText == "useriderror"){
                        alert("用户id或已被zhu'ce");
                    }
                    if(responseText == "registFail"){
                        alert("注册失败，请检查信息是否有误");
                        return;
                    }
                }
            });
        }
    }

function checkrePasswd() {
    var pwd = $("#passwd").val();
    var repwd = $("#repasswd").val();
    if(pwd == repwd){
        $("#passtips").html("两次密码相同");
        $("#passtips").css("color", "green");
        $("#registbtn").attr("disabled", "false");
    }else {
        $("#passtips").html("两次密码不同");
        $("#passtips").css("color", "#ff4500");
        // $('#registbtn').attr('disabled',"true");
    }
}
function checkName() {
    var uname = $("#username").val();
    if(uname == ''){
        // uname = uname.replace(/[\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.\_]/g);
        // $("#username").val(uname);
        $("#usernameerror").html("姓名不能为空！");
        $("#usernameerror").css("color", "#ff4500");
    }else {
        $("#usernameerror").html("*请务必填写真实姓名");
        $("#usernameerror").css("color", "#ff4500");
    }
}
function checkPasswd() {
    var pwd = $("#passwd").val();
    if(pwd == ''){
        $("#passwderror").html("密码不能为空！");
        $("#passwderror").css("color", "#ff4500");
    }else {
        if(pwd.length < 6){
            // pwd = pwd.replace(/^[\a-\z\A-Z0-9\@\.\_]/g);
            // $("#passwd").val(pwd);
            $("#passwderror").html("密码少于6位！");
            $("#passwderror").css("color", "#ff4500");
        }else {
            // pwd = pwd.replace(/[^\a-\z\A-Z0-9\@\.\_]/g);
            // $("#passwd").val(pwd);
            $("#passwderror").html("*请输入6-18位密码（包含数字英文.@_）");
            $("#passwderror").css("color", "green");
        }
    }
}
function checkPhone() {
    var phone = $("#userid").val();
    if(phone == ''){
        $("#phoneerror").html("手机号不能为空！");
        $("#phoneerror").css("color", "#ff4500");
    }else {
        if(phone.length < 11 || phone.length > 11){
            // phone = phone.replace(/^1[3-9]\d{9}$/g);
            // $("#userid").val(phone);
            $("#phoneerror").html("请正确输入11位手机号！");
            $("#phoneerror").css("color", "#ff4500");
        }else {
            // phone = phone.replace(/^1[3-9]\d{9}$/g);
            // $("#userid").val(phone);
            $("#phoneerror").html("请务必确认手机号是否填错");
            $("#phoneerror").css("color", "green");
        }
    }
}
// function checkMail() {
//     var mail = $("#email").val();
//     if(mail == ''){
//         $("#mailerror").html("邮箱可选填");
//         $("#mailerror").css("color", "green");
//     }else {
//         mail = mail
//             .replace(/^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$/g);
//         $("#email").val(mail);
//         $("#mailerror").html("邮箱可选填");
//         $("#mailerror").css("color", "green");
//     }
// }
</script>
</body>
</html>