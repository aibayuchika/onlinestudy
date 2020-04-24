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
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">我的班级</a>
                    <dl class="layui-nav-child">
                        <dd><a href="">所有学生</a></dd>
                        <#list userstatus as userstatus>
                            <dd><a href="?userstatus=${userstatus.statusid}">${userstatus.statusname}</a></dd>
                        </#list>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="/">我的文档</a>
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
            <span><h2>我的学生</h2></span>
        </div>
        <div style="padding: 12px;">
            <div class="layui-form">
                <form class="layui-form" action="/">
                    <div class="layui-input-inline">
                        <input type="text" name="userid" placeholder="输入学生号" autocomplete="off" class="layui-input">
                        <input type="text" name="username" placeholder="输入学生姓名" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>

                <form action="/">
                    <input type="submit" class="layui-btn layui-btn-xs" value="刷新">
                </form>

            </div>
        </div>
        <!--用户信息-->
        <table class="layui-table">
            <thead>
            <tr>
                <th>学生账号</th>
                <th>学生名称</th>
                <th>发布论坛数</th>
                <th>上传视频数</th>
                <th>学生邮箱</th>
                <th>操作项</th>
            </tr>
            </thead>
            <tbody class="">
            <#list userlist as userlist>
                <tr>
                    <td valign="middle" align="center">${userlist.userid}</td>
                    <td valign="middle" align="center">${userlist.username}</td>
                    <td valign="middle" align="center">${userlist.userpass}</td>

                    <td valign="middle" align="center"></td>
                    <td valign="middle" align="center">${(userlist.usermail)!}</td>
                    <td>
                        <button class="layui-btn layui-btn-xs"
                                onclick="var a = document.getElementById('passwdform');
                                        a.hidden = false;
                                        a.childNodes[1].value = ${userlist.userid};">
                            修改密码
                        </button>
                        <button class="layui-btn layui-btn-xs" id="userdelbtn" href="javascript:void(0)" onclick="deleteUser(${userlist.userid})">
                            删除用户
                        </button>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
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
    //打开注册用户窗口
    function registuser() {
        layer.open({
            type: 1,
            title: "注册用户",
            area: ['500px', '500px'],
            offset: 'auto',
            content: $("#register")
        });
    }
    //注册用户的ajax
    $("#regist").click(function () {
        alert("用户注册中，请稍等");
        $.ajax({
            url: "/adminway/adduser",
            data: $("#adduserForm").serialize(),
            type: "post",
            success: function () {
                alert("注册成功！正在刷新页面！");
                window.location.reload();
            },
            error: function () {
                alert("注册失败！该帐号或已被注册！");
            }
        });
    });
    //删除用户的ajax
    function deleteUser(userid) {
        alert("正在删除"+userid+"的用户");
        $.ajax({
            url: "/adminway/deluserbyid",
            async: true,
            type: "post",
            data: {
                userid: userid
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
</script>
</body>
</html>