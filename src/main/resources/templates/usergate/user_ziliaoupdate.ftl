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

<div class="col-lg-3"></div>
<!--body start-->
<div class="container col-lg-6">
    <div>
        <span><h2>资料修改</h2></span>
        <span><a href="/userdoc"><button class="btn btn-warning btn-sm">返回上层</button></a></span>
    </div>
    <br>
    <div>
        <span></span>
    </div>
    <div>
        <#if ziliaolist?exists>
            <#list ziliaolist as ziliaolist>
                <table class="table table-striped table-hover">
                    <caption>
                        <h2 style="color: red">${update_msg!""}</h2>
                    </caption>
                    <tr>
                        <td>资料名称：</td>
                        <td><input type="text" name="ziliaoname" id="ziliaoname"
                                   value="${ziliaolist.ziliaoname}" class="text-left"></td>
                    </tr>
                    <tr>
                        <td>资料上传时间：</td>
                        <td>${ziliaolist.ziliaouploadtime}</td>
                    </tr>
                    <tr>
                        <td>上次修改时间：</td>
                        <td>${ziliaolist.ziliaoupdatetime}</td>
                    </tr>
                    <tr>
                        <td>资料tag：</td>
                        <td>${ziliaolist.ziliaotag}</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <select style="height: 30px;width: 50px">
                                <option value="0" selected>-----</option>
                                <option value="1">Java</option>
                                <option value="2">语文</option>
                            </select>
                        </td>
                    </tr>
                    <#if ziliaolist.ziliaotype == 1>
                        <tr>
                            <td>资料封面：</td>
                            <td>
                                <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </td>
                        </tr>
                    </#if>
                    <tr>
                        <#if ziliaolist.ziliaotype == 1>
                            <td>
                                <video class="" height="600px" width="600px" controls="controls" src="static/${ziliaolist.ziliaosourcepath}">
                                    <source src="static/${ziliaolist.ziliaosourcepath}" type="video/mp4">
                                    <source src="static/${ziliaolist.ziliaosourcepath}" type="video/avi">
                                    <source src="static/${ziliaolist.ziliaosourcepath}" type="video/blv">
                                </video>
                            </td>
                        </#if>
                        <td>
                            <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                                <img src="../../static/images/word图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                                <img src="../../static/images/excel图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                                <img src="../../static/images/ppt图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".txt">
                                <img src="../../static/images/txt图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".pdf">
                                <img src="../../static/images/pdf图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                                <img src="../../static/images/rar图标.png" style="width: 200px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                            </#if>
                        </td>
                    </tr>
                    <tr>
                        <td>资料简介：</td>
                        <td>
                            <textarea name="videoabstract">${videolist.videoabstract}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="ziliao_up_btn" class="btn btn-sm btn-warning"
                                    onclick="">确认修改</button>
                        </td>
                    </tr>
                </table>
            </#list>
        <#else>
            <h2>对不起，暂时未能找到该资料信息</h2>
        </#if>
    </div>
</div>
<div class="col-lg-3"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>

<script>
    function updateZiliao() {
        var ziliaoname = $("#ziliaoname").val();
    }
</script>
</body>
</html>