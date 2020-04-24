package net.gdpu.controller;

import net.gdpu.entity.OsUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class BackController {
    //discuss back
    @RequestMapping("/disback")
    public String disback(HttpSession session){
        int dispoint = (int) session.getAttribute("dispoint");
        //String thePath = (String) session.getAttribute("thePath");
        String disname = (String) session.getAttribute("disname");
        OsUser user = (OsUser) session.getAttribute("user");
        if(dispoint == 1){//admin是1
            if(disname != null){
                return "redirect:/adminsearchdiscuss?discussname=" + disname;
            }else {
                return "redirect:/admindiscuss";
            }
        }else if(dispoint == 2){//2是在index中看来的
            if(disname != null){
                session.removeAttribute("disname");
                return "redirect:/searchdis?discussname=" + disname;
            }else {
                return "redirect:/discuss";
            }
        }else {//3是在user界面看的
            if(user != null){
                return "redirect:/userdiscuss";
            }else {
                return "/tologin";
            }
        }
    }

    //video back
    @RequestMapping("/videoback")
    public String videoback(HttpSession session){
        int vipoint = (int) session.getAttribute("videopoint");
        String videoname = (String) session.getAttribute("videoname");
        OsUser user = (OsUser) session.getAttribute("user");
        //管理员进入videopoint=1，user自己界面videopoint=2，主页进去videopoint=3
        if(vipoint == 1){
            if(videoname != null){
                return "redirect:/adminsearchvideo?videoname=" + videoname;
            }else {
                return "redirect:/admindiscuss";
            }
        }else if(vipoint == 3){//3是在index中看来的
            if(videoname != null){
                session.removeAttribute("videoname");
                return "redirect:/searchvifi?key=" + videoname;
            }else {
                return "redirect:/discuss";
            }
        }else {//2是在user界面看的
            if(user != null){
                return "redirect:/uservideo";
            }else {
                return "/tologin";
            }
        }
    }

    //file back
    @RequestMapping("/fileback")
    public String fileback(HttpSession session){
        //管理员进入filepoint=1，user自己界面filepoint=2，主页进去filepoint=3
        return null;
    }
}
