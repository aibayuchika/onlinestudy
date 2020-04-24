<!--头部菜单栏开始-->
<div class="layui-header">
    <div class="layui-logo">ADMIN PAGE</div>
    <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item"><a href="/adminindex">回到管理员首页</a></li>
        <li class="layui-nav-item"><a href="/index">前往主网站首页</a></li>
        <li class="layui-nav-item">
            <a href="javascript:;">上传界面</a>
            <dl class="layui-nav-child">
                <dd><a href="/adminuploadziliao">资料上传</a></dd>
                <dd><a href="/admincreatediscuss">创建论坛</a></dd>
            </dl>
        </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
        <#if Session["user"]?exists>
            <li class="layui-nav-item">
                <a href="javascript:;">Hi！${Session.user.username}！</a>
                <dl class="layui-nav-child">
                    <dd><a href="">我的资料</a></dd>
                    <dd><a href="">登录状况</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出登录</a></li>
        <#else>
            <li class="layui-nav-item">
                <a href="/tologin">先去登录吧</a>
            </li>
        </#if>
    </ul>

    <!--头部菜单栏结束-->
</div>