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
    <!--header start-->
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
    <!--header end-->
    <!--body start-->
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>文档上传</h2></span>
            <a href="/adminfile">返回上层</a>
            <span><font color="red">${fierror!}</font></span>
        </div>
    </div>
    <!--body end-->
    <!--新增表格-->
    <div class="layui-table-body" id="uploadfile" style="display: none;">
        <form enctype="multipart/form-data" method="post" id="fileupload" class="layui-form" action="/adminfileupload">
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
</script>
</body>
</html>