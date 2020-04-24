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
                    <li class="active"><a href="/tologin">点此登录</a></li>
                </#if>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</nav>

<div class="col-lg-1"></div>

<div class="col-lg-2">
    <span><h2>创建论坛</h2></span>
    <h4><a href="/disback">返回上层</a></h4>
</div>
<div class="col-lg-6">
    <div class="container">
        <h3 class="text-danger">${discreateerror!}</h3>
        <br>

        <div class="form-group">
            <form action="/creatediscuss" enctype="multipart/form-data" method="post">
                <div>
                    <label class="form-inline">论坛名称：</label>
                    <input class="input-medium" type="text" name="discussname" autocomplete="off">
                </div>
                <br>
                <div>
                    <label>我要提问：</label>
                    <textarea style="width: 250px; height: 100px;"  name="discussabstract" placeholder="我的发问"></textarea>
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
</div>
<!--container end-->

<div class="col-lg-3"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>