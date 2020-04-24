package net.gdpu.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.sun.org.apache.xpath.internal.operations.Mod;
import net.gdpu.entity.OsLoginstatus;
import net.gdpu.entity.OsUser;
import net.gdpu.service.OsAllstatusService;
import net.gdpu.service.OsAnnounceService;
import net.gdpu.service.OsLoginstatusService;
import net.gdpu.service.OsUserService;
import net.gdpu.utils.IPUtils;
import net.gdpu.utils.MD5Util;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
 * @since 2020-02-03
 */
@Controller
public class UserController {
    @Resource
    private OsUserService userService;
    @Resource
    private OsAllstatusService statusService;
    @Resource
    private OsAnnounceService announceService;
    @Resource
    private OsLoginstatusService loginstatusService;

    //登录登出开始
    @RequestMapping("/tologin")
    public String tologin(){
        return "login";
    }

    @RequestMapping("/loginAction")
    public String loginAction(Model model, HttpSession session, HttpServletRequest request,
                              String userid, String passwd){
        System.out.println(userid+","+passwd);
        MD5Util md5Util = new MD5Util();
        String md5Pass = md5Util.string2MD5(passwd);
        if(userid != null && !(userid.equals("")) && passwd != null && !(passwd.equals(""))){
            EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
            entityWrapper.eq("userid", userid)
                         .eq("md5pass", md5Pass);
//                         .eq("realpass", passwd);
            //获取时间
            Date zeit = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String nowzeit = sdf.format(zeit);
            String IP = IPUtils.getIpAddr(request);

            OsUser user = userService.selectOne(entityWrapper);
            OsLoginstatus loginstatus = new OsLoginstatus();
            //取usertype
            if(user == null){
                String msg = "账号或密码错误！";
                model.addAttribute("loginerrormsg", msg);
                return "login";
            }else {
                session.setAttribute("user", user);
                loginstatus.setUserid(userid);
                loginstatus.setLogintime(nowzeit);
                loginstatus.setLoginip(IP);
                loginstatusService.insert(loginstatus);
                if(user.getUsertype().equals(1)){
                    return "redirect:/admin_index";
                }else {
                    String toPath = (String) session.getAttribute("toPath");
                    if(toPath == null){
                        return "redirect:/index";
                    }else {
                        return "redirect:" + toPath;
                    }
                }
            }
        }else {
            String msg = "账号或密码错误！";
            model.addAttribute("loginerrormsg", msg);
            return "login";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/tologin";
    }
    //登录登出结束

    //管理员查询所有用户
    @RequestMapping("/admin_userlist")
    public String showalluser(Model model, Integer toPage){
        //通过类别查询用户信息
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsUser.RIGISTTIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsUser> userPage = userService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("page", userPage);
        model.addAttribute("userlist", userPage.getRecords());
        return "admingate/admin_userlist";
    }
    //各种用户查询
    @RequestMapping("/admin_adminlist")
    public String admin_adminlist(Model model, Integer toPage){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsUser.RIGISTTIME}))
                     .eq("usertype", 1);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsUser> userPage = userService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("adminpage", userPage);
        model.addAttribute("adminlist", userPage.getRecords());
        return "admingate/admin_userlist";
    }
    @RequestMapping("/admin_secadminlist")
    public String admin_secadminlist(Model model, Integer toPage){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsUser.RIGISTTIME}))
                .eq("usertype", 2);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsUser> userPage = userService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("secadminpage", userPage);
        model.addAttribute("secadminlist", userPage.getRecords());
        return "admingate/admin_userlist";
    }
    @RequestMapping("/admin_normaluser")
    public String admin_normaluser(Model model, Integer toPage){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsUser.RIGISTTIME}))
                .eq("usertype", 3);
        if(toPage == null){
            toPage = 0;
        }
        Page<OsUser> userPage = userService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("normalpage", userPage);
        model.addAttribute("normallist", userPage.getRecords());
        return "admingate/admin_userlist";
    }

    //管理员登录记录查询
    @RequestMapping("/admin_logincheck")
    public String admin_logincheck(Model model, Integer toPage){
        EntityWrapper<OsLoginstatus> entityWrapper = new EntityWrapper<>();
        entityWrapper.orderDesc(Arrays.asList(new String[]{OsLoginstatus.LOGINTIME}));
        if(toPage == null){
            toPage = 0;
        }
        Page<OsLoginstatus> loginstatusPage = loginstatusService.selectPage(
                new Page<>(toPage, 12), entityWrapper);
        model.addAttribute("login_statuslist", loginstatusPage.getRecords());
        model.addAttribute("login_statuspage", loginstatusPage);
        return "admingate/admin_userlist";
    }

    //删除登录记录
    @RequestMapping("/admin_dellogin")
    public String admin_dellogin(String loginid){
        EntityWrapper<OsLoginstatus> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsLoginstatus.ID, loginid);
        boolean result = loginstatusService.delete(entityWrapper);
        if(result){
            System.out.println("删除成功");
            return "redirect:/admin_logincheck";
        }else {
            System.out.println("删除失败");
            return "redirect:/admin_logincheck";
        }
    }

    //设为黑名单
    @RequestMapping("/admin_setblack")
    public String admin_setblack(Model model, String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsUser.USERID, userid);
        OsUser user = userService.selectOne(entityWrapper);
        user.setIsblack(2);
        boolean resutlt = userService.update(user, entityWrapper);

        if(resutlt){
            System.out.println("已为黑名单");
            return "/admin_userlist";
        }else {
            System.out.println("设置失败");
            return "/admin_userlist";
        }
    }
    //设为白名单
    @RequestMapping("/admin_setwhite")
    public String admin_setwhite(Model model, String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsUser.USERID, userid);
        OsUser user = userService.selectOne(entityWrapper);
        user.setIsblack(1);
        boolean resutlt = userService.update(user, entityWrapper);

        if(resutlt){
            System.out.println("已为白名单");
            return "/admin_userlist";
        }else {
            System.out.println("设置失败");
            return "/admin_userlist";
        }
    }

    //用户查重
    public boolean checkuser(String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.eq("userid", userid);
        List<OsUser> userlist = userService.selectList(entityWrapper);
        if(userlist == null || userlist.isEmpty()){
            return false;
        }
        return true;
    }

    //管理员注册用户
    @RequestMapping("/admin_adduser")
    public String adduser(String userid, String username, Integer usertype, String usersex, String usermail, Model model){
        System.out.println(userid+","+username+"，"+usersex+","+usertype+","+usermail);
        OsUser user = new OsUser();
        if(checkuser(userid)){
            String msg = "当前用户"+ userid +"已存在";
            model.addAttribute("addusererror", msg);
            System.out.println(userid + "用户已存在");
            return "用户存在";
        }else {
            MD5Util md5Util = new MD5Util();
            String md5Pass = md5Util.string2MD5("888888");
            Date nowtime = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String registtime = sdf.format(nowtime);
            System.out.println("注册时间：" + registtime);
            user.setUserid(userid);
            user.setMd5pass(md5Pass);
            user.setUsername(username);
            user.setUsertype(usertype);
            user.setRigisttime(registtime);
            user.setIsblack(1);
            user.setRealpass("888888");
            user.setUsersex(usersex);
            userService.insert(user);
        }
        return "redirect:/admin_userlist";
    }

    //管理员通过userid删除用户
    @RequestMapping("/admin_deluser")
    public String deluserbyid(String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.eq("userid", userid);
        boolean result = userService.delete(entityWrapper);

        System.out.println("删除" + userid +"的结果：" + result);
        return "/admin_userlist";
    }

    //管理员重置密码
    @RequestMapping("/admin_resetpasswd")
    public String adminresetpasswd(String userid, Model model){
        //密码会重置成888888
        MD5Util md5Util = new MD5Util();
        String md5pass = md5Util.string2MD5("888888");
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        entityWrapper.eq("userid", userid);
        OsUser user = new OsUser();
        user.setRealpass("888888");
        user.setMd5pass(md5pass);
        boolean result = userService.update(user, entityWrapper);
        //获取新密码
        String newpasswd = user.getRealpass();
        System.out.println("修改密码结果是：" + result);

        if(result){
            System.out.println("userid是" + userid + "的新密码：" + newpasswd);

            model.addAttribute("resetpass_msg", "重置密码成功，初始密码为888888");
            return "redirect:/admin_userlist";
        } else{
            model.addAttribute("resetpass_msg", "重置密码失败");
            return "redirect:/admin_userlist";
        }
    }

    //设置二级管理员
    @RequestMapping("/admin_setsecondadmin")
    public String admin_setsecondadmin(String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<>();
        OsUser user = userService.selectOne(entityWrapper.eq(OsUser.USERID, userid));
        user.setUsertype(2);
        boolean result = userService.update(user, entityWrapper);
        if(result){
            System.out.println("成了");
            return "redirect:/admin_secadminlist";
        }else {
            System.out.println("坏了");
            return "redirect:/admin_normaluser";
        }
    }

    //撤销二级管理员
    @RequestMapping("/admin_cancelsecondadmin")
    public String admin_cancelsecondadmin(String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<>();
        OsUser user = userService.selectOne(entityWrapper.eq(OsUser.USERID, userid));
        user.setUsertype(3);
        boolean result = userService.update(user, entityWrapper);
        if(result){
            System.out.println("成了");
            return "redirect:/admin_normaluser";
        }else {
            System.out.println("坏了");
            return "redirect:/admin_secadminlist";
        }
    }

    //管理员查找一位用户
    @RequestMapping("/admin_searchuser")
    public String searchuser(Model model, String userid, String username){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<OsUser>();
        if(userid == null || userid.equals("")){
            entityWrapper.eq("username", username);
        } else if(username == null || username.equals("")){
            entityWrapper.eq("userid", userid);
        } else if(!(userid.equals("")) && !(username.equals(""))){
            entityWrapper.eq("userid", userid)
                         .eq("username", username);
        }
        List<OsUser> userlist = userService.selectList(entityWrapper);
        System.out.println(userlist);
        model.addAttribute("userlist", userlist);
        return "admingate/auserlist";
    }

    //用户注册
    @RequestMapping("/userregist")
    public String userregist(String username, String userid, String nickname, String usersex,
                           String passwd, String repasswd, String email, Model model){
        boolean checkuserid = checkuser(userid);
        if(checkuserid){
            model.addAttribute("regist_error", "当前ID或已被注册！");
            return "registuser";
        }
        String nameRegex = "^[a-zA-Z0-9\u4E00-\u9FA5.@_]+$";
        String idRegex = "^1[3-9]\\d{9}$";
        String mailRegex = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
        if(username == null || username.equals("") || !username.matches(nameRegex)){
            model.addAttribute("regist_error", "用户名不能为空！");
            return "registuser";
        }
        if(userid == null || userid.equals("") || !userid.matches(idRegex)){
            model.addAttribute("regist_error", "ID不能为空！");
            return "registuser";
        }
        if(nickname == null || nickname.equals("")){
            nickname = username;
        }
        if(email == null || email.equals("")){
            email = "待补充";
        }
        MD5Util md5Util = new MD5Util();
        String md5Pass = md5Util.string2MD5(passwd);

        OsUser newuser = new OsUser();
        int usertype = 3;

        Date nowzeit = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String registzeit = sdf.format(nowzeit);

        newuser.setUserid(userid);
        newuser.setMd5pass(md5Pass);
        newuser.setRealpass(passwd);
        newuser.setIsblack(1);
        newuser.setNickname(nickname);
        newuser.setRigisttime(registzeit);
        newuser.setUsermail(email);
        newuser.setUsername(username);
        newuser.setUsersex(usersex);
        newuser.setUsertype(usertype);
        boolean newuserregist = userService.insert(newuser);

        if(newuserregist){
            return "/tologin";
        }else {
            model.addAttribute("regist_error", "当前失败！");
            return "registuser";
        }
    }

    //用户进入修改个人信息界面
    @RequestMapping("/user_updetail")
    public String user_updetail(Model model, String userid){
        EntityWrapper<OsUser> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq(OsUser.USERID, userid);
        List<OsUser> userList = userService.selectList(entityWrapper);
        model.addAttribute("userlist", userList);
        return "usergate/user_update_userinfo";
    }
}

