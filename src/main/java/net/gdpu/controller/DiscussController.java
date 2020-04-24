package net.gdpu.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import net.gdpu.entity.OsDiscuss;
import net.gdpu.entity.OsFirstcomment;
import net.gdpu.entity.OsSecondcomment;
import net.gdpu.entity.OsUser;
import net.gdpu.service.OsDiscussService;
import net.gdpu.service.OsFirstcommentService;
import net.gdpu.service.OsSecondcommentService;
import net.gdpu.service.OsUserService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static net.gdpu.utils.UUIDUtil.getRandomUUID;
import static net.gdpu.utils.UUIDUtil.isValidUUID;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lekhvia
 * @since 2020-02-26
 */
@Controller
//@RequestMapping("/osDiscuss")
public class DiscussController {
    @Resource
    private OsUserService userService;
    @Resource
    private OsDiscussService discussService;
    @Resource
    private OsFirstcommentService firstcommentService;
    @Resource
    private OsSecondcommentService secondcommentService;

    //创建论坛
    @RequestMapping("/admin_creatediscuss")
    public String admin_creatediscuss(HttpSession session, String discussname, String discussabstract){
        //获取用户id
        OsUser user = (OsUser) session.getAttribute("user");
        String creator= user.getUsername();
        String creatorid = user.getUserid();
        //获取创建时间
        Date nowtime = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createtime = sdf.format(nowtime);
        System.out.println(createtime);
        //获取该论坛的UUID
        String disuuid = getRandomUUID(creator + createtime + discussname);
        System.out.println("UUID is " + disuuid);
        System.out.println("UUID is " + isValidUUID(disuuid));
        //数据库操作
        OsDiscuss discuss = new OsDiscuss();
        discuss.setDiscussid(disuuid);
        discuss.setDiscussname(discussname);
        discuss.setDiscussabstract(discussabstract);
        discuss.setCreator(creator);
        discuss.setCreatorid(creatorid);
        discuss.setCreatetime(createtime);
        discuss.setCommentcount(0);
        boolean result = discussService.insert(discuss);
        System.out.println(result);
        System.out.println(discuss);

        if(result) {
            System.out.println("创建成功");
            String discussid = discuss.getDiscussid();
            session.setAttribute("disid", discussid);
            return "/admindisdetail?disid=" + discussid;
        } else {
            System.out.println("创建失败");
            return "/admindiscuss";
        }
    }
    //普通进入创建论坛界面
    @RequestMapping("/tocreatediscuss")
    public String tocreateDiscuss(HttpSession session){
        int point = (int) session.getAttribute("dispoint");
        System.out.println("The dispoint is : " + point);
        return "studentgate/creatediscuss";
    }
    //普通创建论坛
    @RequestMapping("/user_creatediscuss")
    public String user_creatediscuss(Model model, HttpSession session, String discussname, String discussabstract){
        //判断discussname是否为空，abstrcact为空可以
        if(discussname == null || discussname.equals("")){
            model.addAttribute("discreateerror", "当前创建论坛失败");
            return "redirect:/userdiscuss";
        }
        if(discussabstract == null || discussabstract.equals("")){
            discussabstract = "无可奉告";
        }
        //获取用户id
        OsUser user = (OsUser) session.getAttribute("user");
        String creator= user.getUsername();
        String creatorid = user.getUserid();
        //获取创建时间
        Date nowtime = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createtime = sdf.format(nowtime);
        System.out.println(createtime);
        //获取该论坛的UUID
        String disuuid = getRandomUUID(creator + createtime + discussname);
        System.out.println("UUID is " + disuuid);
        System.out.println("UUID is " + isValidUUID(disuuid));
        //数据库操作
        OsDiscuss discuss = new OsDiscuss();
        discuss.setDiscussid(disuuid);
        discuss.setDiscussname(discussname);
        discuss.setDiscussabstract(discussabstract);
        discuss.setCreator(creator);
        discuss.setCreatorid(creatorid);
        discuss.setCreatetime(createtime);
        discuss.setCommentcount(0);
        boolean result = discussService.insert(discuss);
        System.out.println(result);
        System.out.println(discuss);

        if(result) {
            System.out.println("创建成功");
            String discussid = discuss.getDiscussid();
            session.setAttribute("disid", discussid);
            return "redirect:/disdetail?disid = " + discussid;
        } else {
            System.out.println("创建失败");
            model.addAttribute("discreateerror", "当前创建论坛失败");
            return "redirect:/tocreatediscuss";
        }
    }
    //管理员查看论坛详情
    @RequestMapping("/admin_disdetail")
    public String admindisdetail(HttpSession session, String disid, Model model, Integer toPage){
        //获取论坛信息
        //String disid = (String) session.getAttribute("disid");
        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        entityWrapper.eq("discussid", disid);
        List<OsDiscuss> discussList = discussService.selectList(entityWrapper);
        //获取一级评论详情
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMSOURCE, disid)
                .orderDesc(Arrays.asList(new String[]{OsFirstcomment.COMTIME}));
        //List<OsFirstcomment> firstcomList = firstcommentService.selectList(firstcomWrapper);

