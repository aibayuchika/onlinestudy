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

<div class="col-lg-3"></div>
<!--body start-->
<div class="container col-lg-6">
    <div>
        <span><h2>资料上传</h2></span>
        <span><a href=""><button class="btn btn-warning btn-sm">返回上层</button></a></span>
    </div>
    <div>
        <h3 id="uploadtips" style="color: orangered"></h3>
        <span style="color: #c67605">${upload_msg!""}</span>
    </div>
    <div>
        <form action="/useruploadziliao" enctype="multipart/form-data" method="post">
            <table class="table table-hover table-striped">
                <caption><font color="orange">来上传资料吧！</font></caption>
                <tr>
                    <td>您要上传：</td>
                    <td>
                        <input type="radio" name="ziliaotype" id="ziliaotype" value="1" checked>视频&nbsp;
                        <input type="radio" name="ziliaotype" id="ziliaotype" value="2">文档
                    </td>
                </tr>
                <tr>
                    <td>资料名称：</td>
                    <td>
                        <input type="text" name="ziliaoname" id="ziliaoname"
                               class="text-left" maxlength="30" onchange="CheckZiliaoName()"
                               placeholder="名称限定30字内" >
                    </td>
                    <td>
                        <span id="ziliaoname_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>视频封面：（图片最大10M，文档则无需）</td>
                    <td>
                        <input onchange="imgchange(this)" type="file" id="pic_upload" name="videocover"
                               accept=".jpg,.jpeg,.png">
                    </td>
                    <td>
                        <span id="videocover_error"></span>
    <#--                    <span style="color: red;"></span>-->
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <img id="uploaded_pic" src="../../static/images/default.png" style="width: 200px; height: 200px;"/>
                    </td>
                </tr>
                <tr>
                    <td>资料源泉：</td>
                    <td>
                        <input type="file" name="docsource" id="docsource" style="display: none;" onchange="CheckDocsourceSize()"
                               accept=".doc,.docx,.ppt,.pptx,.xls,.xlsx,.pdf,.txt,.rar,.zip">
                        <input type="file" name="videosource" id="videosource" style="display: " onchange="CheckVideosourceSize()"
                                accept=".mp4,.blv,.avi">
                    </td>
                    <td>
                        <span id="source_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>资料tag：</td>
                    <td>
                        <select style="height: 30px;width: 150px">
                            <option value="0" selected>—————</option>
                            <option value="1">Java</option>
                            <option value="2">语文</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>资料简介：</td>
                    <td>
                        <textarea class="text-left" style="width: 350px; height: 120px;" id="ziliaoabstract"
                                  name="ziliaoabstract" placeholder="资料简介150字限定"
                                  maxlength="150"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" class="btn btn-sm btn-warning" id="upziliaobtn" value="上传">
                    </td>
                    <td>
                        <button class="btn btn-sm btn-danger" name="resetbtn"
                                id="resetbtn" onclick="ResetBtn()">
                            重置
                        </button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!--body end-->
<div class="col-lg-3"></div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../static/bootstrap/js/jquery-2.1.4.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>

<script>
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
    };
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
    //上传资料前的检查
    //检查资料名
    function CheckZiliaoName() {
        var ziliaoname = $("#ziliaoname").val();
        if(ziliaoname === ''){
            alert("资料名称不能为空！");
            $("#ziliaoname_error").html("* 资料名不能为空！");
            $("#ziliaoname_error").css("color", "red");
        }else {
            $("#ziliaoname_error").html("");
            $("#ziliaoname_error").css("color", "");
        }
    }
    //检查docsource大小
    function CheckDocsourceSize() {
        if($("#docsource").get(0).files[0].size > 50*1024*1024){
            $("#source_error").html("文档大小不能超过50M！");
            $("#source_error").css("color", "red");
        }else {
            $("#source_error").html("");
            $("#source_error").css("color", "");
        }
    }//检查videosource大小
    function CheckVideosourceSize() {
        if($("#videosource").get(0).files[0].size > 999*1024*1024){
            $("#source_error").html("视频大小不能超过900M！");
            $("#source_error").css("color", "red");
        }else {
            $("#source_error").html("");
            $("#source_error").css("color", "");
        }
    }
    //resetbtn
    function ResetBtn() {
        var imgurl = "../../static/images/default.png";
        var img = document.getElementById('uploaded_pic');
        $("#ziliaoname").val('');
        $("#ziliaoabstract").val('');
        img.setAttribute('src', imgurl);
        $("#pic_upload").val('');
        $("#docsource").val('');
        $("#videosource").val('');
    }
</script>
</body>
</html>