package net.gdpu.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import net.gdpu.entity.OsAnnounce;
import net.gdpu.entity.OsUser;
import net.gdpu.mapper.OsAnnounceDao;
import net.gdpu.service.OsAnnounceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lekhvia
 * @since 2020-02-20
 */
@Controller
//@RequestMapping("/osAnnounce")
public class AnnounceController {
    @Resource
    private OsAnnounceService announceService;

    //发布公告
    @RequestMapping("/adminaddannounce")
    public String adminaddannounce(HttpSession session, String announcename, String announcemsg){
        //获取用户
        OsUser user = (OsUser) session.getAttribute("user");
        String username = user.getUsername();
        //获取上传时间
        Date nowtime = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String uploadtime = sdf.format(nowtime);
        //插入数据库
        OsAnnounce announce = new OsAnnounce();
        announce.setAnnouncename(announcename);
        announce.setAnnouncemsg(announcemsg);
        announce.setAnnoucestatus(1);
        announce.setAnnouncer(username);
        announce.setAnnouncetime(uploadtime);
        boolean result = announceService.insert(announce);
        System.out.println(result);
        if(result){
            System.out.println("成功");
            return "/adminannounce";
        }else {
            System.out.println("失败");
            return "/adminannounce";
        }
    }
    //查询公告
    @RequestMapping("/adminannounce")
    public String adminannounce(Model model, Integer toPage){
        EntityWrapper<OsAnnounce> entityWrapper = new EntityWrapper<OsAnnounce>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{"uploadtime"}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsAnnounce> announcePage = announceService.selectPage(
                new Page<>(toPage, 8), entityWrapper);
        System.out.println(announcePage.getRecords());
        model.addAttribute("page", announcePage);
        model.addAttribute("announcelist", announcePage.getRecords());
        return "admingate/aannounce";
    }
    //查找一个通知
    @RequestMapping("/adminsearchannounce")
    public String searchannounce(Model model, String userid){
        EntityWrapper<OsAnnounce> entityWrapper = new EntityWrapper<OsAnnounce>();
        entityWrapper.eq("announcer", userid);
        List<OsAnnounce> announcelist = announceService.selectList(entityWrapper);
        System.out.println(announcelist);
        model.addAttribute("announcelist", announcelist);
        return "admingate/aannounce";
    }
    //查看一个文档的详细
    @RequestMapping("/adminannouncedetail")
    public String filedetails(Model model, Integer announceid){
        EntityWrapper<OsAnnounce> entityWrapper = new EntityWrapper<OsAnnounce>();
        entityWrapper.eq("announceid", announceid);
        List<OsAnnounce> announceList = announceService.selectList(entityWrapper);
        System.out.println(announceList);
        model.addAttribute("announcelist", announceList);
        return "admingate/announcedetail";
    }
}

