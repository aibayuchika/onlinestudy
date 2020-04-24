package net.gdpu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import net.gdpu.entity.*;
import net.gdpu.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class IndexController {
    @Resource
    private OsUserService userService;
    @Resource
    private OsDiscussService discussService;
    @Resource
    private OsZiliaoService ziliaoService;

    @RequestMapping("/index")
    public String allZiliao(HttpSession session, Model model, Integer toPage){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOSTATUS, 4)
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPLOADTIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> ziliaoPage = ziliaoService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("ziliaolist", ziliaoPage.getRecords());
        model.addAttribute("ziliaopage", ziliaoPage);

        return "index";
    }

    //用户详情
    @RequestMapping("/userdetail")
    public String userdetail(Model model, HttpSession session, String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.eq("userid", userid);
        List<OsUser> userList = userService.selectList(entityWrapper);

        model.addAttribute("userlist", userList);
        return "usergate/user_detail";
    }

    //文档列表
    @RequestMapping("/file")
    public String filelist(HttpSession session, Model model, Integer toPage){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOSTATUS, 4)
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPLOADTIME}));
        /**
         * 按点击量查询之类
         * **/
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> filePage = ziliaoService.selectPage(
                new Page<>(toPage, 10), entityWrapper);
        model.addAttribute("filepage", filePage);
        model.addAttribute("filelist", filePage.getRecords());

        return "index";
    }

    //视频列表
    @RequestMapping("/video")
    public String videolist(HttpSession session, Model model, Integer toPage){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOSTATUS, 4)
                .orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPLOADTIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> videoPage = ziliaoService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("videopage", videoPage);
        model.addAttribute("videolist", videoPage.getRecords());
        session.setAttribute("videopoint", 3);

        return "index";
    }

    //论坛列表
    @RequestMapping("/discuss")
    public String discusslist(Model model, HttpSession session, Integer toPage){
        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsDiscuss.CREATETIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsDiscuss> discussPage = discussService.selectPage(
                new Page<>(toPage, 15), entityWrapper);
        model.addAttribute("discusspage", discussPage);
        model.addAttribute("discusslist", discussPage.getRecords());
        session.setAttribute("dispoint" , 2);
        return "index";
    }

    //查看该用户创建的所有论坛
    @RequestMapping("/userdiscuss")
    public String userdiscusslist(HttpSession session, Model model, Integer toPage){
        //获取用户
        OsUser user = (OsUser) session.getAttribute("user");
        //获取用户id
        String userid = user.getUserid();

        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq("creatorid", userid)
                .orderDesc(Arrays.asList(new String[]{"createtime"}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsDiscuss> discussPage = discussService.selectPage(
                new Page<>(toPage, 6), entityWrapper);
        model.addAttribute("discusspage", discussPage);
        model.addAttribute("discusslist", discussPage.getRecords());
        session.setAttribute("dispoint", 3);
        return "userdetail";
    }

    //index查询
//    @RequestMapping("/searchvifi")
//    public String searchvifinopage(Model model, String key, Integer type, Integer toPage, HttpSession session){
//        System.out.println("all keyword : " + key + ", " + "search type : " + type);
//        session.setAttribute("searchkey", key);
//        session.setAttribute("searchtype", type);
//        if(type.equals(1)){//搜索视频
//            List<OsVideo> videoList = new ArrayList<>();
//            Set<OsVideo> set = new HashSet<>();
//            for(int j = 0; j < key.length() ; j++){
//                EntityWrapper<OsVideo> videoWrapper = new EntityWrapper<>();
//                videoWrapper.like(OsVideo.VIDEONAME, String.valueOf(key.charAt(j)))
//                        .orderDesc(Arrays.asList(new String[]{"uploadtime"}));
//                List<OsVideo> temp = videoService.selectList(videoWrapper);
//                set.addAll(temp);
//            }
//            if(toPage == null){
//                toPage = 0;
//            }
//            videoList.addAll(set);
//            Page<OsVideo> videoPage = new Page<>(toPage, 1);
//            videoPage.setRecords(videoList);
//            videoPage.setTotal(videoList.size());
//
//            System.out.println(videoPage.toString());
//            model.addAttribute("searchvlist", videoPage.getRecords());
//            model.addAttribute("searchpage", videoPage);
//            return "index";
//        } else if (type.equals(2)) {
//            List<OsFile> fileList = new ArrayList<>();
//            Set<OsFile> set = new HashSet<>();
//            for(int k = 0; k < key.length(); k++){
//                EntityWrapper<OsFile> fileWrapper = new EntityWrapper<>();
//                fileWrapper.like(OsFile.FILENAME, String.valueOf(key.charAt(k)))
//                        .orderDesc(Arrays.asList(new String[]{"uploadtime"}));
//                List<OsFile> temp = fileService.selectList(fileWrapper);
//                set.addAll(temp);
//            }
//            fileList.addAll(set);
//            model.addAttribute("searchflist", fileList);
//            return "index";
//        }
//
//        return "index";
//    }

}
