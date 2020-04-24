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
                <li class="layui-nav-item">
                    <a href="/adminannounce">公告管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="/admindiscuss">论坛管理</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>论坛管理</h2></span>
        </div>
        <div style="padding: 15px;">
            <div class="layui-form">
                <form class="layui-form" action="/adminsearchdiscuss">
                    <div class="layui-input-inline">
                        <input type="text" name="discussname" placeholder="论坛名" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>
                <button class="layui-btn layui-btn-xs" onclick="uploadchart()">创建新论坛</button>
                <form action="/admindiscuss">
                    <input type="submit" class="layui-btn layui-btn-xs" value="刷新">
                </form>
            </div>
        </div>
        <!--公告信息-->
        <table>
            <thead>
            <th>论坛名</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>回复数</th>
            <th>操作</th>
            </thead>
            <tbody>
            <#if discusslist?exists>
            <#list discusslist as dlist>
                <tr>
                    <td><a href="/admindisdetail?disid=${dlist.discussid}">
                            ${dlist.discussname}</a></td>
                    <td>${dlist.creator}</td>
                    <td>${dlist.createtime}</td>
                    <td>${dlist.commentcount}</td>
                    <td>
                        <button class="layui-btn layui-btn-xs layui-btn-danger" id="deletebtn"
                                onclick="deleteDiscuss(${dlist.discussid})">删除论坛</button>
                    </td>
                </tr>
            </#list>
            </#if>
            </tbody>
        </table>
        <!--分页开始-->
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
        <!--分页结束-->

        <!--新增表格-->
        <div class="layui-table-body" id="uploaddiscuss" style="display: none;">
            <form method="post" id="discussform" class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">论坛标题</label>
                    <div class="layui-input-inline shortInput">
                        <input type="text" name="discussname" required autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">论坛详情</label>
                    <div class="layui-input-block">
                        <textarea name="discussabstract" class=""></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn" id="discussupbtn">上传</button>
                        <button type="reset" class="layui-btn layui-btn-primary">取消</button>
                    </div>
                </div>
            </form>
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
    //打开上传上传窗口
    function uploadchart(obj) {
        layer.open({
            type: 1,
            title: "创建论坛",
            area: ['500px', '500px'],
            offset: 'auto',
            content: $("#uploaddiscuss")
        });
    }
    //删除论坛的ajax
    function deleteDiscuss(disid) {
        alert("正在删除"+disid+"的论坛");
        $.ajax({
            url: "/adminway/deldiscuss",
            async: true,
            type: "post",
            data: {
                disid: disid
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
    //发布论坛的ajax
    $("#discussupbtn").click(function () {
        alert("发布中");
        $.ajax({
            url: "admindiscuss",
            data: $("#discussform").serialize(),
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