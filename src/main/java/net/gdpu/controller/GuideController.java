package net.gdpu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GuideController {
    @RequestMapping("/adminway/auserlist")
    public String auserlist(){
        return "admingate/auserlist";
    }

    @RequestMapping("/adminway/avideolist")
    public String avideolist(){
        return "admin_ziliaolist";
    }

    @RequestMapping("/toadminuploadvideo")
    public String toadminuploadvideo(){
        return "admin_ziliao_upload";
    }

    @RequestMapping("/toadminuploadfile")
    public String toadminuploadfile(){
        return "admingate/afileupload";
    }

    @RequestMapping("/toivd")
    public String toivd(){
        return "indexvideo";
    }

    @RequestMapping("/touupdatevideo")
    public String touupdatevideo(){
        return "usergate/uupdatevideo";
    }

    @RequestMapping("/toadmin_discuss")
    public String toifd(){
        return "admingate/admin_discuss";
    }

    @RequestMapping("/registPage")
    public String registPage(){
        return "registuser";
    }

}
