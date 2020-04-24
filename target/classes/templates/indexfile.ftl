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
        <a href="/fileback"><button class="btn btn-primary">返回上层</button></a>
    </div>
    <br>
    <br>
    <#if filelist?exists>
        <div class="panel panel-primary">
            <#list filelist as filelist>
                <div class="panel-heading">
                    <h2 class="panel-title">filelist.filename</h2>
                    <h4 class="panel-title">filelist.updatorname&nbsp;&nbsp;&nbsp;filelist.uploadtime</h4>
                    <p>filelist.fileabstract}</p>
                    <a href="${filelist.filepath}" download="${filelist.filename}">
                        <button class="btn btn-info">下载文档</button>
                    </a>
                </div>
                <div class="panel-body">
                    <#if filelist.filetype == ".doc" || filelist.filetype == ".docx">
                        <a onclick="ReadPDF('${filelist.fileid}')">
                            <img src="../static/images/word图标.png" style="height: 90px; width: 90px">
                        </a>
                        <br>
                        <button class="btn btn-link"
                                onclick="ReadPDF('${filelist.fileid}')">预览文档</button>
                    </#if>
                    <#if filelist.filetype == ".ppt" || filelist.filetype == ".pptx">
                        <a onclick="ReadPDF('${filelist.fileid}')">
                            <img src="../static/images/ppt图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${filelist.fileid}')">预览文档</button>
                    </#if>
                    <#if filelist.filetype == ".xls" || filelist.filetype == ".xlsx">
                        <a onclick="ReadPDF('${filelist.fileid}')">
                            <img src="../static/images/excel图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${filelist.fileid}')">预览文档</button>
                    </#if>
                    <#if filelist.filetype == ".pdf">
                        <a onclick="ReadPDF('${filelist.fileid}')">
                            <img src="../static/images/pdf图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${filelist.fileid}')">预览文档</button>
                    </#if>
                    <#if filelist.filetype == ".txt">
                        <a onclick="ReadPDF('${filelist.fileid}')">
                            <img src="../static/images/txt图标.png" style="height: 50px; width: 50px">
                        </a>
                        <br>
                        <button class="btn btn-link" onclick="ReadPDF('${filelist.fileid}')">预览文档</button>
                    </#if>
                    <#if filelist.filetype == ".rar" || filelist.filetype == ".zip">
                        <img src="../static/images/rar图标.png" style="height: 50px; width: 50px">
                    </#if>

                    <br>
                </div>
<#--                <div class="panel-heading">-->
<#--                    <p>filelist.fileabstract}</p>-->
<#--                </div>-->
            </#list>
        </div>
    <#else>
        <h2>对不起，当前文档未能找到！</h2>
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
            data: {fileid: fileid},
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
</script>
</body>
</html>