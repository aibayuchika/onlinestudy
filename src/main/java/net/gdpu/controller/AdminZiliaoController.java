package net.gdpu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.sun.org.apache.xpath.internal.operations.Mod;
import net.gdpu.entity.OsZiliao;
import net.gdpu.entity.OsZiliaotag;
import net.gdpu.service.OsUserService;
import net.gdpu.service.OsZiliaoService;
import net.gdpu.service.OsZiliaotagService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

@Controller
public class AdminZiliaoController {
    @Resource
    private OsZiliaoService ziliaoService;
    @Resource
    private OsZiliaotagService ziliaotagService;
    @Resource
    private OsUserService userService;

    @RequestMapping("/admin_index")
    public String admin_index(Model model){
//        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        int video_num = ziliaoService.selectCount(new EntityWrapper<OsZiliao>()
                .eq(OsZiliao.ZILIAOTYPE, 1)
                .eq(OsZiliao.ZILIAOSTATUS, 5));
        int doc_num = ziliaoService.selectCount(new EntityWrapper<OsZiliao>()
                .eq(OsZiliao.ZILIAOTYPE, 2)
                .eq(OsZiliao.ZILIAOSTATUS, 5));
        model.addAttribute("video_num", video_num);
        model.addAttribute("doc_num", doc_num);

        return "admingate/admin_index";
    }

    @RequestMapping("/admin2upload")
    public String admin2upload(Model model){
        List<OsZiliaotag> ziliaotagList = ziliaotagService.selectList(null);
        model.addAttribute("taglist", ziliaotagList);
        return "admingate/admin_ziliao_upload";
    }

    //四个资料查看开始
    @RequestMapping("/admin_ziliaolist")
    public String admin_ziliaolist(Model model, Integer toPage){
        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPDATETIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> ziliaoPage = ziliaoService.selectPage(
                new Page<>(toPage, 15), ziliaoEntityWrapper);
        model.addAttribute("ziliaopage", ziliaoPage);
        model.addAttribute("ziliaolist", ziliaoPage.getRecords());

        return "admingate/admin_ziliaolist";
    }
    @RequestMapping("/admin_ziliaopass")
    public String admin_ziliaopass(Model model, Integer toPage){
        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPDATETIME}))
                .eq(OsZiliao.ZILIAOSTATUS, 4);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> ziliaoPage = ziliaoService.selectPage(
                new Page<>(toPage, 15), ziliaoEntityWrapper);
        model.addAttribute("passpage", ziliaoPage);
        model.addAttribute("passlist", ziliaoPage.getRecords());

        return "admingate/admin_ziliaolist";
    }
    @RequestMapping("/admin_ziliaocheck")
    public String admin_ziliaocheck(Model model, Integer toPage){
        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPDATETIME}))
            .eq(OsZiliao.ZILIAOSTATUS, 5);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> ziliaoPage = ziliaoService.selectPage(
                new Page<>(toPage, 15), ziliaoEntityWrapper);
        model.addAttribute("checkpage", ziliaoPage);
        model.addAttribute("checklist", ziliaoPage.getRecords());

        return "admingate/admin_ziliaolist";
    }
    @RequestMapping("/admin_ziliaofail")
    public String admin_ziliaofail(Model model, Integer toPage){
        EntityWrapper<OsZiliao> ziliaoEntityWrapper = new EntityWrapper<>();
        ziliaoEntityWrapper.orderDesc(Arrays.asList(new String[]{OsZiliao.ZILIAOUPDATETIME}))
                .eq(OsZiliao.ZILIAOSTATUS, 6);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliao> ziliaoPage = ziliaoService.selectPage(
                new Page<>(toPage, 15), ziliaoEntityWrapper);
        model.addAttribute("failpage", ziliaoPage);
        model.addAttribute("faillist", ziliaoPage.getRecords());

        return "admingate/admin_ziliaolist";
    }
    //四个资料查看结束

    //资料tag查询
    @RequestMapping("/admin_ziliaotagmanage")
    public String admin_ziliaotag(Model model, Integer toPage){
        EntityWrapper<OsZiliaotag> entityWrapper = new EntityWrapper<>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsZiliaotag.ADDTIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsZiliaotag> ziliaotagPage = ziliaotagService.selectPage(
                new Page<>(toPage, 15), entityWrapper
        );
        model.addAttribute("ziliaotagpage", ziliaotagPage);
        model.addAttribute("ziliaotaglist", ziliaotagPage.getRecords());
        return "admingate/admin_ziliaolist";
    }
    //加tag
    @RequestMapping("/admin_addziliaotag")
    public String admin_addziliaotag(Model model)

    //管理员查看资料详情
    @RequestMapping("/admin_ziliaodetail")
    public String admin_ziliaodetail(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        List<OsZiliao> ziliaoList = ziliaoService.selectList(entityWrapper
                                    .eq(OsZiliao.ZILIAOID, ziliaoid));
        model.addAttribute("ziliaolist", ziliaoList);
        return "admingate/admin_ziliao_detail";
    }

    //管理员通过资料
    @RequestMapping("/admin_pass")
    public String admin_pass(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> ew = new EntityWrapper<>();
        ew.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(ew);
        ziliao.setZiliaostatus(4);
        ziliao.setZiliaofailreason("已通过");
        boolean result = ziliaoService.update(ziliao, ew);

        if(result){
            model.addAttribute("update_msg", "当前资料已通过");
            return "redirect:/admin_ziliaodetail?ziliaoid=" + ziliaoid;
        }else {
            model.addAttribute("update_msg", "当前资料通过失败，请检查你的网络状况。");
            return "redirect:/admin_ziliaodetail?ziliaoid=" + ziliaoid;
        }
    }

    //管理员拒绝资料
    @RequestMapping("/admin_fail")
    public String admin_fail(Model model, String ziliaoid, String failreason){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(entityWrapper);
        ziliao.setZiliaostatus(6);
        ziliao.setZiliaofailreason(failreason);
        boolean result = ziliaoService.update(ziliao,entityWrapper);

        if(result){
            model.addAttribute("update_msg", "当前资料已退回");
            return "redirect:/admin_ziliaodetail?ziliaoid=" + ziliaoid;
        }else {
            model.addAttribute("update_msg", "当前资料退回失败，请检查你的网络状况。");
            return "redirect:/admin_ziliaodetail?ziliaoid=" + ziliaoid;
        }
    }

    //临时下架
    @RequestMapping("/admin_off")
    public String admin_off(Model model, String ziliaoid){
        EntityWrapper<OsZiliao> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsZiliao.ZILIAOID, ziliaoid);
        OsZiliao ziliao = ziliaoService.selectOne(entityWrapper);
        ziliao.setZiliaostatus(5);
        ziliao.setZiliaofailreason("临时下架");
        boolean result = ziliaoService.update(ziliao, entityWrapper);

        if(result){
            String msg = "下架" + ziliao.getZiliaoname() + "成功";
            model.addAttribute("update_msg", msg);
            return "redirect:/admin_ziliaocheck";
        }else {
            model.addAttribute("update_msg", "当前资料下架失败，请检查你的网络状况。");
            return "redirect:/admin_ziliaopass";
        }
    }
}
