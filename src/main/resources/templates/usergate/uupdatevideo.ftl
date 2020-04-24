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

<div class="col-lg-8">
    <div>
        <a href="/uservideo">
            <button class="btn btn-primary">返回</button>
        </a>
    </div>
    <#if videolist?exists>
    <#list videolist as videolist>
        <form action="">
            <table class="table table-hover table-striped">
                <tr>
                    <td>视频ID：</td>
                    <td><input type="text" name="videoid" value="${videolist.videoid}" disabled="disabled"></td>
                </tr>
                <tr>
                    <td>视频名：</td>
                    <td><input type="text" name="videoname" value="${videolist.videoname}"></td>
                </tr>
                <tr>
                    <td>上传时间：</td>
                    <td>${videolist.uploadtime}</td>
                </tr>
                <tr>
                    <td>最近修改时间：</td>
                    <td>${videolist.updatetime}</td>
                </tr>
                <tr>
                    <td>视频状态：</td>
                    <td>
                        <#if videolist.videostatus == 4>已通过</#if>
                        <#if videolist.videostatus == 5>待审核</#if>
                        <#if videolist.videostatus == 6>不通过</#if>
                    </td>
                </tr>
                <tr>
                    <td>视频封面：</td>
                    <td><img id="uploaded_pic"
                             src="static/${videolist.coverpath}"
                             style="width: 50px; height: 50px" alt="${videolist.videoname}">
                    </td>
                </tr>
                <tr>
                    <td>重传封面：</td>
                    <td><input type="file" onchange="imgchange(this)" name="newcover"
                               class="btn btn-warning" id="pic_upload"
                               accept=".jpg,.jpeg,.png,.gif,.bmp,.tif"></td>
                </tr>
                <tr>
                    <td>视频源：</td>
                    <td>
                        <video class="" height="500px" width="500px" controls="controls"
                                                       src="static/${videolist.videopath}">
                                                <source src="static/${videolist.videopath}" type="video/mp4">
                                                <source src="static/${videolist.videopath}" type="video/avi">
                                                <source src="static/${videolist.videopath}" type="video/blv">
                        </video>
                    </td>
                </tr>
                <tr>
                    <td>重传视频源：</td>
                    <td><input type="file" name="newvideomsg" accept=".mp4,.blv,.avi"></td>
                </tr>
                <tr>
                    <td>视频简介：</td>
                    <td>
                        <textarea name="videoabstract">${videolist.videoabstract}</textarea>
                    </td>
                </tr>
                <tr>
                    <td> </td>
                    <td>
                        <div class="btn-group">
                            <input type="submit" value="确认" class="btn btn-warning">&nbsp;
                            <a href="/uservideo"><button class="btn btn-primary">返回</button></a>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </#list>
    <#else>
        <h2 class="label-warning">对不起！暂未找到视频详情！</h2>
    </#if>
</div>

<div class="col-lg-2"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>

<script>
    //显示选择的图片
    function imgchange(obj){
        //获取点击的文本框
        var file = document.getElementById("pic_upload");
        var imgurl = window.URL.createObjectURL(file.files[0]);
        var img = document.getElementById('uploaded_pic');
        img.setAttribute('src', imgurl);//修改img标签src属性值
    };
</script>
</body>
</html>