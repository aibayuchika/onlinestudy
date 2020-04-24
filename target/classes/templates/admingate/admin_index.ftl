<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>管理界面</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="../../static/layui/layui.js"></script>
    <script src="../../static/jquery/jquery.1.8.3.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!--header start-->
    <#include "/admin_header.ftl"/>
    <!--header end-->

    <!--侧边菜单开始-->
    <#include "/admin_sidebar.ftl"/>
    <!--侧边菜单结束-->

    <!--main part start-->
    <div class="layui-body">
        <div class="" align="center">
            <h2>欢迎来到管理员界面！</h2>
            <br>
            <br>
            <h3>当前还有以下事情代办：</h3>
            <br>
            <h4 style="color: #b94a48">视频未审核：${video_num!0}份&nbsp;&nbsp;&nbsp;文档未审核：${doc_num}份</h4>
            <a href="/admin_ziliao" style="color: darkorchid">点此进入审核界面</a>
        </div>
    </div>
    <!--main part end-->
</div>

<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    layui.use('layer', function(){
        var layer = layui.layer;

    });
    layui.use('form',function () {
        var form = layui.form;
        form.render();

    });
</script>
</body>
</html>