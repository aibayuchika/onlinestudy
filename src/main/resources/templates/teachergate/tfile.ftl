<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>教师管理界面</title>
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
        <div class="layui-logo">TEACHER PAGE</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
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
                <li class="layui-nav-item"><a href="">退出</a></li>
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
                    <a href="/">我的班级</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">我的文档</a>
                    <dl class="layui-nav-child">
                        <dd><a>我的文档</a></dd>
                        <#list userstatus as userstatus>
                            <dd><a href="?userstatus=${userstatus.statusid}">学生${userstatus.statusname}</a></dd>
                        </#list>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="/">我的视频</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/">我的论坛</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/">我的公告</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/">我的留言箱</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>我的文档</h2></span>
        </div>
        <div style="padding: 12px;">
            <div class="layui-form">
                <form class="layui-form" action="/">
                    <div class="layui-input-inline">
                        <input type="text" name="userid" placeholder="输入学生号" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>

                <form action="/">
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
    </div>
    <!--新增表格-->
    <div class="layui-table-body" id="uploadfile" style="display: none;">
        <form enctype="multipart/form-data" method="post" id="fileupload" class="layui-form" action="/adminway/uploadvideo">
            <div class="layui-form-item">
                <label class="layui-form-label">文档名称</label>
                <div class="layui-input-inline shortInput">
                    <input type="text" name="filename" required autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">文档上传</label>
                <div class="layui-input-inline">
                    <input type="file" accept=".doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt,.rar,.zip,.pdf" name="filemsg" class="layui-upload-button">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">文档简介</label>
                <div class="layui-input-block">
                    <textarea name="fileabstract" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="submit" value="上传" class="layui-btn">
                    <button type="reset" class="layui-btn layui-btn-primary">取消</button>
                </div>
            </div>
        </form>
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