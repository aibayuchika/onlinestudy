<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>视频详情</title>
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
                <li class="layui-nav-item  layui-nav-itemed">
                    <a href="javascript:;">视频管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/adminvideolist">所有视频</a></dd>
                        <dd><a href="/adminvideolist?filestatus=4">已通过视频</a></dd>
                        <dd><a href="/adminvideolist?filestatus=5">待审核视频</a></dd>
                        <dd><a href="/adminvideolist?filestatus=6">已拒绝视频</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="/adminfile">文件管理</a>
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
            <span><h2>视频管理</h2></span>
        </div>
        <div style="padding: 15px;">
            <div class="layui-form">
                <form action="/adminvideolist">
                    <input type="submit" class="layui-btn" value="返回上层">
                </form>
            </div>
        </div>
        <#list videolist as videolist>
        <!--视频信息-->
        <div class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">视频id：${videolist.videoid}</label>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">视频名称：${videolist.videoname}</label>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">上传者：${videolist.updator}</label>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">上传时间：${videolist.uploadtime}</label>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">
                    操作项：<button class="layui-btn layui-btn-xs" id="videoconfirmbtn">发布</button>
                    <button class="layui-btn-xs layui-btn"
                            onclick="var a = document.getElementById('givefailreason');
                                   a.hidden = false;
                                   <#--a.childNodes[0].value = ${videolist.getVideoid()}-->
                                    ">拒绝</button>
                </label>
            </div>
            <!--视频不通过表格-->
            <form action="#" class="layui-form" id="givefailreason" hidden>
                <div class="layui-form-item">
                    <label class="layui-form-label">视频id：</label>
                    <div class="layui-input-block">
                        <input name="videoid" value="${videolist.getVideoid()}" type="hidden">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">不通过理由：</label>
                    <div class="layui-input-block">
                        <textarea name="failreason" class="layui-textarea" autocomplete="off"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-xs" id="failvideobtn">确认</button>
                        <button class="layui-btn layui-btn-xs" onclick="document.getElementById('givefailreason').hidden=true">取消</button>
                    </div>
                </div>
            </form>

            <div class="layui-form-item">
                <video class="" height="600px" width="600px" controls="controls" src="static/${videolist.videopath}">
                    <source src="static/${videolist.videopath}" type="video/mp4">
                    <source src="static/${videolist.videopath}" type="video/avi">
                    <source src="static/${videolist.videopath}" type="video/blv">
                </video>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">视频简介：</label>
                <label class="layui-form-label">${videolist.videoabstract}</label>
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
    //插入不通过理由的ajax
    $("#failvideobtn").click(function () {
        alert("正在修改");
        $.ajax({
            url: "/adminway/failvideo",
            data: $("#givefailreason").serialize(),
            type: "post",
            success: function () {
                alert("该视频已为不通过");
                window.location.reload();
            },
            error: function () {
                alert("修改失败");
            }
        });
    });
    //发布视频的ajax
    function confirmVideo(videoid) {
        alert("正在发布"+videoid+"的视频");
        $.ajax({
            url: "/adminway/confirmvideo",
            async: true,
            type: "post",
            data: {
                videoid: videoid
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
    }
</script>

</body>
</html>