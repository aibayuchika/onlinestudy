<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
    <!-- 引入 Bootstrap -->
    <link href="../../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
<#include "/header.ftl"/>
<!--header end-->

<div class="container-fluid col-lg-1"></div>

<div class="container-fluid col-lg-2 navbar">
    <span><h3>个人资料</h3></span>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" id="bar-1">
            <a href="/userdetail?userid=${Session.user.userid}">我的资料</a>
        </li>
        <li role="presentation" id="bar-2">
            <a href="/uservideo?userid=${Session.user.userid}">我的视频</a>
        </li>
        <li role="presentation" id="bar-3">
            <a href="/userdoc?userid=${Session.user.userid}">我的文档</a>
        </li>
        <li role="presentation" id="bar-4">
            <a href="/userdiscuss?userid=${Session.user.userid}">我的论坛</a>
        </li>
        <li role="presentation" id="bar-5">
            <a href="/userquest?userid=${Session.user.userid}">我的咨询</a>
        </li>
    </ul>
</div>
<div class="col-lg-8 container">
    <div>
        <h2>我的资料</h2>
    </div>
    <#list userlist as userlist>
        <div class="form-group">
            <label class="">我的ID：</label>
            <input type="text" name="userid" value="${userlist.userid}" class="text-left">
        </div>
        <div class="form-group">
            <label class="">我的类型：</label>
            <label>
                <#if userlist.usertype == 1>管理员</#if>
                <#if userlist.usertype == 2>二级管理员</#if>
                <#if userlist.usertype == 3>普通用户</#if>
                <#if userlist.isblack == 2>（黑名单）</#if>
            </label>
        </div>
        <div class="form-group">
            <label class="">我的名称：</label>
            <input type="text" name="username" value="${userlist.username}" disabled="disabled" class="text-left">
        </div>
        <div class="form-group">
            <label class="">我的昵称：</label>
            <input type="text" name="nickname" value="${userlist.nickname!""}" placeholder="等待补充" class="text-left">
        </div>
        <div class="form-group">
            <label class="">修改密码：</label>
            <input type="password" name="passwd" class="text-left" onchange="">
        </div>
        <div class="form-group">
            <label class="">再次输入新密码：</label>
            <input type="password" name="repasswd" class="text-left" onchange="">
        </div>
        <div class="form-group">
            <label class="">我的性别：</label>
            <label>
                <#if userlist.usersex == "male">男</#if>
                <#if userlist.usersex == "female">女</#if>
                <#if userlist.usersex == "unknown">暂不透露</#if>
            </label>
        </div>
        <div class="form-group">
            <label class="">我的邮箱：</label>
            <input type="text" name="usermail" value="${userlist.usermail!""}" placeholder="等待补充" class="text-left">
        </div>
    </#list>
    <div>
        <button class="btn btn-warning btn-sm" onclick="">确认修改</button>
    </div>
</div>
<!-- /.container -->
<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>