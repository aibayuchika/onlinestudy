<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文档详情</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="../../static/layui/layui.js"></script>
    <script src="../../static/jquery/jquery.1.8.3.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">ADMIN PAGE</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/toindex">主页</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <#if Session["user"]?exists>
                <li class="layui-nav-item">
                    <a href="javascript:;">Hi！${Session.user.username}！</a>
                    <dl class="layui-nav-child">
                        <dd><a href="">基本资料</a></dd>
                        <dd><a href="">安全设置</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="/logout">退了</a></li>
            <#else>
                <li class="layui-nav-item">
                    <a href="/tologin">先去登录吧</a>
                </li>
            </#if>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item">
                    <a class="" href="/adminindex">用户管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/adminvideolist">视频管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/adminfile">文档管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="/adminannounce">公告管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/admindiscuss">论坛管理</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>公告管理</h2></span>
        </div>
        <div style="padding: 15px;">
            <div class="layui-form">
                <form action="/adminannounce">
                    <input type="submit" class="layui-btn" value="返回上层">
                </form>
            </div>
        </div>
        <#list announcelist as alist>
            <!--公告详情信息-->
            <div class="layui-form">
                <div class="layui-form-item">
                    <h2>${alist.announcename}</h2>
                    <p>${alist.announcer}&nbsp;&nbsp;${alist.announcetime}</p>
                </div>
                <div class="layui-form-item">
                    <p>${alist.announcemsg}</p>
                </div>
            </div>
        </#list>
    </div>
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