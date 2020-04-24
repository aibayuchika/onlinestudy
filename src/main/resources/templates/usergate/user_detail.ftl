<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
    <!-- 引入 Bootstrap -->
    <link href="../../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 Shiv 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
    <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    [endif]-->
    <style>
        body{
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>
</head>
<body>
<!--header start-->
<#include "/header.ftl"/>
<!--header end-->

<div class="container-fluid col-lg-1"></div>

<div class="container-fluid col-lg-2 navbar">
    <span><h3>个人资料</h3></span>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" id="bar-1"><a href="/userdetail?userid=${Session.user.userid}">我的资料</a></li>
        <li role="presentation" id="bar-2"><a href="/uservideo?userid=${Session.user.userid}">我的视频</a></li>
        <li role="presentation" id="bar-3"><a href="/userdoc?userid=${Session.user.userid}">我的文档</a></li>
        <li role="presentation" id="bar-4"><a href="/userdiscuss?userid=${Session.user.userid}">我的论坛</a></li>
        <li role="presentation" id="bar-5"><a href="/userquest?userid=${Session.user.userid}">我的咨询</a></li>
    </ul>
</div>
<div class="col-lg-8 container">

    <!--个人资料模块开始-->
    <#if userlist?exists>
        <div>
            <h2>我的资料</h2>
        </div>
        <#list userlist as userlist>
            <div class="form-group">
                <label class="">我的ID：</label>
                <input type="text" name="userid" value="${userlist.userid}" disabled="disabled" class="text-left">
            </div>
            <div class="form-group">
                <label class="">我的类型：</label>
                <label>
                    <#if userlist.usertype == 1>管理员</#if>
                    <#if userlist.usertype == 2>二级管理员</#if>
                    <#if userlist.usertype == 3>普通用户</#if>
                    <#if userlist.isblack == 2>（黑名单）</#if>
                </label>
            </div>
            <div class="form-group">
                <label class="">我的名称：</label>
                <input type="text" name="username" value="${userlist.username}" disabled="disabled" class="text-left">
            </div>
                <div class="form-group">
                <label class="">我的昵称：</label>
                <input type="text" name="nickname" value="${userlist.nickname!"等待补充"}" disabled="disabled" class="text-left">
            </div>
            <div class="form-group">
                <label class="">我的性别：</label>
                <label>
                    <#if userlist.usersex == "male">男</#if>
                    <#if userlist.usersex == "female">女</#if>
                    <#if userlist.usersex == "unknown">暂不透露</#if>
                </label>
            </div>
            <div class="form-group">
                <label class="">我的邮箱：</label>
                <input type="text" name="usermail" value="${userlist.usermail!"等待补充"}" disabled="disabled" class="text-left">
            </div>
        </#list>
        <div>
            <a href="/user_updetail?userid=${Session.user.userid}">
                <button class="btn btn-warning btn-sm">我要修改</button>
            </a>
        </div>
    </#if>
    <!--个人资料模块结束-->

    <!--我的视频模块开始-->
    <#if videolist?exists>
        <div>
            <h2>我的视频</h2>
        </div>
        <div class="form-group">
            <a href="/user2upload">
                <button class="btn btn-sm btn-warning">资料上传</button>
            </a>
        </div>
        <div class="table">
            <table class="table-hover table">
                <thead>
                <th>视频名称</th>
                <th>视频状态</th>
                <th>视频封面</th>
                <th>上传时间</th>
                <th>最近修改时间</th>
                <th>点击量</th>
                <th>操作项目</th>
                </thead>
                <tbody>
                <#list videolist as videolist>
                <tr>
                    <td>${videolist.ziliaoname}</td>
                    <td>
                        <#if videolist.ziliaostatus == 4>已通过</#if>
                        <#if videolist.ziliaostatus == 5>待审核</#if>
                        <#if videolist.ziliaostatus == 6>不通过</#if>
                    </td>
                    <td>
                        <img src="static/${videolist.ziliaocoverpath}" style="width: 100px; height: 100px"
                             alt="${videolist.ziliaoname}">
                    </td>
                    <td>${videolist.ziliaouploadtime}</td>
                    <td>${videolist.ziliaoupdatetime}</td>
                    <td>${videolist.ziliaoclick}次</td>
                    <td>
                        <button id="delbtn" class="btn btn-sm btn-danger" onclick="">删除</button>&nbsp;
                        <button id="delbtn" class="btn btn-sm btn-primary" onclick="">详情</button>&nbsp;
                        <button id="delbtn" class="btn btn-sm btn-primary" onclick="">修改</button>&nbsp;
                        <#if videolist.ziliaostatus == 5 || videolist.ziliaostatus == 6>
                            <button id="delbtn" class="btn btn-sm btn-warning" onclick="">重传</button>
                        </#if>
                    </td>
                </tr>
                </#list>
                </tbody>
            </table>
        </div>
        <!--翻页开始-->
        <div class="pagination-lg">
            <#if videopage.current lte 1>
                <span>首页</span>
                <span>&laquo;</span>
                <span>${videopage.current}/${videopage.pages}</span>
            <#else>
                <a href="/uservideo?toPage=0">首页</a>
                <a href="/uservideo?toPage=${videopage.current-1}">&laquo;</a>
                <span>${videopage.current}/${videopage.pages}</span>
            </#if>
            <#if videopage.current gte videopage.pages>
                <span>&raquo;</span>
                <span>尾页</span>
            <#else>
                <a href="/uservideo?toPage=${videopage.current+1}">&raquo;</a>
                <a href="/uservideo?toPage=${videopage.pages-1}">尾页</a>
            </#if>
        </div>
        <!--翻页结束-->
    </#if>
    <!--我的视频模块结束-->

    <!--我的文档模块开始-->
    <#if filelist?exists>
        <div>
            <h2>我的文档</h2>
        </div>
        <div class="form-group">
            <a href="/user2upload">
                <button class="btn btn-sm btn-warning">资料上传</button>
            </a>
        </div>
        <div class="table">
            <table class="table-hover table">
                <thead>
                <th>文档名称</th>
                <th>文档状态</th>
                <th>上传时间</th>
                <th>最后修改时间</th>
                <th>文档类型</th>
                <th>点击量</th>
                <th>操作项目</th>
                </thead>
                <tbody>
                <#list filelist as filelist>
                    <tr>
                        <td>${filelist.ziliaoname}</td>
                        <td>
                            <#if filelist.ziliaostatus == 4>已通过</#if>
                            <#if filelist.ziliaostatus == 5>待审核</#if>
                            <#if filelist.ziliaostatus == 6>不通过</#if>
                        </td>
                        <td>${filelist.ziliaouploadtime}</td>
                        <td>${filelist.ziliaoupdatetime}</td>
                        <td>
                            <#if filelist.ziliaosuffix == ".doc" || filelist.ziliaosuffix == ".docx">
                                <img src="../../static/images/word图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                            <#if filelist.ziliaosuffix == ".xls" || filelist.ziliaosuffix == ".xlsx">
                                <img src="../../static/images/excel图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                            <#if filelist.ziliaosuffix == ".ppt" || filelist.ziliaosuffix == ".pptx">
                                <img src="../../static/images/ppt图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                            <#if filelist.ziliaosuffix == ".pdf">
                                <img src="../../static/images/pdf图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                            <#if filelist.ziliaosuffix == ".rar" || filelist.ziliaosuffix == ".zip">
                                <img src="../../static/images/rar图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                            <#if filelist.ziliaosuffix == ".txt">
                                <img src="../../static/images/txt图标.png" style="width: 50px; height: 50px" alt="${filelist.ziliaoname}">
                            </#if>
                        </td>
                        <td>${filelist.ziliaoclick}次</td>
                        <td>
                            <button id="delbtn" class="btn btn-sm btn-danger">删除</button>&nbsp;
                            <button id="topdfdetail" class="btn btn-sm btn-info">详情</button>&nbsp;
                            <button id="delbtn" class="btn btn-sm btn-primary" onclick="">修改</button>&nbsp;
                            <#if filelist.ziliaostatus == 5 || filelist.ziliaostatus == 6>
                                <button id="delbtn" class="btn btn-sm btn-warning" onclick="">重传</button>
                            </#if>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
        <!--翻页开始-->
        <div class="pagination-lg">
            <#if filepage.current lte 1>
                <span>首页</span>
                <span>&laquo;</span>
                <span>${filepage.current}/${filepage.pages}</span>
            <#else>
                <a href="/userdoc?toPage=0">首页</a>
                <a href="/userdoc?toPage=${filepage.current-1}">&laquo;</a>
                <span>${filepage.current}/${filepage.pages}</span>
            </#if>
            <#if filepage.current gte filepage.pages>
                <span>&raquo;</span>
                <span>尾页</span>
            <#else>
                <a href="/userdoc?toPage=${filepage.current+1}">&raquo;</a>
                <a href="/userdoc?toPage=${filepage.pages-1}">尾页</a>
            </#if>
        </div>
        <!--翻页结束-->
    </#if>
    <!--我的文档模块结束-->

    <!--我的论坛模块开始-->
    <#if discreateerror?exists>
        <div class="alert alert-warning">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            <strong>${discreateerror}</strong>
        </div>
    </#if>
    <#if discusslist?exists>
        <div>
            <h2>我的论坛</h2>
        </div>
        <div class="form-group">
            <form action="/tocreatediscuss">
                <button id="creatediscuss" class="btn btn-info btn-lg" data-toggle="modal" data-target="#createdisModal">
                    创建论坛
                </button>
            </form>
        </div>
        <div class="table">
            <table class="table-hover table">
                <thead>
                <th>论坛名称</th>
                <th>论坛创建者</th>
                <th>创建时间</th>
                <th>回帖数</th>
                <th>操作项目</th>
                </thead>
                <tbody>
                <#list discusslist as discusslist>
                    <tr>
                        <td><a href="/disdetail?disid=${discusslist.discussid}">${discusslist.discussname}</a></td>
                        <td>${discusslist.creator}</td>
                        <td>${discusslist.createtime}</td>
                        <td>被${discusslist.commentcount}次讨论</td>
                        <td>
                            <button id="todisdetail" class="btn-info" onclick="">
                                查看详情
                            </button>
                            <button id="deldisbtn" class="btn-danger" onclick="">删除</button>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </#if>
    <!--我的论坛模块结束-->

    <!--我的咨询模块开始-->
    <!--我的咨询模块结束-->
</div>
<!-- /.container -->
<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $("#credis").click(function () {
        $.ajax({
            url: "/creatediscuss",
            data: $("#discussmsg").serialize(),
            type: "post",
            success: function () {
                alert("创建成功");
                window.location.reload();
            },
            error: function () {
                alert("创建失败");
                window.location.reload();
            }
        });
    });
</script>
</body>
</html>