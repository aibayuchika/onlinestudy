<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>testpage</title>
<#--    <link rel="stylesheet" type="text/css" href="../../static/layui/css/layui.css">-->
    <script type="text/javascript" src="../../static/jquery/jquery.1.8.3.min.js"></script>
<#--    <script type="text/javascript" src="jquery"-->
</head>
<body>
<#list videolist as videolist>
    <p>视频名：${videolist.videoname}</p>
</#list>

<div>
    <#if page.current lte 1>
        <span>首页</span>
        <span>上一页</span>
    <#else>
        <a href="/video?toPage=0">首页</a>
        <a href="/video?toPage=${page.current-1}">上一页</a>
    </#if>
    <div>
        <span>${page.current}/${page.getTotal()}</span>
    </div>
    <#if page.current gte page.total>
        <span>下一页</span>
        <span>尾页</span>
    <#else>
        <a href="/video?toPage=${page.current+1}">下一页</a>
        <a href="/video?toPage=${page.total-1}">尾页</a>
    </#if>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="createdisModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">创建论坛</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <form id="discussmsg">
                        <div>
                            <label class="label label-info">论坛名：</label>
                            <input type="text" name="discussname" class="input-lg">
                        </div>
                        <div>
                            <label class="label label-info">提个问：</label>
                            <textarea style="width: 250px; height: 100px;" name="discussabstract" placeholder="abstract"></textarea>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
                <button type="button" class="btn btn-primary" id="credis">提交创建</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</body>
</html>