        if(toPage == null){
            toPage = 0;
        }
        Page<OsFirstcomment> firstcommentPage = firstcommentService.selectPage(
                new Page<>(toPage, 12), firstcomWrapper);
        System.out.println(firstcommentPage.getRecords());
        //获取二级评论详情
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMSOURCE, disid)
                .orderDesc(Arrays.asList(new String[]{OsSecondcomment.SECCOMTIME}));
        List<OsSecondcomment> secondcomList = secondcommentService.selectList(secondcomWrapper);

        model.addAttribute("dissecondcom", secondcomList);
        model.addAttribute("disfircomPage", firstcommentPage);
        model.addAttribute("disfircomlist", firstcommentPage.getRecords());
        model.addAttribute("discusslist", discussList);

        return "admingate/adiscussdetail";
    }
    //普通查看论坛详情
    @RequestMapping("/user_disdetail")
    public String disdetail(String disid, HttpSession session, Model model, Integer toPage){
        //获取论坛信息
        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        entityWrapper.eq("discussid", disid);
        List<OsDiscuss> discussList = discussService.selectList(entityWrapper);
        //获取一级评论详情
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMSOURCE, disid)
                .orderDesc(Arrays.asList(new String[]{OsFirstcomment.COMTIME}));
        //List<OsFirstcomment> firstcomList = firstcommentService.selectList(firstcomWrapper);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsFirstcomment> firstcommentPage = firstcommentService.selectPage(
                new Page<>(toPage, 12), firstcomWrapper);
        System.out.println(firstcommentPage.getRecords());

        //获取二级评论详情
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMSOURCE, disid)
                .orderDesc(Arrays.asList(new String[]{OsSecondcomment.SECCOMTIME}));
        List<OsSecondcomment> secondcomList = secondcommentService.selectList(secondcomWrapper);

        model.addAttribute("dissecondcom", secondcomList);
        model.addAttribute("disfircomPage", firstcommentPage);
        model.addAttribute("disfircomlist", firstcommentPage.getRecords());
        model.addAttribute("discusslist", discussList);

        return "usergate/user_discuss";
    }
    //论坛一级评论
    @RequestMapping("/commentdis")
    public String commentdiscuss(String disid, HttpSession session, String commsg){
        System.out.println(commsg);
        System.out.println();
        //获取username
        OsUser user = (OsUser) session.getAttribute("user");
        String username = user.getUsername();
        String userid = user.getUserid();
        //获取评论时间
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowtime = sdf.format(now);
        System.out.println(nowtime);

        //插入一级评论
        OsFirstcomment disfircom = new OsFirstcomment();
        disfircom.setCommsg(commsg);
        disfircom.setComname(username);
        disfircom.setCommerid(userid);
        disfircom.setComsource(disid);
        disfircom.setComstatus(1);//1为可见，2为屏蔽
        disfircom.setComtime(nowtime);
        disfircom.setReplycount(0);//一级评论回复数默认为0
        boolean result = firstcommentService.insert(disfircom);
        System.out.println("disfircom : " + result);

        //论坛的评论数+1
        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        entityWrapper.eq("discussid", disid);
        OsDiscuss discuss = discussService.selectOne(entityWrapper);
        System.out.println(discuss.getCommentcount());
        System.out.println(discuss);
        //int oldcount = discuss.getCommentcount();
        int newcount = discuss.getCommentcount() + 1;
        discuss.setDiscussid(disid);
        discuss.setCommentcount(newcount);
        boolean result1 = discussService.update(discuss, entityWrapper);
        System.out.println(result1);

        return "redirect:/disdetail?disid=" + disid;
    }
    //论坛二级评论
    @RequestMapping("/replycomdis")
    public String replycomdis(HttpSession session, String seccommsg,
                              Integer fircomid, String replieder, String disid){
        //获取现在评论者的信息
        OsUser user = (OsUser) session.getAttribute("user");
        String userid = user.getUserid();
        String username = user.getUsername();
        //获取评论时间
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowtime = sdf.format(now);
        //插入二级评论表
        OsSecondcomment disseccom = new OsSecondcomment();
        disseccom.setSeccomid(fircomid);
        disseccom.setSeccommsg(seccommsg);
        disseccom.setSeccomname(username);
        disseccom.setSeccommerid(userid);
        disseccom.setSeccomsource(disid);
        disseccom.setSeccomstatus(1);//1为可看，2为屏蔽
        disseccom.setSeccomtime(nowtime);
        disseccom.setReplieder(replieder);
        boolean secondcommentresult = secondcommentService.insert(disseccom);
        System.out.println("Second comment result : " + secondcommentresult);

        //一级评论reply+1
        //一级评论的comid = 二级评论的seccomid
        EntityWrapper<OsFirstcomment> fircomWrapper = new EntityWrapper<>();
        fircomWrapper.eq(OsFirstcomment.COMID, fircomid);
        OsFirstcomment fircom = firstcommentService.selectOne(fircomWrapper);
        int newreplycount = fircom.getReplycount() + 1;
        fircom.setComid(fircomid);
        fircom.setReplycount(newreplycount);
        boolean fircomreplycountresult = firstcommentService.update(fircom, fircomWrapper);
        System.out.println("firstcomment : " + fircomreplycountresult);

        //论坛评论数+1
        EntityWrapper<OsDiscuss> discussWrapper = new EntityWrapper<>();
        discussWrapper.eq(OsDiscuss.DISCUSSID, disid);
        OsDiscuss discuss = discussService.selectOne(discussWrapper);
        int oldcommentcount = discuss.getCommentcount();
        int newcommentcount = oldcommentcount + 1;
        discuss.setDiscussid(disid);
        discuss.setCommentcount(newcommentcount);
        boolean discussresult = discussService.update(discuss, discussWrapper);
        System.out.println("discuss : " + discussresult);

        return "redirect:/disdetail?disid=" + disid;
    }
    //清空所有评论
    @RequestMapping("deldiscom")
    public String deldiscomment(String disid){
        //删除一级评论
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMSOURCE, disid);
        boolean delfirstcomment = firstcommentService.delete(firstcomWrapper);
        System.out.println("first comment delete result : " + delfirstcomment);
        //删除二级评论
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMSOURCE, disid);
        boolean delsecondcomment = secondcommentService.delete(secondcomWrapper);
        System.out.println("second comment delete result : " + delsecondcomment);

        return "/admindisdetail?disid=" + disid;
    }
    //管理员删除论坛
    @RequestMapping("/admin_deldiscuss")
    public String deldiscuss(String disid){
        //先删除论坛
        EntityWrapper<OsDiscuss> discussWrapper = new EntityWrapper<OsDiscuss>();
        discussWrapper.eq(OsDiscuss.DISCUSSID, disid);
        boolean deldiscussresult = discussService.delete(discussWrapper);
        System.out.println("discuss delete result : " + deldiscussresult);
        //删除一级评论
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMSOURCE, disid);
        boolean delfirstcomresult = firstcommentService.delete(firstcomWrapper);
        System.out.println("first comment delete result : " + delfirstcomresult);
        //删除二级评论
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMSOURCE, disid);
        boolean delsecondcomresult = secondcommentService.delete(secondcomWrapper);
        System.out.println("second comment delete result : " + delsecondcomresult);

        return "redirect:/admindiscuss";
    }
    //用户删除论坛
    @RequestMapping("/user_deldiscuss")
    public String userdeldiscuss(HttpSession session, String disid){
        //获取用户信息
        OsUser user = (OsUser) session.getAttribute("user");
        String userid = user.getUserid();
        //先删除论坛
        EntityWrapper<OsDiscuss> discussWrapper = new EntityWrapper<OsDiscuss>();
        discussWrapper.eq(OsDiscuss.DISCUSSID, disid);
        boolean deldiscussresult = discussService.delete(discussWrapper);
        System.out.println("discuss delete result : " + deldiscussresult);
        //删除一级评论
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMSOURCE, disid);
        boolean delfirstcomresult = firstcommentService.delete(firstcomWrapper);
        System.out.println("first comment delete result : " + delfirstcomresult);
        //删除二级评论
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMSOURCE, disid);
        boolean delsecondcomresult = secondcommentService.delete(secondcomWrapper);
        System.out.println("second comment delete result : " + delsecondcomresult);

        return "redirect:/userdiscuss";
    }
    //查找所有论坛
    @RequestMapping("/admin_discuss")
    public String adminqueryalldiscuss(HttpSession session, Model model, Integer toPage){
        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        //创建时间倒叙
        entityWrapper.orderDesc(Arrays.asList(new String[]{"createtime"}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsDiscuss> discussPage = discussService.selectPage(
                new Page<>(toPage, 10), entityWrapper);
        System.out.println(discussPage.getRecords());

        model.addAttribute("disucussPage", discussPage);
        model.addAttribute("discusslist", discussPage.getRecords());
        session.setAttribute("dispoint", 1);
        return "admin_discuss";
    }
    //查找一个论坛
    @RequestMapping("/admin_searchdiscuss")
    public String adminsearchdiscuss(HttpSession session, Model model, String discussname, Integer toPage){
        //储存论坛名
        session.setAttribute("disname", discussname);

        EntityWrapper<OsDiscuss> entityWrapper = new EntityWrapper<OsDiscuss>();
        entityWrapper.eq("discussname", discussname);
        List<OsDiscuss> discusslist = discussService.selectList(entityWrapper);
        System.out.println(discusslist);
        model.addAttribute("discusslist", discusslist);
        return "admin_discuss";
    }
    //删一个一级评论
    @RequestMapping("/deldisfirstcom")
    public String deldisfirstcom(HttpSession session, String disid, Integer comid){
        //删除一级评论
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMID, comid);
        boolean delfircomresult = firstcommentService.delete(firstcomWrapper);
        System.out.println("delete first comment result : " + delfircomresult);
        //删除二级评论
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECCOMID, comid);
        boolean delseccomresult = secondcommentService.delete(secondcomWrapper);
        System.out.println("delete second comment result : " + delseccomresult);

        int dispoint = (int) session.getAttribute("dispoint");
        if(dispoint == 1){
            return "redirect:/admindisdetail?disid=" + disid;
        }else {
            return "redirect:/disdetail?disid=" + disid;
        }
    }
    //删除一个二级评论
    @RequestMapping("/deldissecondcom")
    public String deldissecondcom(HttpSession session, String disid, Integer secrealid){
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECREALID, secrealid);
        boolean delsecondcomresult = secondcommentService.delete(secondcomWrapper);
        System.out.println("delete second comment result : " + delsecondcomresult);

        int dispoint = (int) session.getAttribute("dispoint");
        if(dispoint == 1){
            return "redirect:/admindisdetail?disid=" + disid;
        }else {
            return "redirect:/disdetail?disid=" + disid;
        }
    }
    //让一级评论被屏蔽
    @RequestMapping("/shielddisfirstcom")
    public String shielddisfirstcom(HttpSession session, String disid, Integer comid){
        //评论可见状态为1
        EntityWrapper<OsFirstcomment> firstcomWrapper = new EntityWrapper<>();
        firstcomWrapper.eq(OsFirstcomment.COMID, comid);
        OsFirstcomment firstcomment = firstcommentService.selectOne(firstcomWrapper);
        firstcomment.setComid(comid);
        firstcomment.setComstatus(2);//2为屏蔽，不显示
        boolean firstcomshieldresult = firstcommentService.update(firstcomment, firstcomWrapper);
        System.out.println("first comment shield result : " + firstcomshieldresult);

        int dispoint = (int) session.getAttribute("dispoint");
        if(dispoint == 1){
            return "redirect:/admindisdetail?disid=" + disid;
        }else {
            return "redirect:/disdetail?disid=" + disid;
        }
    }
    //让二级评论被屏蔽
    @RequestMapping("/shielddisseccom")
    public String shielddisseccom(HttpSession session, String disid, Integer secrealid){
        //评论可见状态为1
        EntityWrapper<OsSecondcomment> secondcomWrapper = new EntityWrapper<>();
        secondcomWrapper.eq(OsSecondcomment.SECREALID, secrealid);
        OsSecondcomment secondcomment = secondcommentService.selectOne(secondcomWrapper);
        secondcomment.setSecrealid(secrealid);
        secondcomment.setSeccomstatus(2);
        boolean secondcomshieldresult = secondcommentService.update(secondcomment, secondcomWrapper);
        System.out.println("second comment shield result : " + secondcomshieldresult);

        int dispoint = (int) session.getAttribute("dispoint");
        if(dispoint == 1){
            return "redirect:/admindisdetail?disid=" + disid;
        }else {
            return "redirect:/disdetail?disid=" + disid;
        }
    }

}
