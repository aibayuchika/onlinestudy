<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <ul class="layui-nav layui-nav-tree layui-bg-black" lay-filter="test">
            <li class="layui-nav-item"><a href="/admin_index">欢迎页</a></li>
            <li class="layui-nav-item layui-nav-itemed">
                <a href="javascript:;">用户管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="/admin_userlist">所有用户</a></dd>
                    <dd><a href="/admin_normaluser">普通用户</a></dd>
                    <dd><a href="/admin_secadminlist">二级管理员</a></dd>
                    <dd><a href="/admin_adminlist">管理员</a></dd>
                    <dd><a href="/admin_logincheck">登录记录</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">资料审核</a>
                <dl class="layui-nav-child">
                    <dd><a href="/admin_ziliaolist">所有资料</a></dd>
                    <dd><a href="/admin_ziliaopass">已通过</a></dd>
                    <dd><a href="/admin_ziliaocheck">待审核</a></dd>
                    <dd><a href="/admin_ziliaofail">未通过</a></dd>
                    <dd><a href="/admin_ziliaotag">tag库</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">论坛管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="/admin_discuss">所有论坛</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">音乐编辑</a>
                <dl class="layui-nav-child">
                    <dd><a href="/admin_musiclist">所有歌曲</a></dd>
                    <dd><a href="/admin_musicon">上架的音乐</a></dd>
                    <dd><a href="/admin_musicoff">下架的音乐</a></dd>
                    <dd><a href="/admin_musictagmanage">音乐标签库</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>