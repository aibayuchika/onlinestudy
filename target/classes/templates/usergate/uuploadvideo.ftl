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
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Home Page</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="/toindex">主页</a></li>
                <li><a href="/file">文档</a></li>
                <li><a href="/video">视频</a></li>
                <li><a href="/discuss">论坛</a></li>
                <#if Session["user"]?exists>
                    <#if Session.user.usertype == 2>
                        <li><a href="">教师后台</a></li>
                    <#else>

                    </#if>
                </#if>
            </ul>
            <form class="navbar-form navbar-left">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="搜索视频或文档">
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <#if Session["user"]?exists>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            Hi！${Session.user.username}
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/userdetail">我的界面</a></li>
                            <li><a href="/logout">退出登录</a></li>
                            <li><a href="#">One more separated link</a></li>
                        </ul>
                    </li>
                <#else>
                    <li class="active"><a href="">点此登录</a></li>
                </#if>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</nav>
<div class="col-lg-1"></div>
<div class="col-lg-2">
    <span><h2>视频上传</h2></span>
    <h4><a href="/uservideo">返回上层</a></h4>

</div>
<div class="col-lg-6 container">
    <div class="text-info">
        <h3>温馨提示：</h3>
        <br>
        <p class="text-danger">目前对封面的要求：格式仅支持jpg，jpeg，png格式的图片</p>
        <p class="text-danger">目前对视频的要求：格式仅支持mp4，avi，blv格式的视频，大小请控制在1G以内</p>
    </div>
    <br>
    <div class="form-group">
        <form action="/useruploadvideo" enctype="multipart/form-data" method="post">
            <div>
                <label class="form-inline">视频名称：</label>
                <input class="input-medium" type="text" name="videoname" autocomplete="off">
            </div>
            <br>
            <div>
                <label>视频封面：<img id="uploaded_pic" src="../../static/images/default.png" style="width: 200px; height: 200px;"/></label>
                <input onchange="imgchange(this)" type="file" id="pic_upload" name="cover"
                       accept=".jpg,.jpeg,.png,.gif,.bmp,.tif">
            </div>
            <br>
            <div class="form-inline">
                <label>视频上传：</label>
                <input type="file" name="videomsg" accept=".mp4,.blv,.avi">
            </div>
            <br>
            <div>
                <label>视频简介：</label>
                <br>
                <textarea style="width: 250px; height: 100px;" name="videoabstract" placeholder="这里输入视频简介"></textarea>
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