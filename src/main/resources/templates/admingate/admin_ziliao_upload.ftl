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
    <!--header start-->
    <#include "/admin_header"/>
    <!--header end-->

    <!--body start-->
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div>
            <span><h2>视频上传</h2></span>
            <a href="/admin_ziliaolist" class="label-info">返回上层</a>
            <span><font color="red">${ziliao_error!}</font></span>
        </div>
        <!--新增表格-->
        <div class="layui-table-body">
            <form enctype="multipart/form-data" method="post" id="ziliao_upload" class="layui-form" action="/admin_uploadziliao">
                <div class="layui-form-item">
                    <label class="layui-form-label">资料名称：</label>
                    <div class="layui-input-inline shortInput">
                        <input type="text" id="ziliao_name" name="ziliao_name" required autocomplete="off"
                               class="layui-input" placeholder="名称限定30字内" onchange="CheckZiliaoName()">
                        <span id="name_error"></span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">资料类型：</label>
                    <div class="layui-form-radio">
                        <input type="radio" name="ziliaotype" id="ziliaotype" value="1" checked>视频&nbsp;
                        <input type="radio" name="ziliaotype" id="ziliaotype" value="2">文档
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">视频封面：</label>
                    <div class="layui-input-inline">
                        <input onchange="imgchange(this)" type="file" id="pic_upload" name="cover"
                               class="layui-upload-button" accept=".jpg,.jpeg,.png">
                        <span id="videocover_error"></span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">封面预览：</label>
                    <div class="layui-input-inline">
                        <img id="uploaded_pic" src="../../static/images/default.png" style="width: 200px; height: 200px;"/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">资料上传：</label>
                    <div class="layui-input-inline">
                        <input type="file" name="docsource" id="docsource" style="display: none;" onchange="CheckDocsourceSize()"
                               accept=".doc,.docx,.ppt,.pptx,.xls,.xlsx,.pdf,.txt,.rar,.zip"
                               class="layui-icon-upload">
                        <input type="file" name="videosource" id="videosource" style="display: " onchange="CheckVideosourceSize()"
                               accept=".mp4,.blv,.avi" class="layui-icon-upload">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">视频简介</label>
                    <div class="layui-input-block">
                        <textarea name="videoabstract" placeholder="这里输入视频简介" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input type="submit" value="上传" class="layui-btn">
                        <button type="reset" class="layui-btn layui-btn-primary">清空</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--body end-->
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
        if($("#pic_upload").get(0).files[0].size > 1024*1024*10){
            $("#videocover_error").html("* 图片封面不能超过10M");
            $("#videocover_error").css("color", "red");
        }else{
            //获取点击的文本框
            var file = document.getElementById("pic_upload");
            var imgurl = window.URL.createObjectURL(file.files[0]);
            var img = document.getElementById('uploaded_pic');
            img.setAttribute('src', imgurl);//修改img标签src属性值
            $("#videocover_error").html("");
            $("#videocover_error").css("color", "");
        }
    }
    //选择文档时把封面hide掉
    $('input[name="ziliaotype"]').change(function () {
            var imgurl = "../../static/images/default.png";
            var img = document.getElementById('uploaded_pic');
            if($('input[name="ziliaotype"]:checked').val() === '2'){
                img.setAttribute('src', imgurl);
                $("#pic_upload").val('');
                $("#pic_upload").attr("disabled", "true");
                $("#videosource").hide();
                $("#docsource").show();
                $("#uploadtips").html("关于文档要求：仅限WORD，EXCEL，PPT，PDF，TXT，RAR，ZIP。且大小不得超过50M");
            }
            if($('input[name="ziliaotype"]:checked').val() === '1'){
                $("#pic_upload").removeAttr("disabled");
                $("#videosource").show();
                $("#docsource").hide();
                $("#uploadtips").html("关于视频要求：仅限MP4，AVI，BLV结尾。且大小不得超过900M");
            }
        }
    );

</script>
</body>
</html>