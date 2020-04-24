package net.gdpu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import net.gdpu.entity.*;
import net.gdpu.service.OsDianzanService;
import net.gdpu.service.OsZiliaoService;
import net.gdpu.service.OsZiliaotagService;
import net.gdpu.utils.TransToPdf;
import net.gdpu.utils.UUIDUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class UserZiliaoController {
    @Resource
    private OsZiliaoService ziliaoService;
    @Resource
    private OsDianzanService dianzanService;
    @Resource
    private OsZiliaotagService ziliaotagService;

    @RequestMapping("/user2upload")
    public String toUseruploadPage(){
        return "user_upload";
    }
    //资料上传
    @RequestMapping("/useruploadziliao")
    public String useruploadziliao(Model model, Integer ziliaotype, String ziliaoname, String ziliaotag,
                                   @RequestParam MultipartFile ziliaocover, @RequestParam MultipartFile videosource,
                                   @RequestParam MultipartFile docsource, String ziliaoabs, HttpSession session){
        //获取用户
        OsUser user = (OsUser) session.getAttribute("user");
        String userid = user.getUserid();
        String username = user.getUsername();
        //封面原名、后缀
        String coverOriginalName = ziliaocover.getOriginalFilename().trim();
        String coverSuffix = coverOriginalName.substring(coverOriginalName.lastIndexOf("."));
        //视频原名、后缀、大小
        String videoOriginalName = videosource.getOriginalFilename().trim();
        String videoSuffix = videoOriginalName.substring(videoOriginalName.lastIndexOf("."));
        double videosize = videosource.getSize()/1024;//单位是kb
        //文档原名及后缀
        String docsourceOriginalName = docsource.getOriginalFilename().trim();
        String docsourceSuffix = docsourceOriginalName.substring(docsourceOriginalName.lastIndexOf("."));
        double docsourcesize = docsource.getSize()/1024;//单位是kb
        //获取时间
        Date nowzeit = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String zeit = sdf.format(nowzeit);

        if(ziliaotype == 1){
            //创建服务器地址
            String coverPath = "F:/uploadFile/coverimgs/";
            File coverfile = new File(coverPath);
            if(!coverfile.exists()){
                coverfile.mkdirs();
            }
            String videoPath = "F:/uploadFile/videos/";
            File videofile = new File(videoPath);
            if(!videofile.exists()){
                videofile.mkdirs();
            }

            //创建UUID
            String UUID = UUIDUtil.getRandomUUID(userid + username + zeit + videoOriginalName);
            //设置视频封面路径
            String coverCompletePath = coverPath + UUID + coverSuffix;
            String coverRelativePath = "coverimgs/" + UUID + coverSuffix;
            //设置视频路径
            String videoCompletePath = videoPath + UUID + videoSuffix;
            String videoRelativePath = "videos/" + UUID + videoSuffix;
            //放入服务器
            File coverFile = new File(coverCompletePath);
            File videoFile = new File(videoCompletePath);
            try{
                ziliaocover.transferTo(coverFile);
                videosource.transferTo(videoFile);
            } catch (Exception e){
                e.printStackTrace();
            }
            //数据库操作
            String returnword = useruploadvideo(ziliaoname, videoRelativePath, videoSuffix,
                    coverRelativePath, coverSuffix, ziliaoabs, user, UUID, videosize, zeit,
                    ziliaotag);
            if(returnword.equals("success")){
                model.addAttribute("upload_msg", "当前上传成功！");
                return "redirect:/useruploadPage";
            }else {
                model.addAttribute("upload_msg", "上传失败，请检查网络是否异常。");
                return "redirect:/useruploadPage";
            }
        }else {
            //创建服务器地址
            String docPath = "F:/uploadFile/files/";
            File docFile = new File(docPath);
            if(!docFile.exists()){
                docFile.mkdirs();
            }
            String previewPath = "F:/uploadFile/previews/";
            File previewFile = new File(previewPath);
            if(!previewFile.exists()){
                previewFile.mkdirs();
            }
            //创建UUID
            String UUID = UUIDUtil.getRandomUUID(userid + username + zeit + docsourceOriginalName);
            //设置文档路径
            String docsourceCompletePath = docPath + UUID + docsourceSuffix;
            String docsourceRelativePath = "coverimgs/" + UUID + coverSuffix;
            //放入“服务器”
            File desFile = new File(docsourceCompletePath);
            try {
                docsource.transferTo(desFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            //创建previews
            String filepreviewsralativePath = null;
            if(docsourceSuffix.equals(".pdf")){
                filepreviewsralativePath = "files/" + UUID + ".pdf";

            }else {
                String returnword = TransToPdf.trans2Pdf(docsourceCompletePath, UUID);
                if(returnword.equals("sourcemiss")){
                    model.addAttribute("upload_msg", "源文件似乎为空！");
                    return "redirect:/useruploadPage";
                }
                if(returnword.equals("fail")){
                    model.addAttribute("upload_msg", "文件上传失败！请稍后再试！");
                    return "redirect:/useruploadPage";
                }
                if(returnword.equals("success")){
                    filepreviewsralativePath = "previews/" + UUID + ".pdf";
                }
            }
            String returnword = useruploaddoc(ziliaoname, docsourceRelativePath, docsourceSuffix,
                    filepreviewsralativePath, ziliaoabs, user, ziliaotag, UUID, docsourcesize, zeit);
            if(returnword.equals("success")){
                model.addAttribute("upload_msg", "当前上传成功！");
                return "redirect:/useruploadPage";
            }else {
                model.addAttribute("upload_msg", "上传失败，请检查网络是否异常。");
                return "redirect:/useruploadPage";
            }
        }
    }

    //视频上传
    public String useruploadvideo(String ziliaoname, String videoRelativePath, String videoSuffix,
                                  String coverRelativePath, String coverSuffix, String videoabs,
                                  OsUser user, String UUID, double videosize, String nowzeit,
                                  String ziliaotag){
        System.out.println("视频相对路径：" + videoRelativePath + " , 视频后缀：" + videoSuffix);
        System.out.println("视频封面相对路径：" + coverRelativePath + " , 封面后缀：" + coverSuffix);
        OsZiliao ziliao_video = new OsZiliao();
        ziliao_video.setZiliaoabstract(videoabs);
        ziliao_video.setZiliaoclick(0);
        ziliao_video.setZiliaocoverpath(coverRelativePath);
        ziliao_video.setZiliaofailreason("待审核");
        ziliao_video.setZiliaoheat(0.0);
        ziliao_video.setZiliaoid(UUID);
        ziliao_video.setZiliaoname(ziliaoname);
        ziliao_video.setZiliaopreviewpath(videoRelativePath);
        ziliao_video.setZiliaosize(videosize);
        ziliao_video.setZiliaosourcepath(videoRelativePath);
        ziliao_video.setZiliaostatus(5);//5为审核中
        ziliao_video.setZiliaosuffix(videoSuffix);
        ziliao_video.setZiliaotag(ziliaotag);
        ziliao_video.setZiliaotan(0);
        ziliao_video.setZiliaozan(0);
        ziliao_video.setZiliaouploadtime(nowzeit);
        ziliao_video.setZiliaoupdatorname(user.getUsername());
        ziliao_video.setZiliaoupdatorid(user.getUserid());
        ziliao_video.setZiliaotype(1);
        ziliao_video.setZiliaoupdatetime(nowzeit);

        boolean result = ziliaoService.insert(ziliao_video);
        if(result){
            return "success";
        }else {
            return "fail";
        }
    }

    //文档上传
    public String useruploaddoc(String ziliaoname, String docsourceRelativePath, String docsourceSuffix,
                              String previewsRelativePath, String ziliaoabs, OsUser user, String ziliaotag,
                              String UUID, double docsourcesize, String nowzeit){
        System.out.println("视频相对路径：" + docsourceRelativePath + " , 视频后缀：" + docsourceSuffix);
        System.out.println("视频封面相对路径：" + previewsRelativePath);
        OsZiliao ziliao_doc = new OsZiliao();
        ziliao_doc.setZiliaoabstract(ziliaoabs);
        ziliao_doc.setZiliaoclick(0);
        ziliao_doc.setZiliaocoverpath("无");
        ziliao_doc.setZiliaofailreason("待审核");
        ziliao_doc.setZiliaoheat(0.0);
        ziliao_doc.setZiliaoid(UUID);
        ziliao_doc.setZiliaoname(ziliaoname);
        ziliao_doc.setZiliaopreviewpath(previewsRelativePath);
        ziliao_doc.setZiliaosize(docsourcesize);
        ziliao_doc.setZiliaosourcepath(docsourceRelativePath);
        ziliao_doc.setZiliaostatus(5);//5为审核中
        ziliao_doc.setZiliaosuffix(docsourceSuffix);
        ziliao_doc.setZiliaotag(ziliaotag);
        ziliao_doc.setZiliaotan(0);
        ziliao_doc.setZiliaozan(0);
        ziliao_doc.setZiliaouploadtime(nowzeit);
        ziliao_doc.setZiliaoupdatorname(user.getUsername());
        ziliao_doc.setZiliaoupdatorid(user.getUserid());
        ziliao_doc.setZiliaotype(2);
        ziliao_doc.setZiliaoupdatetime(nowzeit);

        boolean result = ziliaoService.insert(ziliao_doc);
        if(result){
            return "success";
        }else {
            return "fail";
        }
    }

    //资料删除
    @RequestMapping("/userdelziliao")
    public String userdelziliao(Model model, String ziliaoID){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoID);
        OsZiliao ziliao = ziliaoService.selectOne(entityWrapper);

        int ziliaotype = ziliao.getZiliaotype();
        if(ziliaotype == 1){
            String coverPath = ziliao.getZiliaocoverpath();
            String videoPath = ziliao.getZiliaosourcepath();

            File coverFile = new File("F:/uploadFile/" + coverPath);
            File videoFile = new File("F:/uploadFile/" + videoPath);
            boolean mysqldelresult = ziliaoService.delete(entityWrapper);
            if(mysqldelresult){
                boolean coverdelresult = coverFile.delete();
                boolean videodelresult = videoFile.delete();

                if(coverdelresult && videodelresult){
                    model.addAttribute("videlmsg", "删除成功！");
                    return "redirect:/uservideo";
                }else {
                    model.addAttribute("videlmsg", "删除失败！");
                    return "redirect:/uservideo";
                }
            }else {
                model.addAttribute("videlmsg", "删除失败！");
                return "redirect:/uservideo";
            }
        }else{
            String filesourcePath = ziliao.getZiliaosourcepath();
            String filepreviewPath = ziliao.getZiliaopreviewpath();
            File sourceFile = new File("F:/uploadFile/" + filesourcePath);

            if(filesourcePath.equals(filepreviewPath)){
                boolean delmysqlresult = ziliaoService.delete(entityWrapper);
                if(delmysqlresult){
                    boolean delfileresult = sourceFile.delete();
                    if(delfileresult){
                        model.addAttribute("delfilemsg", "文档删除成功！");
                        return "redirect:/userdoc";
                    }
                }else {
                    model.addAttribute("delfilemsg", "文档删除失败！");
                    return "redirect:/userdoc";
                }
            }else {
                File previewFile = new File("F:/uploadFile/" + filepreviewPath);
                boolean delmysqlresult = ziliaoService.delete(entityWrapper);

                if(delmysqlresult){
                    boolean delfileresult = sourceFile.delete();
                    boolean delpreviewresult = previewFile.delete();
                    if(delfileresult && delpreviewresult){
                        model.addAttribute("delfilemsg", "文档删除成功！");
                        return "redirect:/userdoc";
                    }
                }else {
                    model.addAttribute("delfilemsg", "文档删除失败！");
                    return "redirect:/userdoc";
                }
            }
            model.addAttribute("delfilemsg", "文档删除失败！");
            return "redirect:/userdoc";
        }
    }

    //修改前的进入文档
    @RequestMapping("/user2update")
    public String user2update(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        List<OsZiliao> ziliaoList = ziliaoService.selectList(entityWrapper);
        model.addAttribute("ziliaolist", ziliaoList);
        return "user_ziliaoupdate";
    }

    //资料修改
    @RequestMapping("/userupdateziliao")
    public String userupdateziliao(Model model, String ziliaoid, String ziliaoname,
                                   Integer ziliaotag, String ziliaoabs){
        //获取时间
        Date zeit = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowzeit = sdf.format(zeit);

        //获取tag名称
        EntityWrapper<OsZiliaotag> tagEW = new EntityWrapper<>();
        tagEW.eq(OsZiliaotag.TAGID, ziliaotag);
        OsZiliaotag osZiliaotag = ziliaotagService.selectOne(tagEW);
        String newtagname = osZiliaotag.getTagname();

        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(entityWrapper);
        String oldziliaotag = ziliao.getZiliaotag();
        String newziliaotag = null;
        if(ziliaotag == 0){
            newziliaotag = oldziliaotag;
        }else {
            newziliaotag = newtagname;
        }
        ziliao.setZiliaoupdatetime(nowzeit);
        ziliao.setZiliaotag(newziliaotag);
        ziliao.setZiliaoabstract(ziliaoabs);
        ziliao.setZiliaoname(ziliaoname);

        boolean ziliaoupresult = ziliaoService.update(ziliao, entityWrapper);
        if(ziliaoupresult){
            model.addAttribute("update_msg", "当前资料修改成功！");
            return "redirect:/user2update?ziliaoid=" + ziliaoid;
        }else {
            model.addAttribute("update_msg", "当前资料修改失败！");
            return "redirect:/user2update?ziliaoid=" + ziliaoid;
        }
    }

    //主页查看资料
    @RequestMapping("/index_ziliao")
    public String indexziliao(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        List<OsZiliao> ziliaoList = ziliaoService.selectList(entityWrapper);
        model.addAttribute("ziliaolist", ziliaoList);
        return "indexziliao";
    }

    //查看该用户上传的所以文档
    @RequestMapping("/userdoc")
    public String userdoclist(HttpSession session, Model model, Integer toPage, String userid){
        //打上标志点，管理员进入docpoint=1，user自己界面docpoint=2，主页进去docpoint=3
        int docpoint = 2;

        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOUPDATORID, userid)
                .eq(OsZiliao.ZILIAOTYPE, 2)
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPLOADTIME}))
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOSTATUS}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> filePage = ziliaoService.selectPage(
                new Page<>(toPage, 10), entityWrapper);
        model.addAttribute("filepage", filePage);
        model.addAttribute("filelist", filePage.getRecords());
        session.setAttribute("docpoint", docpoint);
        return "user_detail";
    }

    //查看该用户上传所有的视频
    @RequestMapping("/uservideo")
    public String uservideolist(HttpSession session, Model model, Integer toPage, String userid){
        //打上标志点，管理员进入videopoint=1，user自己界面videopoint=2，主页进去videopoint=3
        int videopoint = 2;

        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper
                .eq(OsZiliao.ZILIAOTYPE, 1)
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPLOADTIME}))
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOSTATUS}))
                .eq(OsZiliao.ZILIAOUPDATORID, userid);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> videoPage = ziliaoService.selectPage(
                new Page<>(toPage, 6), entityWrapper);
        model.addAttribute("videopage", videoPage);
        model.addAttribute("videolist", videoPage.getRecords());
        session.setAttribute("videopoint", videopoint);
        return "user_detail";
    }

    //预览文档用
    @RequestMapping("/detailsearch")
    public void detailsearch(HttpServletResponse response, HttpSession session, String ziliaoid) throws IOException {
        EntityWrapper<OsZiliao> fileEntityWrapper = new EntityWrapper<>();
        fileEntityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(fileEntityWrapper);
        String filepreviewpath = ziliao.getZiliaopreviewpath();

        if(filepreviewpath != null && !(filepreviewpath.equals(""))){
            response.getWriter().write("success");
            session.setAttribute("previewpath", filepreviewpath);
        }
    }
    //预览文档用
    @RequestMapping("/filedetail")
    public void fdetail(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        String filepreviewpath = (String) session.getAttribute("previewpath");
        System.out.println(filepreviewpath);
        String thepath = "F:/uploadFile/";
        System.out.println(thepath + filepreviewpath);
        File file = new File(thepath + filepreviewpath);
        if(file.exists()){
            byte[] data = null;
            FileInputStream fis = null;
            try {
                fis = new FileInputStream(file);
                data = new byte[fis.available()];
                fis.read(data);
                response.getOutputStream().write(data);
                session.removeAttribute("previewpath");
            } catch (Exception e) {
                System.out.println("pdf文件处理异常：" + e);
            } finally {
                try{
                    if(fis != null){
                        fis.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }else {
            return;
        }
    }

    //资料点赞
    @RequestMapping("/ziliaodianzan")
    public String ziliao_dianzan(Model model, HttpSession session, String ziliaoid){
        OsUser user = (OsUser) session.getAttribute("user");

        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(ziliaoEntityWrapper);
        int old_ziliaozan = ziliao.getZiliaozan();

        String returnword = dianzan_check(user.getUserid(), ziliaoid);
        if(returnword.equals("been_dian")){
            model.addAttribute("dian_msg", "当前已点过赞了");
            return "redirect:/index_ziliao/?ziliaoid=" + ziliaoid;
        }else {
            ziliao.setZiliaozan(old_ziliaozan + 1);
            boolean result = ziliaoService.update(ziliao, ziliaoEntityWrapper);

            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String zeit = sdf.format(date);
            OsDianzan dianzan = new OsDianzan();
            dianzan.setDianStatus(1);
            dianzan.setDianTime(zeit);
            dianzan.setDianUserid(user.getUserid());
            dianzan.setDianZiliao(ziliaoid);
            boolean result1 = dianzanService.insert(dianzan);

            if(result && result1){
                model.addAttribute("dian_msg", "点赞成功");
                return "redirect:/index_ziliao/?ziliaoid=" + ziliaoid;
            }
        }
        model.addAttribute("dian_msg", "当前网络异常");
        return "redirect:/index_ziliao/?ziliaoid=" + ziliaoid;
    }
    public String dianzan_check(String userid, String ziliaoid){
        EntityWrapper<OsDianzan> dianzanEntityWrapper = new EntityWrapper<>();
        dianzanEntityWrapper.eq(OsDianzan.DIAN_USERID, userid)
                .and()
                .eq(OsDianzan.DIAN_ZILIAO, ziliaoid)
                .and()
                .eq(OsDianzan.DIAN_STATUS, 1);
        int dianzannum = dianzanService.selectCount(dianzanEntityWrapper);
        if(dianzannum == 1){
            return "been_dian";
        }else {
            return "not_dian";
        }
    }

    //资料点弹
    @RequestMapping("/ziliaodiantan")
    public String ziliao_diantan(Model model, HttpSession session, String ziliaoid){
        OsUser user = (OsUser) session.getAttribute("user");

        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(ziliaoEntityWrapper);
        int old_ziliaotan = ziliao.getZiliaotan();

        String returnword = diantan_check(user.getUserid(), ziliaoid);
        if(returnword.equals("been_dian")){
            model.addAttribute("dian_msg", "当前已点过弹了");
            return "redirect:/index_ziliao/?ziliaoid=" + ziliaoid;
        }else {
            ziliao.setZiliaotan(old_ziliaotan + 1);
            boolean result = ziliaoService.update(ziliao, ziliaoEntityWrapper);

            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String zeit = sdf.format(date);
            OsDianzan dianzan = new OsDianzan();
            dianzan.setDianStatus(2);//2是弹
            dianzan.setDianTime(zeit);
            dianzan.setDianUserid(user.getUserid());
            dianzan.setDianZiliao(ziliaoid);
            boolean result1 = dianzanService.insert(dianzan);

            if(result && result1){
                model.addAttribute("dian_msg", "点弹成功");
                return "redirect:/index_ziliao?ziliaoid=" + ziliaoid;
            }
        }
        model.addAttribute("dian_msg", "当前网络异常");
        return "redirect:/index_ziliao?ziliaoid=" + ziliaoid;
    }
    public String diantan_check(String userid, String ziliaoid){
        EntityWrapper<OsDianzan> dianzanEntityWrapper = new EntityWrapper<>();
        dianzanEntityWrapper.eq(OsDianzan.DIAN_USERID, userid)
                .and()
                .eq(OsDianzan.DIAN_ZILIAO, ziliaoid)
                .and()
                .eq(OsDianzan.DIAN_STATUS, 2);
        int dianzannum = dianzanService.selectCount(dianzanEntityWrapper);
        if(dianzannum == 1){
            return "been_dian";
        }else {
            return "not_dian";
        }
    }

    //一键重投
    @RequestMapping("/user_reupload")
    public String user_reupload(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> ew = new EntityWrapper<>();
        ew.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(ew);
        ziliao.setZiliaofailreason("待审核");
        ziliao.setZiliaostatus(5);

        boolean result = ziliaoService.update(ziliao, ew);
        if(result){
            model.addAttribute("reupload_msg", "重投成功！");
            return "redirect:/userdoc";
        }else {
            model.addAttribute("reupload_msg", "重投失败！");
            return "redirect:/userdoc";
        }
    }
}
