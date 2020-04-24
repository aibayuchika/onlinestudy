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
    <#include "/admin_header.ftl"/>
    <!--header end-->

    <!--侧边菜单开始-->
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
    <!--侧边菜单结束-->

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>用户管理</h2></span>
        </div>
        <div style="padding: 12px;">
            <div class="layui-form">
                <#if userlist?exists || adminlist?exists || secadminlist?exists || normallist?exists>
                <form class="layui-form" action="/admin_searchuser">
                    <div class="layui-input-inline">
                        <input type="text" name="userid" placeholder="输入用户帐号" autocomplete="off" class="layui-input">
                        <input type="text" name="username" placeholder="输入用户名称" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>
                </#if>
                <#if login_statuslist?exists>
                    <form class="layui-form" action="/admin_searchlogin">
                        <div class="layui-input-inline">
                            <input type="text" name="user_id" placeholder="输入用户账号" autocomplete="off" class="layui-input">
                        </div>
                        <input type="submit" class="layui-btn" value="查询">
                    </form>
                </#if>
                <button class="layui-btn layui-btn-xs" onclick="registuser()">注册用户</button>
                <a href="/admin_userlist">
                    <button class="layui-btn layui-btn-xs layui-btn-primary">刷新</button>
                </a>
            </div>
        </div>
        <!--用户信息-->
        <#if userlist?exists>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户名称</th>
                    <th>用户昵称</th>
                    <th>用户密码</th>
                    <th>用户类型</th>
                    <th>用户性别</th>
                    <th>用户邮箱</th>
                    <th>注册时间</th>
                    <th>是否黑名单</th>
                    <th>操作项</th>
                </tr>
                </thead>
                <tbody class="">
                    <#list userlist as userlist>
                        <tr>
                            <td valign="middle" align="center">${userlist.userid}</td>
                            <td valign="middle" align="center">${userlist.username}</td>
                            <td valign="middle" align="center">${userlist.nickname!"暂空缺"}</td>
                            <td valign="middle" align="center">
                                <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="reset_pass(${userlist.userid})">重置密码</button>
                            </td>
                            <td valign="middle" align="center">
                                <#if userlist.usertype==1>管理员</#if>
                                <#if userlist.usertype==2>二级管理员</#if>
                                <#if userlist.usertype==3>普通用户</#if>
                            </td>
                            <td valign="middle" align="center">
                                <#if userlist.usersex == "male">男</#if>
                                <#if userlist.usersex == "female">女</#if>
                                <#if userlist.usersex == "unknown">暂不明</#if>
                            </td>
                            <td valign="middle" align="center">${userlist.usermail!"暂空缺"}</td>
                            <td valign="middle" align="center">${userlist.rigisttime!"暂空缺"}</td>
                            <td valign="middle" align="center">
                                <#if userlist.isblack == 1>
                                    <button class="layui-btn layui-btn-danger layui-btn-xs"
                                            onclick="set_black(${userlist.userid})">
                                        设为黑名单
                                    </button>
                                </#if>
                                <#if userlist.isblack == 2>
                                    <button class="layui-btn layui-btn-primary layui-btn-xs" onclick="set_white(${userlist.userid})">
                                        撤销黑名单
                                    </button>
                                </#if>
                            </td>
                            <td valign="middle" align="center">
                                <button class="layui-btn layui-btn-xs layui-btn-danger"
                                        onclick="deleteUser(${userlist.userid})">
                                    删除用户
                                </button>&nbsp;
                                <#if userlist.usertype == 3>
                                    <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="set_secondadmin(${userlist.userid})">
                                        升级
                                    </button>&nbsp;
                                </#if>
                                <#if userlist.usertype == 2>
                                    <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="cancel_secondadmin(${userlist.userid})">
                                        撤下
                                    </button>
                                </#if>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </#if>
        <!--adminlist-->
        <#if adminlist?exists>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户名称</th>
                    <th>用户昵称</th>
                    <th>用户密码</th>
                    <th>用户类型</th>
                    <th>用户性别</th>
                    <th>用户邮箱</th>
                    <th>注册时间</th>
                    <th>是否黑名单</th>
                    <th>操作项</th>
                </tr>
                </thead>
                <tbody>
                <#list adminlist as userlist>
                    <tr>
                        <td valign="middle" align="center">${userlist.userid}</td>
                        <td valign="middle" align="center">${userlist.username}</td>
                        <td valign="middle" align="center">${userlist.nickname!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="reset_pass(${userlist.userid})">重置密码</button>
                        </td>
                        <td valign="middle" align="center">管理员</td>
                        <td valign="middle" align="center">
                            <#if userlist.usersex == "male">男</#if>
                            <#if userlist.usersex == "female">女</#if>
                            <#if userlist.usersex == "unknown">暂不明</#if>
                        </td>
                        <td valign="middle" align="center">${userlist.usermail!"暂空缺"}</td>
                        <td valign="middle" align="center">${userlist.rigisttime!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <#if userlist.isblack == 1>
                                <button class="layui-btn layui-btn-danger layui-btn-xs" onclick="set_black(${userlist.userid})">设为黑名单</button>
                            </#if>
                            <#if userlist.isblack == 2>
                                <button class="layui-btn layui-btn-primary layui-btn-xs" onclick="set_white(${userlist.userid})">撤销黑名单</button>
                            </#if>
                        </td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-danger" onclick="deleteUser(${userlist.userid})">删除用户</button>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        <!--second admin list-->
        <#if secadminlist?exists>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户名称</th>
                    <th>用户昵称</th>
                    <th>用户密码</th>
                    <th>用户类型</th>
                    <th>用户性别</th>
                    <th>用户邮箱</th>
                    <th>注册时间</th>
                    <th>是否黑名单</th>
                    <th>操作项</th>
                </tr>
                </thead>
                <tbody>
                <#list secadminlist as userlist>
                    <tr>
                        <td valign="middle" align="center">${userlist.userid}</td>
                        <td valign="middle" align="center">${userlist.username}</td>
                        <td valign="middle" align="center">${userlist.nickname!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="reset_pass(${userlist.userid})">重置密码</button>
                        </td>
                        <td valign="middle" align="center">二级管理员</td>
                        <td valign="middle" align="center">
                            <#if userlist.usersex == "male">男</#if>
                            <#if userlist.usersex == "female">女</#if>
                            <#if userlist.usersex == "unknown">暂不明</#if>
                        </td>
                        <td valign="middle" align="center">${userlist.usermail!"暂空缺"}</td>
                        <td valign="middle" align="center">${userlist.rigisttime!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <#if userlist.isblack == 1>
                                <button class="layui-btn layui-btn-danger layui-btn-xs" onclick="set_black(${userlist.userid})">设为黑名单</button>
                            </#if>
                            <#if userlist.isblack == 2>
                                <button class="layui-btn layui-btn-primary layui-btn-xs" onclick="set_white(${userlist.userid})">撤销黑名单</button>
                            </#if>
                        </td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-danger" onclick="deleteUser(${userlist.userid})">删除用户</button>&nbsp;
                            <#if userlist.usertype == 3>
                                <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="set_secondadmin(${userlist.userid})">升级</button>&nbsp;
                            </#if>
                            <#if userlist.usertype == 2>
                                <button class="layui-btn layui-btn-xs layui-btn-primary" onclick="cancel_secondadmin(${userlist.userid})">撤下</button>
                            </#if>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        <!--normal user list-->
        <#if normallist?exists>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户名称</th>
                    <th>用户昵称</th>
                    <th>用户密码</th>
                    <th>用户类型</th>
                    <th>用户性别</th>
                    <th>用户邮箱</th>
                    <th>注册时间</th>
                    <th>是否黑名单</th>
                    <th>操作项</th>
                </tr>
                </thead>
                <tbody>
                <#list normallist as userlist>
                    <tr>
                        <td valign="middle" align="center">${userlist.userid}</td>
                        <td valign="middle" align="center">${userlist.username}</td>
                        <td valign="middle" align="center">${userlist.nickname!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-warm" onclick="reset_pass(${userlist.userid})">重置密码</button>
                        </td>
                        <td valign="middle" align="center">普通用户</td>
                        <td valign="middle" align="center">
                            <#if userlist.usersex == "male">男</#if>
                            <#if userlist.usersex == "female">女</#if>
                            <#if userlist.usersex == "unknown">暂不明</#if>
                        </td>
                        <td valign="middle" align="center">${userlist.usermail!"暂空缺"}</td>
                        <td valign="middle" align="center">${userlist.rigisttime!"暂空缺"}</td>
                        <td valign="middle" align="center">
                            <#if userlist.isblack == 1>
                                <button class="layui-btn layui-btn-danger layui-btn-xs"
                                        onclick="set_black(${userlist.userid})">
                                    设为黑名单
                                </button>
                            </#if>
                            <#if userlist.isblack == 2>
                                <button class="layui-btn layui-btn-primary layui-btn-xs"
                                        onclick="set_white(${userlist.userid})">
                                    撤销黑名单
                                </button>
                            </#if>
                        </td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-danger"
                                    onclick="deleteUser(${userlist.userid})">
                                删除用户
                            </button>&nbsp;
                            <#if userlist.usertype == 3>
                                <button class="layui-btn layui-btn-xs layui-btn-warm"
                                        onclick="set_secondadmin(${userlist.userid})">
                                    升级
                                </button>&nbsp;
                            </#if>
                            <#if userlist.usertype == 2>
                                <button class="layui-btn layui-btn-xs layui-btn-primary"
                                        onclick="cancel_secondadmin(${userlist.userid})">
                                    撤下
                                </button>
                            </#if>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
        </#if>
        <#if login_statuslist?exists>
            <table class="layui-table">
                <thead>
                    <th>用户帐号</th>
                    <th>最近登录时间</th>
                    <th>最近登录IP</th>
                    <th>操作项</th>
                </thead>
                <tbody>
                <#list login_statuslist as lslist>
                    <tr>
                        <td valign="middle" align="center">${lslist.userid}</td>
                        <td valign="middle" align="center">${lslist.logintime}</td>
                        <td valign="middle" align="center">${lslist.loginip}</td>
                        <td valign="middle" align="center">
                            <button class="layui-btn layui-btn-xs layui-btn-danger" onclick="dellogin(${lslist.id})">
                                删除记录
                            </button>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        <!--分页开始-->
        <div class="layui-laypage">
            <#if page?exists>
                <#if page.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${page.current}/${page.pages}</span>
                <#else>
                    <a href="/admin_userlist?toPage=0">首页</a>
                    <a href="/admin_userlist?toPage=${page.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${page.current}/${page.pages}</span>
                </#if>
                <#if page.current gte page.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_userlist?toPage=${page.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_userlist?toPage=${page.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--adminpage-->
            <#if adminpage?exists>
                <#if adminpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${adminpage.current}/${adminpage.pages}</span>
                <#else>
                    <a href="/admin_adminlist?toPage=0">首页</a>
                    <a href="/admin_adminlist?toPage=${adminpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${adminpage.current}/${adminpage.pages}</span>
                </#if>
                <#if adminpage.current gte adminpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_adminlist?toPage=${adminpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_adminlist?toPage=${adminpage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--secadminpage-->
            <#if secadminpage?exists>
                <#if secadminpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${secadminpage.current}/${secadminpage.pages}</span>
                <#else>
                    <a href="/admin_secadminlist?toPage=0">首页</a>
                    <a href="/admin_secadminlist?toPage=${secadminpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${secadminpage.current}/${secadminpage.pages}</span>
                </#if>
                <#if secadminpage.current gte secadminpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_secadminlist?toPage=${secadminpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_secadminlist?toPage=${secadminpage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--normalpage-->
            <#if normalpage?exists>
                <#if normalpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${normalpage.current}/${normalpage.pages}</span>
                <#else>
                    <a href="/admin_normaluser?toPage=0">首页</a>
                    <a href="/admin_normaluser?toPage=${normalpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${normalpage.current}/${normalpage.pages}</span>
                </#if>
                <#if normalpage.current gte normalpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_normaluser?toPage=${normalpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_normaluser?toPage=${normalpage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--login_statuspage-->
            <#if login_statuspage?exists>
                <#if login_statuspage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${login_statuspage.current}/${login_statuspage.pages}</span>
                <#else>
                    <a href="/admin_logincheck?toPage=0">首页</a>
                    <a href="/admin_logincheck?toPage=${login_statuspage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${login_statuspage.current}/${login_statuspage.pages}</span>
                </#if>
                <#if login_statuspage.current gte login_statuspage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_logincheck?toPage=${login_statuspage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_logincheck?toPage=${login_statuspage.pages-1}">尾页</a>
                </#if>
            </#if>
        </div>
        <!--分页结束-->

        <!--新增表格，表格提交好像可以写在最下面layer.msg处-->
        <div class="layui-table-body" id="register" style="display: none;">
            <form id="adduserForm" class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户帐号</label>
                    <div class="layui-input-inline shortInput">
                        <input type="text" name="userid" id="userid" required lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="username" id="username" required lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户性别</label>
                    <div class="layui-input-inline">
                        <input type="radio" name="usersex" id="usersex" class="layui-icon-radio" value="male" checked>男&nbsp;
                        <input type="radio" name="usersex" id="usersex" class="layui-icon-radio" value="female">女
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户密码</label>
                    <div class="layui-input-inline">
                        新用户密码默认为888888
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户类型</label>
                    <br>
                    <select class="layui-select" name="usertype" id="usertype">
                        <option class="layui-select" value="1">管理员</option>
                        <option class="layui-select" value="2">二级管理员</option>
                        <option class="layui-select" value="3" selected>普通用户</option>
                    </select>
                </div>
            </form>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button id="regist" class="layui-btn" onclick="registUser()">确认</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </div>
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
    function registUser() {
        var btnchose = confirm("确定要注册该用户吗？");
        var username = $("#username").val();
        var userid = $("#userid").val();
        var usersex = $("input[name='usersex']:checked").val();
        var usertype = $("#usertype").val();
        if(btnchose == true){
            $.ajax({
                url: "/admin_adduser",
                data: {
                    username: username,
                    userid: userid,
                    usersex: usersex,
                    usertype: usertype
                },
                type: "post",
                success: function () {
                    alert("注册成功！正在刷新页面！");
                    window.location.reload();
                },
                error: function () {
                    alert("注册失败！该帐号或已被注册！");
                }
            });
        }else{

        }
    }
    //删除用户的ajax
    function deleteUser(userid) {
        var btnchose = confirm("确定要删除该用户吗？");
        if(btnchose == true){
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
        }else {

        }
    }
    //设置黑名单
    function set_black(userid) {
        var btnchose = confirm("确定要将该用户设置为黑名单吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_setblack",
                async: true,
                type: "post",
                data: {userid: userid},
                success: function () {
                    alert("用户" + userid + "已被设为黑名单");
                    location.reload();
                },error: function () {
                    alert("用户" + userid + "未被设为黑名单");
                }
            });
        }else {

        }
    }
    //设置白名单
    function set_white(userid) {
        var btnchose = confirm("确定要将该用户设置成白名单吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_setwhite",
                async: true,
                type: "post",
                data: {userid: userid},
                success: function () {
                    alert("用户" + userid + "已被设为白名单");
                    location.reload();
                },error: function () {
                    alert("用户" + userid + "未被设为白名单");
                }
            });
        }else {

        }
    }
    //重置密码
    function reset_pass(userid) {
        var btnchose = confirm("确定要为该用户重置密码吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_resetpasswd",
                async: true,
                type: "post",
                data: {userid: userid},
                success: function () {
                    alert("用户" + userid + "已被重置");
                    location.reload();
                },error: function () {
                    alert("重置密码失败");
                }
            });
        }else {

        }
    }
    //设置用户为二级管理员
    function set_secondadmin(userid) {
        var btnchose = confirm("确定要设置该用户为二级管理员吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_setsecondadmin",
                async: true,
                type: "post",
                data: {userid: userid},
                success: function () {
                    alert("用户" + userid + "已被设置为二级管理员");
                    location.reload();
                },error: function () {
                    alert("设置失败");
                }
            });
        }else {

        }
    }
    //撤销用户为二级管理员
    function cancel_secondadmin(userid) {
        var btnchose = confirm("确定要撤销该用户的二级管理员吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_cancelsecondadmin",
                async: true,
                type: "post",
                data: {userid: userid},
                success: function () {
                    alert("用户" + userid + "已被撤下二级管理员职务");
                    location.reload();
                },error: function () {
                    alert("设置失败");
                }
            });
        }else {

        }
    }
    //删除登录记录
    function dellogin(id) {
        var btnchose = confirm("确定要删除该条记录吗？");
        if(btnchose == true){
            $.ajax({
                url: "/admin_dellogin",
                async: true,
                type: "post",
                data: {loginid: id},
                success: function () {
                    alert("删除记录成功");
                    location.reload();
                },
                error: function () {
                    alert("记录删除失败");
                }
            });
        }else {

        }
    }
</script>
</body>
</html>