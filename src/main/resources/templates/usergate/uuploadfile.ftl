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
<!-- Fixed navbar -->
<#include "/header.ftl"/>
<!--header end-->

<div class="col-lg-1"></div>
<div class="col-lg-2">
    <span><h2>视频上传</h2></span>
    <h4><a href="/userdoc">返回上层</a></h4>

</div>
<div class="col-lg-6 container">
    <div class="text-info">
        <h3>温馨提示：</h3>
        <br>
        <p class="text-danger">目前支持的文档：Word，Excel，PowerPoint，PDF，TXT，压缩包文件</p>
        <p class="text-danger">文档大小提示：请不要超过50M限制</p>
    </div>
    <br>
    <h3 class="text-info">${fierror!}</h3>
    <br>
    <div class="form-group">
        <form action="/stufileupload" enctype="multipart/form-data" method="post">
            <div>
                <label class="form-inline">文档名称：</label>
                <input class="input-medium" type="text" name="filename" autocomplete="off">
            </div>
            <br>
            <div class="form-inline">
                <label>文档上传：</label>
                <input type="file" name="filemsg" accept=".doc,.docx,.ppt,.pptx,.xls,.xlsx,.pdf,.txt,.rar,.zip">
            </div>
            <br>
            <div>
                <label>视频简介：</label>
                <textarea style="width: 250px; height: 100px;"  name="fileabstract" placeholder="这里输入文档简介"></textarea>
            </div>
            <br>
            <br>
            <div class="form-inline">
                <input type="submit" value="上传" class="btn-sm btn-info">
                <button type="reset" class="btn-sm btn-danger">取消</button>
            </div>
        </form>
    </div>
</div>
<!--container end-->
<div class="col-lg-3"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>