<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
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
<#include "/header.ftl"/>
<!--header end-->

<div class="col-lg-2"></div>

<div class="container col-lg-8">
    <div class="">
        <a href="/videoback"><button class="btn btn-primary">返回上层</button></a>
    </div>
    <br>
    <br>
    <#if videolist?exists>
    <div class="panel panel-primary">
        <#list videolist as videolist>
        <div class="panel-heading">
            <h2 class="panel-title">${videolist.videoname}</h2>
            <h4 class="panel-title">${videolist.updatorname}&nbsp;&nbsp;&nbsp;${videolist.uploadtime}</h4>
            <a href="${videolist.videopath}" download="${videolist.videoname}">
                <button class="btn btn-info">下载视频</button>
            </a>
        </div>
        <div class="panel-body">
            <video class="" height="600px" width="600px" controls="controls" src="static/${videolist.videopath}">
                <source src="static/${videolist.videopath}" type="video/mp4">
                <source src="static/${videolist.videopath}" type="video/avi">
                <source src="static/${videolist.videopath}" type="video/blv">
            </video>
            <br>
            <br>
        </div>
        <div class="panel-heading">
            <p>${videolist.videoabstract}</p>
        </div>
        </#list>
    </div>
    <#else>
        <h2>对不起，当前视频未能找到！</h2>
    </#if>
</div>

<div class="col-lg-2"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>