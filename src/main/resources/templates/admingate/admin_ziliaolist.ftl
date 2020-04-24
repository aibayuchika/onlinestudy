<!DOCTYPE html>
<html lang="en">
<head>
    <meta content="multipart/form-data"  charset="UTF-8">
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
    <#include "/admin_header.ftl"/>
    <!--sidebar start-->
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
                        <dd><a href="/admin_ziliaotagmanage">tag库</a></dd>
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
    <!--sidebar end-->

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>资料管理</h2></span>
        </div>
        <div style="padding: 15px;">
            <div class="layui-form">
                <#if ziliaolist?exists || passlist?exists || faillist?exists || checklist?exists>
                <form class="layui-form" action="/admin_searchziliao">
                    <div class="layui-input-inline">
                        <input type="text" name="ziliaoname" placeholder="输入资料名称" autocomplete="off" class="layui-input">
                    </div>
                    <input type="submit" class="layui-btn" value="检索">
                </form>
                </#if>
                <a href="/admin2upload">
                    <button class="layui-btn layui-btn-xs">上传资料</button>
                </a>
                <a href="/admin_ziliaolist">
                    <button class="layui-btn layui-btn-xs layui-btn-primary">刷新</button>
                </a>
            </div>
        </div>
        <!--资料信息-->
        <!--所有资料-->
        <#if ziliaolist?exists>
        <table class="layui-table">
            <thead>
            <tr>
                <th hidden>资料ID</th>
                <th>上传用户</th>
                <th>资料名称</th>
                <th>最近修改时间</th>
                <th>资料封面</th>
                <th>资料状态</th>
                <th>操作项</th>
            </tr>
            </thead>
            <tbody class="">
                <#list ziliaolist as ziliaolist>
                    <tr>
                        <td valign="middle" align="center" hidden>${ziliaolist.ziliaoid}</td><!--视频id-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatorname}</td><!--上传者-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>【视频】${ziliaolist.ziliaoname}</#if>
                            <#if ziliaolist.ziliaotype == 2>【文档】${ziliaolist.ziliaoname}</#if>
                        </td><!--资料名称-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatetime}</td><!--最近修改时间-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>
                                <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                                <img src="../../static/images/word图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                                <img src="../../static/images/ppt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                                <img src="../../static/images/excel图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                                <img src="../../static/images/rar图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".pdf">
                                <img src="../../static/images/pdf图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".txt">
                                <img src="../../static/images/txt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                        </td>
                        <td><#if ziliaolist.ziliaostatus == 4>已通过</#if>
                        <#if videolist.ziliaostatus == 5>待审核</#if>
                        <#if videolist.ziliaostatus == 6>不通过</#if></td>
                        <td>
                            <a href="/admin_ziliaodetail?ziliaoid=${ziliaolist.ziliaoid}">
                                <button class="layui-btn layui-btn-xs layui-btn-primary">详情</button>
                            </a>
                            <#if ziliaolist.ziliaostatus == 5 || ziliaolist.ziliaostatus == 6>
                                <button class="layui-btn layui-btn-xs layui-btn-danger" id="videoshowbtn"
                                        onclick="confirmVideo(${ziliaolist.ziliaoid})">
                                    发布
                                </button>
                            </#if>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
        </#if>
        <!--仅通过-->
        <#if passlist?exists>
        <table class="layui-table">
            <thead>
            <tr>
                <th hidden>资料ID</th>
                <th>上传用户</th>
                <th>资料名称</th>
                <th>最近修改时间</th>
                <th>资料封面</th>
                <th>资料状态</th>
                <th>操作项</th>
            </tr>
            </thead>
            <tbody class="">
                <#list passlist as ziliaolist>
                    <tr>
                        <td valign="middle" align="center" hidden>${ziliaolist.ziliaoid}</td><!--视频id-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatorname}</td><!--上传者-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>【视频】${ziliaolist.ziliaoname}</#if>
                            <#if ziliaolist.ziliaotype == 2>【文档】${ziliaolist.ziliaoname}</#if>
                        </td><!--资料名称-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatetime}</td><!--最近修改时间-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>
                                <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                                <img src="../../static/images/word图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                                <img src="../../static/images/ppt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                                <img src="../../static/images/excel图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                                <img src="../../static/images/rar图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".pdf">
                                <img src="../../static/images/pdf图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".txt">
                                <img src="../../static/images/txt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                        </td>
                        <td>已通过</td>
                        <td>
                            <a href="/admin_ziliaodetail?ziliaoid=${ziliaolist.ziliaoid}">
                                <button class="layui-btn layui-btn-xs layui-btn-primary">详情</button>
                            </a>
                            <button class="layui-btn layui-btn-xs layui-btn-danger" id="videoshowbtn"
                                    onclick="confirmVideo(${ziliaolist.ziliaoid})">
                                    临时下架
                            </button>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
        </#if>
        <!--仅待办-->

            <#if checklist?exists>
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th hidden>资料ID</th>
                        <th>上传用户</th>
                        <th>资料名称</th>
                        <th>最近修改时间</th>
                        <th>资料封面</th>
                        <th>资料状态</th>
                        <th>操作项</th>
                    </tr>
                    </thead>
                    <tbody class="">
                    <#list checklist as ziliaolist>
                        <tr>
                            <td valign="middle" align="center" hidden>${ziliaolist.ziliaoid}</td><!--视频id-->
                            <td valign="middle" align="center">${ziliaolist.ziliaoupdatorname}</td><!--上传者-->
                            <td valign="middle" align="center">
                                <#if ziliaolist.ziliaotype == 1>【视频】${ziliaolist.ziliaoname}</#if>
                                <#if ziliaolist.ziliaotype == 2>【文档】${ziliaolist.ziliaoname}</#if>
                            </td><!--资料名称-->
                            <td valign="middle" align="center">${ziliaolist.ziliaoupdatetime}</td><!--最近修改时间-->
                            <td valign="middle" align="center">
                                <#if ziliaolist.ziliaotype == 1>
                                    <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                                    <img src="../../static/images/word图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                                    <img src="../../static/images/ppt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                                    <img src="../../static/images/excel图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                                    <img src="../../static/images/rar图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".pdf">
                                    <img src="../../static/images/pdf图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                                <#if ziliaolist.ziliaosuffix == ".txt">
                                    <img src="../../static/images/txt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                                </#if>
                            </td>
                            <td>待审核</td>
                            <td>
                                <a href="/admin_ziliaodetail?ziliaoid=${ziliaolist.ziliaoid}">
                                    <button class="layui-btn layui-btn-xs layui-btn-primary">详情</button>
                                </a>
                                <button class="layui-btn layui-btn-xs layui-btn-danger" id="videoshowbtn"
                                        onclick="confirmVideo(${ziliaolist.ziliaoid})">
                                    确认发布
                                </button>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </#if>
        <!--仅拒绝-->
        <#if faillist?exists>
        <table class="layui-table">
            <thead>
            <tr>
                <th hidden>资料ID</th>
                <th>上传用户</th>
                <th>资料名称</th>
                <th>最近修改时间</th>
                <th>资料封面</th>
                <th>资料状态</th>
                <th>操作项</th>
            </tr>
            </thead>
            <tbody class="">
                <#list faillist as ziliaolist>
                    <tr>
                        <td valign="middle" align="center" hidden>${ziliaolist.ziliaoid}</td><!--视频id-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatorname}</td><!--上传者-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>【视频】${ziliaolist.ziliaoname}</#if>
                            <#if ziliaolist.ziliaotype == 2>【文档】${ziliaolist.ziliaoname}</#if>
                        </td><!--资料名称-->
                        <td valign="middle" align="center">${ziliaolist.ziliaoupdatetime}</td><!--最近修改时间-->
                        <td valign="middle" align="center">
                            <#if ziliaolist.ziliaotype == 1>
                                <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                                <img src="../../static/images/word图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                                <img src="../../static/images/ppt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                                <img src="../../static/images/excel图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                                <img src="../../static/images/rar图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".pdf">
                                <img src="../../static/images/pdf图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                            <#if ziliaolist.ziliaosuffix == ".txt">
                                <img src="../../static/images/txt图标.png" style="width: 100px; height: 100px" alt="${ziliaolist.ziliaoname}">
                            </#if>
                        </td>
                        <td>不通过</td>
                        <td>
                            <a href="/admin_ziliaodetail?ziliaoid=${ziliaolist.ziliaoid}">
                                <button class="layui-btn layui-btn-xs layui-btn-primary">详情</button>
                            </a>
                            <button class="layui-btn layui-btn-xs layui-btn-danger" id="videoshowbtn"
                                    onclick="confirmVideo(${ziliaolist.ziliaoid})">
                                二次发布
                            </button>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
        </#if>
        <!--ziliaotaglist-->
        <#if ziliaotaglist?exists>

        </#if>

        <!--分页开始-->
        <div class="layui-laypage">
            <#if ziliaopage?exists>
                <#if ziliaopage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${ziliaopage.current}/${ziliaopage.pages}</span>
                <#else>
                    <a href="/admin_ziliaolist?toPage=0">首页</a>
                    <a href="/admin_ziliaolist?toPage=${ziliaopage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${ziliaopage.current}/${ziliaopage.pages}</span>
                </#if>
                <#if ziliaopage.current gte ziliaopage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_ziliaolist?toPage=${ziliaopage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_ziliaolist?toPage=${ziliaopage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--passpage-->
            <#if passpage?exists>
                <#if passpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${passpage.current}/${passpage.pages}</span>
                <#else>
                    <a href="/admin_ziliaopass?toPage=0">首页</a>
                    <a href="/admin_ziliaopass?toPage=${passpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${passpage.current}/${passpage.pages}</span>
                </#if>
                <#if passpage.current gte passpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_ziliaopass?toPage=${passpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_ziliaopass?toPage=${passpage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--checkpage-->
            <#if checkpage?exists>
                <#if checkpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${checkpage.current}/${checkpage.pages}</span>
                <#else>
                    <a href="/admin_ziliaocheck?toPage=0">首页</a>
                    <a href="/admin_ziliaocheck?toPage=${checkpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${checkpage.current}/${checkpage.pages}</span>
                </#if>
                <#if checkpage.current gte checkpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_ziliaocheck?toPage=${checkpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_ziliaocheck?toPage=${checkpage.pages-1}">尾页</a>
                </#if>
            </#if>
            <!--failpage-->
            <#if failpage?exists>
                <#if failpage.current lte 1>
                    <span>首页</span>
                    <span class="layui-laypage-prev">&laquo;</span>
                    <span>${failpage.current}/${failpage.pages}</span>
                <#else>
                    <a href="/admin_ziliaofail?toPage=0">首页</a>
                    <a href="/admin_ziliaofail?toPage=${failpage.current-1}" class="layui-laypage-prev">&laquo;</a>
                    <span>${failpage.current}/${failpage.pages}</span>
                </#if>
                <#if failpage.current gte failpage.pages>
                    <span class="layui-laypage-next">&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/admin_ziliaofail?toPage=${failpage.current+1}" class="layui-laypage-next">&raquo;</a>
                    <a href="/admin_ziliaofail?toPage=${failpage.pages-1}">尾页</a>
                </#if>
            </#if>
        </div>
        <!--分页结束-->
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
    //显示选择的图片
    function imgchange(obj){
        //获取点击的文本框
        var file = document.getElementById("pic_upload");
        var imgurl = window.URL.createObjectURL(file.files[0]);
        var img = document.getElementById('uploaded_pic');
        img.setAttribute('src', imgurl);//修改img标签src属性值
    };
    //删除视频的ajax
    function deleteVideo(videoid) {
        alert("正在删除"+videoid+"的视频");
        $.ajax({
            url: "/adminway/delvideobyid",
            async: true,
            type: "post",
            data: {
                videoid: videoid
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