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
<!-- Fixed navbar -->
<#include "/header.ftl"/>

<div class="col-lg-1"></div>

<div class="col-lg-6">
    <div class="container">
        <div class="panel panel-primary">
            <div class="panel-heading">
            <#list discusslist as discusslist>
                <h2 class="panel-title">${discusslist.discussname}</h2>
                <p class="panel-title">${discusslist.createtime}</p>
                <p class="panel-title">
                    ${discusslist.creator}：
                    ${discusslist.discussabstract}
                </p>
<#--            </#list>-->
            </div>

            <div class="panel-body">
                <#if disfircomlist?exists>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <#list disfircomlist as disfircomlist>
                                <p class="panel-title">
                                    <#if disfircomlist.comstatus == 1>
                                        ${disfircomlist.comname}：${disfircomlist.commsg}
                                    </#if>
                                    <#if disfircomlist.comstatus == 2>
                                        该评论涉嫌违规，已被屏蔽
                                    </#if>
                                </p>
                                <p>${disfircomlist.comtime}</p>
                                <#if Session.user?exists>
                                    <#if Session.user.userid == disfircomlist.commerid>
                                        <p>
                                            <button class="btn btn-link" id="delfirstbtn" onclick="">删除</button>
                                            <button class="btn btn-link" id="missfirstbtn" onclick="">屏蔽</button>
                                        </p>
                                    </#if>
                                </#if>
                                <div class="panel-body">
                                    <form id="seccom">
                                        <div class="input-group">
                                            <input style="width: 250px" type="text" id="seccommsg" name="seccommsg" class="form-control">
                                            <button class="btn btn-info" id="seccom" onclick="
                                                    secondcomdis(${discusslist.discussid},${disfircomlist.comid},${disfircomlist.comname})">
                                                回复</button>
                                        </div>
                                    </form>
                                </div>
                                <#if dissecondcom?exists>
                                    <#list dissecondcom as dissecondcom>
                                        <#if dissecondcom.seccomid == disfircomlist.comid>
                                            <div class="panel panel-danger">
                                                <div class="panel-heading">
                                                    <div class="panel-title">
                                                        <p>
                                                            <#if dissecondcom.seccomstatus == 1>
                                                                ${dissecondcom.seccomname}回复${dissecondcom.replieder}：${dissecondcom.seccommsg}
                                                            </#if>
                                                            <#if dissecondcom.seccomstatus == 2>
                                                                该评论涉嫌违规，已被屏蔽
                                                            </#if>
                                                        </p>
                                                        <p>${dissecondcom.seccomtime}</p>
                                                    </div>
                                                    <#if Session.user?exists>
                                                        <#if Session.user.userid == disfircomlist.commerid>
                                                            <p>
                                                                <button class="btn btn-link" id="delsecondbtn" onclick="">删除</button>
                                                                <button class="btn btn-link" id="misssecondbtn" onclick="">屏蔽</button>
                                                            </p>
                                                        </#if>
                                                    </#if>
                                                </div>
                                            </div>
                                        </#if>
                                    </#list>
                                </#if>
                                <p>--------------</p>
                            </#list>
                        </div>
                    </div>
                </#if>
            </div>
            <!--分页开始-->
            <#if disfircomPage?exists>
                <div class="pagination-lg">
                    <#if disfircomPage.current lte 1>
                        <span>首页</span>
                        <span>&laquo;</span>
                        <span>${disfircomPage.current}/${disfircomPage.pages}</span>
                    <#else>
                        <a href="/user_disdetail?toPage=0?disid=${discusslist.discussid}">首页</a>
                        <a href="/user_disdetail?toPage=${disfircomPage.current-1}?disid=${discusslist.discussid}">&laquo;</a>
                        <span>${disfircomPage.current}/${disfircomPage.pages}</span>
                    </#if>
                    <#if disfircomPage.current gte disfircomPage.pages>
                        <span>&raquo;</span>
                        <span>尾页</span>
                    <#else>
                        <a href="/user_disdetail?toPage=${disfircomPage.current+1}?disid=${discusslist.discussid}">&raquo;</a>
                        <a href="/user_disdetail?toPage=${disfircomPage.pages-1}?disid=${discusslist.discussid}">尾页</a>
                    </#if>
                </div>
            </#if>
            <!--分页结束-->
            <div class="">
                <textarea style="width: 250px; height: 100px;" name="disfircom" id="disfircom" placeholder="输入评论"></textarea>
                <button class="btn btn-info" id="firstcombtn" onclick="firstcomdis('${discusslist.discussid}')">评论</button>
            </div>
            </#list>
        </div>
    </div>
</div>

<div class="col-lg-3"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
<script>
    function firstcomdis(disid) {
        //var commsg = document.getElementById("disfircom").value;
        //alert(disid);
        $.ajax({
            url: "/commentdis",
            async: true,
            type: "get",
            data: {
                disid: disid,
                commsg: $('#disfircom').val()
            },
            success: function () {
                alert("评论成功！");
                window.location.reload();
            },
            error: function () {
                alert("评论失败！");
                window.location.reload();
            }
        });
    };
    function secondcomdis(disid,fircomid,replieder) {
        alert(disid+","+fircomid+","+replieder);
        $.ajax({
            url: "/replycomdis",
            async: true,
            type: "get",
            data: {
                disid: disid,
                fircomid: fircomid,
                replieder: replieder,
                seccommsg: $('#seccommsg').val()
            },success: function () {
                alert("回复成功！");
                window.location.reload();
            },
            error: function () {
                alert("回复失败！");
                window.location.reload();
            }
        });
    }
    function delfirstcom(disid, comid) {

    }
</script>
</body>
</html>