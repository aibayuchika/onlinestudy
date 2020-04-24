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
            <li class="layui-nav-item"><a href="">教师平台</a></li>
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
                    <a href="/adminindex">用户管理</a>
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
                <form class="layui-form" action="/adminsearchannounce">
                    <div class="layui-input-inline">
                        <input type="text" name="userid" placeholder="输入发布者id" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>
                <button class="layui-btn layui-btn-xs" onclick="uploadchart()">上传公告</button>
                <form action="/adminannounce">
                    <input type="submit" class="layui-btn layui-btn-xs" value="刷新">
                </form>
            </div>
        </div>
        <!--公告信息-->
        <table>
            <thead>
            <th>公告时间</th>
            <th>公告标题</th>
            <th>上传者</th>
            <th>操作</th>
            </thead>
            <tbody>
            <#list announcelist as alist>
                <tr>
                    <td>${alist.announcetime}</td>
                    <td><a href="/adminannouncedetail?annouceid=${alist.announceid}">
                            ${alist.announcename}</a></td>
                    <td>${alist.announcer}</td>
                    <td><button class="layui-btn layui-btn-xs" id="deletebtn" onclick="deleteAnnounce(${alist.announceid})">删除公告</button></td>
                </tr>
            </#list>
            </tbody>
        </table>
        <!--翻页开始-->
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
        <!--翻页结束-->
    </div>
</div>

<!--新增表格-->
<div class="layui-table-body" id="uploadannounce" style="display: none;">
    <form method="post" id="announcement" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">公告标题</label>
            <div class="layui-input-inline shortInput">
                <input type="text" name="announcename" required autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">公告内容</label>
            <div class="layui-input-block">
                <textarea name="announcemsg" class=""></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="announceupbtn">上传</button>
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
    //打开上传上传窗口
    function uploadchart(obj) {
        layer.open({
            type: 1,
            title: "上传公告",
            area: ['500px', '500px'],
            offset: 'auto',
            content: $("#uploadannounce")
        });
    }
    //删除文档的ajax
    function deleteAnnounce(announceid) {
        alert("正在删除"+announceid+"的公告");
        $.ajax({
            url: "/adminway/delannouncebyid",
            async: true,
            type: "post",
            data: {
                announceid: announceid
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
    //发布公告的ajax
    $("#announceupbtn").click(function () {
        alert("发布中");
        $.ajax({
            url: "/adminway/addannounce",
            data: $("#announcement").serialize(),
            type: "post",
            success: function () {
                alert("发布成功");
                window.location.reload();
            },
            error: function () {
                alert("发布失败");
            }
        });
    });
</script>
</body>
</html>