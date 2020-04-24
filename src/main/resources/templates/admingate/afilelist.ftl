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
            <li class="layui-nav-item"><a href="">退了</a></li>
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
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="/adminfile">文件管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/adminfile">所有文档</a></dd>
                        <dd><a href="/adminfile?filestatus=4">已通过文档</a></dd>
                        <dd><a href="/adminfile?filestatus=5">待审核文档</a></dd>
                        <dd><a href="/adminfile?filestatus=6">已拒绝文档</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
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
            <span><h2>文档管理</h2></span>
        </div>
        <div style="padding: 15px;">
            <div class="layui-form">
                <form class="layui-form" action="/adminsearchfile">
                    <div class="layui-input-inline">
                        <input type="text" name="filename" placeholder="输入文档名称" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>
                <a href="/toadminfileupload"><button class="layui-btn layui-btn-xs">上传文档</button></a>
                <form action="/adminfile">
                    <input type="submit" class="layui-btn layui-btn-xs" value="刷新">
                </form>
            </div>
        </div>
        <!--文档信息-->
        <ul>
        <#list filelist as filelist>
            <li>
                <dl>
                    <dd>
                        <a href="/adminfiledetails?fileid=${filelist.fileid}">
                            <#if filelist.filetype==1><img src="../../static/images/word图标.png" alt="${filelist.filename}"></#if>
                            <#if filelist.filetype==2><img src="../../static/images/excel图标.png" alt="${filelist.filename}"></#if>
                            <#if filelist.filetype==3><img src="../../static/images/ppt图标.png" alt="${filelist.filename}"></#if>
                            <#if filelist.filetype==4><img src="../../static/images/rar图标.png" alt="${filelist.filename}"></#if>
                            <#if filelist.filetype==5><img src="../../static/images/pdf图标.png" alt="${filelist.filename}"></#if>
                            <#if filelist.filetype==6><img src="../../static/images/txt图标.png" alt="${filelist.filename}"></#if>
                        </a>
                    </dd>
                    <dt>
                        <p class="layui-form-item">${filelist.filename}</p>
                        <p class="layui-form-item" style="color: red;">${filelist.status}</p>
                        <p class="layui-form-item">${filelist.uploadtime}</p>
                        <p class="layui-form-item"><a href="/adminfiledetails?fileid=${filelist.fileid}">点击详情</a></p>
                    </dt>
                </dl>
            </li>
        </#list>
        </ul>
        <!--分页开始-->
        <div class="layui-laypage">
            <#if page.current lte 1>
                <span>首页</span>
                <span class="layui-laypage-prev">&laquo;</span>
                <span>${page.current}/${page.pages}</span>
            <#else>
                <a href="/video?toPage=0">首页</a>
                <a href="/video?toPage=${page.current-1}" class="layui-laypage-prev">&laquo;</a>
                <span>${page.current}/${page.pages}</span>
            </#if>
            <#--        <div class="pagination-lg">-->
            <#--            <span>${page.current}/${page.pages}</span>-->
            <#--        </div>-->
            <#if page.current gte page.pages>
                <span class="layui-laypage-next">&raquo;</span>
                <span>尾页</span>
            <#else>
                <a href="/video?toPage=${page.current+1}" class="layui-laypage-next">&raquo;</a>
                <a href="/video?toPage=${page.pages-1}">尾页</a>
            </#if>
        </div>
        <!--分页结束-->
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
    //打开上传文件窗口
    function uploadchart(obj) {
        layer.open({
            type: 1,
            title: "上传文档",
            area: ['500px', '500px'],
            offset: 'auto',
            content: $("#uploadfile")
        });
    }
    //删除文档的ajax
    function deleteFile(fileid) {
        alert("正在删除"+fileid+"的视频");
        $.ajax({
            url: "/adminway/delfilebyid",
            async: true,
            type: "post",
            data: {
                fileid: fileid
            },
            success: function () {
                alert("删除成功！");
                window.location.reload();
            },
            error: function () {
                alert("删除失败！");
                window.location.reload();
            }
        });
    }
    //发布文档的ajax
    function confirmFile(fileid) {
        alert("正在发布"+fileid+"的视频");
        $.ajax({
            url: "/adminway/confirmfile",
            async: true,
            type: "post",
            data: {
                fileid: fileid
            },
            success: function () {
                alert("发布成功！");
                window.location.reload();
            },
            error: function () {
                alert("发布失败！");
                window.location.reload();
            }
        });
    };
</script>
</body>
</html>