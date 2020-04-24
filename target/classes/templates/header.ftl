<!-- Fixed navbar -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Home Page</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="/index">主页</a></li>
                <li><a href="/file">文档</a></li>
                <li><a href="/video">视频</a></li>
                <li><a href="/discuss">论坛</a></li>
                <#if Session["user"]?exists && Session.user.usertype == 2>
                    <li><a href="">后台管理</a></li>
                </#if>
                <#if Session["user"]?exists && Session.user.usertype == 1>
                    <li><a href="/admin_index">返回后台</a></li>
                </#if>
            </ul>
            <form class="navbar-form navbar-left" action="/searchvifi">
                <div class="form-group">
                    <input type="text" name="key" class="form-control" placeholder="搜索视频或文档">
                </div>
                <div class="radio">
                    <input type="radio" name="type" value="1" checked>资料&nbsp;|
                    <input type="radio" name="type" value="3">论坛
                </div>
                <input type="submit" class="btn btn-default" value="搜索">
            </form>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/useruploadPage">我要投稿</a></li>
                <#if Session["user"]?exists>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            Hi！${Session.user.username}
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/userdetail?userid=${Session.user.userid}">我的界面</a></li>
                            <li><a href="/logout">退出登录</a></li>
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
