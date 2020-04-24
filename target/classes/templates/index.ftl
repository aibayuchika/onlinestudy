<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
    <!-- 引入 Bootstrap -->
    <link href="../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

<div class="container">
    <!--搜索用-->
    <div>
        <div class="row marketing">
            <#if searchvlist?exists>
                <h3><span>资料</span></h3>
                <!--视频遍历开始-->
                <#list searchlist as vlist>
                    <div class="col-lg-4">
                        <p><a href="/indexvideodetail?videoid=${vlist.videoid}">
                                <img src="static/${vlist.coverpath}" style="width: 200px; height: 200px" alt="${vlist.videoname}">
                            </a></p>
                        <h4><a href="">${vlist.videoname}</a></h4>
                        <p>${vlist.uploadtime}</p>
                    </div>
                </#list>
                <!--视频遍历结束-->
            </#if>

            <#if searchflist?exists>
                <h3><span>视频</span></h3>
                <!--文档遍历开始-->
                <#list searchvflist as flist>
                    <div class="col-lg-4">
                        <p>
                            <a href="/indexfiledetail?fileid=">
                                <img src="static/${flist.coverpath}" style="width: 200px; height: 200px" alt="${flist.videoname}">
                            </a>
                        </p>
                        <h4><a href="">${flist.videoname}</a></h4>
                        <p>${flist.uploadtime}</p>
                    </div>
                </#list>
                <!--文档遍历结束-->
            </#if>
        </div>
    </div>
    <!--搜索用结束-->

    <div>
        <div class="row marketing">
            <#if videolist?exists>
                <h3><span>视频</span></h3>
                <!--视频遍历开始-->
                <#list videolist as videolist>
                <div class="col-lg-4">
                    <p>
                        <a href="/index_ziliao?ziliaoid=${videolist.ziliaoid}">
                            <img src="static/${videolist.ziliaocoverpath}" style="width: 200px; height: 200px" alt="${videolist.ziliaoname}">
                        </a>
                    </p>
                    <h4>
                        <a href="">
                            【视频】${videolist.ziliaoname}
                        </a>
                    </h4>
                    <p>上传于${ziliaolist.ziliaouploadtime}</p>
                    <p>点击：${ziliaolist.ziliaoclick}</p>
                </div>
                </#list>
                <!--视频遍历结束-->
            </#if>
        </div>
        <#if videopage?exists>
        <!--翻页开始-->
        <div class="pagination-lg">
            <#if videopage.current lte 1>
                <span>首页</span>
                <span>&laquo;</span>
                <span>${videopage.current}/${videopage.pages}</span>
            <#else>
                <a href="/video?toPage=0">首页</a>
                <a href="/video?toPage=${videopage.current-1}">&laquo;</a>
                <span>${videopage.current}/${videopage.pages}</span>
            </#if>
            <#if videopage.current gte videopage.pages>
                <span>&raquo;</span>
                <span>尾页</span>
            <#else>
                <a href="/video?toPage=${videopage.current+1}">&raquo;</a>
                <a href="/video?toPage=${videopage.pages-1}">尾页</a>
            </#if>
        </div>
        <!--翻页结束-->
        </#if>
    </div>

    <div>
        <div class="row marketing">
            <#if filelist?exists>
                <h3><span>文档</span></h3>
                <!--文档遍历开始-->
                <#list filelist as filelist>
                    <div class="col-lg-4">
                        <#if filelist.ziliaosuffix == ".doc" || filelist.ziliaosuffix == ".docx">
                            <p>
                                <a href="">
                                    <img src="../static/images/word图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if filelist.ziliaosuffix == ".xls" || filelist.ziliaosuffix == ".xlsx">
                            <p>
                                <a href="">
                                    <img src="../static/images/excel图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if filelist.ziliaosuffix == ".ppt" || filelist.ziliaosuffix == ".pptx">
                            <p>
                                <a href="">
                                    <img src="../static/images/ppt图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if filelist.ziliaosuffix == ".rar" || filelist.ziliaosuffix == ".zip">
                            <p>
                                <a href="">
                                    <img src="../static/images/rar图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if filelist.ziliaosuffix == ".pdf">
                            <p>
                                <a href="">
                                    <img src="../static/images/pdf图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if filelist.ziliaosuffix == ".txt">
                            <p>
                                <a href="">
                                    <img src="../static/images/txt图标.png" style="width: 250px; height: 200px"
                                         alt="${filelist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <h4>
                            <a href="">
                                【文档】${filelist.ziliaoname}
                            </a>
                        </h4>
                        <p>上传于${filelist.ziliaouploadtime}</p>
                        <p>点击：${filelist.ziliaoclick}</p>
                    </div>
                </#list>
                <!--文档遍历结束-->
            </#if>
        </div>
        <#if filepage?exists>
            <!--翻页开始-->
            <div class="pagination-lg">
                <#if filepage.current lte 1>
                    <span>首页</span>
                    <span>&laquo;</span>
                    <span>${filepage.current}/${filepage.pages}</span>
                <#else>
                    <a href="/file?toPage=0">首页</a>
                    <a href="/file?toPage=${filepage.current-1}">&laquo;</a>
                    <span>${filepage.current}/${filepage.pages}</span>
                </#if>
                <#if filepage.current gte filepage.pages>
                    <span>&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/file?toPage=${filepage.current+1}">&raquo;</a>
                    <a href="/file?toPage=${filepage.pages-1}">尾页</a>
                </#if>
            </div>
            <!--翻页结束-->
        </#if>
    </div>

    <div>
        <div class="row marketing">
            <#if discusslist?exists>
                <h3><span>论坛</span></h3>
                <!--论坛遍历开始-->
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
                                <td><a href="/user_disdetail?disid=${discusslist.discussid}">${discusslist.discussname}</a></td>
                                <td>${discusslist.creator}</td>
                                <td>${discusslist.createtime}</td>
                                <td>被${discusslist.commentcount}次讨论</td>
                                <td>
                                    <a class="btn-info" href="/user_disdetail?disid=${discusslist.discussid}">查看详情</a>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
                <!--论坛遍历结束-->
            </#if>
        </div>
        <#if discusspage?exists>
            <!--翻页开始-->
            <div class="pagination-lg">
                <#if discusspage.current lte 1>
                    <span>首页</span>
                    <span>&laquo;</span>
                    <span>${discusspage.current}/${discusspage.pages}</span>
                <#else>
                    <a href="/discuss?toPage=0">首页</a>
                    <a href="/discuss?toPage=${discusspage.current-1}">&laquo;</a>
                    <span>${discusspage.current}/${discusspage.pages}</span>
                </#if>
                <#if discusspage.current gte discusspage.pages>
                    <span>&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/discuss?toPage=${discusspage.current+1}">&raquo;</a>
                    <a href="/discuss?toPage=${discusspage.pages-1}">尾页</a>
                </#if>
            </div>
            <!--翻页结束-->
        </#if>
    </div>

    <div>
        <div class="row marketing">
            <#if ziliaolist?exists>
                <h3><span>资料</span></h3>
                <!--文档遍历开始-->
                <#list ziliaolist as ziliaolist>
                    <div class="col-lg-4">
                        <#if ziliaolist.ziliaotype == 1>
                            <p>
                                <a href="">
                                    <img src="static/${ziliaolist.ziliaocoverpath}" style="width: 300px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".doc" || ziliaolist.ziliaosuffix == ".docx">
                            <p>
                                <a href="">
                                    <img src="../static/images/word图标.png" style="width: 300px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".xls" || ziliaolist.ziliaosuffix == ".xlsx">
                            <p>
                                <a href="">
                                    <img src="../static/images/excel图标.png" style="width: 300px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".ppt" || ziliaolist.ziliaosuffix == ".pptx">
                            <p>
                                <a href="">
                                    <img src="../static/images/ppt图标.png" style="width: 300px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".rar" || ziliaolist.ziliaosuffix == ".zip">
                            <p>
                                <a href="">
                                    <img src="../static/images/rar图标.png" style="width: 300px; height: 200px"
                                         alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".pdf">
                            <p>
                                <a href="">
                                    <img src="../static/images/pdf图标.png" style="width: 300px; height: 200px"
                                     alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <#if ziliaolist.ziliaosuffix == ".txt">
                            <p>
                                <a href="">
                                    <img src="../static/images/txt图标.png" style="width: 300px; height: 200px"
                                         alt="${ziliaolist.ziliaoname}">
                                </a>
                            </p>
                        </#if>
                        <h4>
                            <a href="">
                                <#if ziliaolist.ziliaotype == 1>【视频】${ziliaolist.ziliaoname}</#if>
                                <#if ziliaolist.ziliaotype == 2>【文档】${ziliaolist.ziliaoname}</#if>
                            </a>
                        </h4>
                        <p>上传于：${ziliaolist.ziliaouploadtime}</p>
                        <p>点击：${ziliaolist.ziliaoclick}</p>
                    </div>
                </#list>
                <!--资料遍历结束-->
            </#if>
        </div>
        <#if ziliaopage?exists>
            <!--翻页开始-->
            <div class="pagination-lg">
                <#if ziliaopage.current lte 1>
                    <span>首页</span>
                    <span>&laquo;</span>
                    <span>${ziliaopage.current}/${ziliaopage.pages}</span>
                <#else>
                    <a href="/index?toPage=0">首页</a>
                    <a href="/index?toPage=${ziliaopage.current-1}">&laquo;</a>
                    <span>${ziliaopage.current}/${ziliaopage.pages}</span>
                </#if>
                <#if ziliaopage.current gte ziliaopage.pages>
                    <span>&raquo;</span>
                    <span>尾页</span>
                <#else>
                    <a href="/index?toPage=${ziliaopage.current+1}">&raquo;</a>
                    <a href="/index?toPage=${ziliaopage.pages-1}">尾页</a>
                </#if>
            </div>
            <!--翻页结束-->
        </#if>
    </div>
</div>
<!-- /container -->
<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../static/bootstrap/js/bootstrap.min.js"></script>
<script>

</script>
</body>
</html>