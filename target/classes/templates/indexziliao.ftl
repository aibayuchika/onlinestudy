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
    <#if ziliaolist?exists>
        <div class="panel panel-primary">
            <#list ziliaolist as ziliao>
                <div class="panel-heading">
                    <h2 class="panel-title">
                        <#if ziliao.ziliaotype == 1>
                            【视频】${ziliao.ziliaoname}
                        </#if>
                        <#if ziliao.ziliaotype == 2>
                            【文档】${ziliao.ziliaoname}
                        </#if>
                    </h2>
                    <h4 class="panel-title">
                        ${ziliao.ziliaoupdatorname}&nbsp;&nbsp;&nbsp;${ziliao.ziliaouploadtime}
                        &nbsp;&nbsp;&nbsp;${ziliao.ziliaotag}
                    </h4>
                    <a href="${ziliao.ziliaosourcepath}" download="${ziliao.ziliaoname}">
                        <button class="btn btn-info">下载资料</button>
                    </a>
                    <br>
                    <div class="btn-group">
                        <h4 style="color: darkorange">${dian_msg!""}</h4>
                        <button class="btn btn-xs btn-primary" id="zan_btn" onclick="">
                            赞（${ziliao.ziliaozan}）</button>
                        &nbsp;&nbsp;
                        <button class="btn btn-xs btn-primary" id="tan_btn" onclick="">
                            弹（${ziliao.ziliaotan}）</button>
                    </div>
<#--                    <#if ziliao.ziliaotype == 2>-->
<#--                    </#if>-->
                </div>
                <div class="panel-body">
                    <#if ziliao.ziliaotype == 1>
                        <video class="" height="600px" width="600px" controls="controls" src="static/${ziliao.ziliaosourcepath}">
                            <source src="static/${ziliao.ziliaosourcepath}" type="video/mp4">
                            <source src="static/${ziliao.ziliaosourcepath}" type="video/avi">
                            <source src="static/${ziliao.ziliaosourcepath}" type="video/blv">
                        </video>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".doc" || ziliao.ziliaosuffix == ".docx">
                        <a onclick="ReadPDF('${ziliao.ziliaoid}')">
                            <img src="../static/images/word图标.png" style="height: 90px; width: 90px">
                        </a>
                        <br>
                        <button class="btn btn-link"
                                onclick="ReadPDF('${ziliao.ziliaoid}')">预览文档</button>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".ppt" || ziliao.ziliaosuffix == ".pptx">
                        <a onclick="ReadPDF('${ziliao.ziliaoid}')">
                            <img src="../static/images/ppt图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${ziliao.ziliaoid}')">预览文档</button>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".xls" || ziliao.ziliaosuffix == ".xlsx">
                        <a onclick="ReadPDF('${ziliao.ziliaoid}')">
                            <img src="../static/images/excel图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${ziliao.ziliaoid}')">预览文档</button>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".pdf">
                        <a onclick="ReadPDF('${ziliao.ziliaoid}')">
                            <img src="../static/images/pdf图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${ziliao.ziliaoid}')">预览文档</button>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".txt">
                        <a onclick="ReadPDF('${ziliao.ziliaoid}')">
                            <img src="../static/images/txt图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${ziliao.ziliaoid}')">预览文档</button>
                    </#if>
                    <#if ziliao.ziliaosuffix == ".rar" || filelist.filetype == ".zip">
                        <img src="../static/images/rar图标.png" style="height: 50px; width: 50px">
                        <a href="${ziliao.ziliaosourcepath}" download="${ziliao.ziliaoname}">
                            <button class="btn btn-link">下载资料</button>
                        </a>
                    </#if>
                    <br>
                    <br>
                </div>
                <div class="panel-heading">
                    <p>${ziliao.ziliaoabstract}</p>
                </div>
            </#list>
        </div>
    <#else>
        <h2>对不起，当前资料未能找到！</h2>
    </#if>
</div>

<div class="col-lg-2"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../static/bootstrap/js/bootstrap.min.js"></script>

<script>
    function ReadPDF(fileid) {
        $.ajax({
            type: 'post',
            async: false,
            url: "/detailsearch",
            data: {ziliaoid: fileid},
            success: function (responseText) {
                if(responseText == "success"){
                    window.open("static/toPdf/web/viewer.html?file=/filedetail");
                }
            },
            error: function () {
                alert("读取失败");
            }
        });
    }

    function dianzan(ziliaoid) {
        $.ajax({
           type: 'post',
           async: true,
           url: "/ziliaodianzan",
           data:{
               ziliaoid: ziliaoid
            },
            success: function () {
                alert("点赞成功！上传者会感谢你的点赞的！");
                window.location.reload();
            },
            error: function () {
                alert("点赞失败！");
                window.location.reload();
            }
        });
    }

    function diantan(ziliaoid) {
        $.ajax({
            type: 'post',
            async: true,
            url: "/ziliaodiantan",
            data:{
                ziliaoid: ziliaoid
            },
            success: function () {
                alert("点弹成功！上传者会感谢你的鞭策的！");
                window.location.reload();
            },
            error: function () {
                alert("点弹失败！");
                window.location.reload();
            }
        });
    }
</script>
</body>
</html>