package net.gdpu.entity;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author lekhvia
 * @since 2020-03-13
 */
@Data
@TableName("os_firstcomment")
public class OsFirstcomment extends Model<OsFirstcomment> {

    private static final long serialVersionUID = 1L;

    /**
     * 评论id
     */
    @TableId(value = "comid", type = IdType.AUTO)
    private Integer comid;
    /**
     * 评论
     */
    private String commsg;
    /**
     * 评论者名称
     */
    private String comname;
    /**
     * 评论者id
     */
    private String commerid;
    /**
     * 评论源
     */
    private String comsource;
    /**
     * 评论状态
     */
    private Integer comstatus;
    /**
     * 评论时间
     */
    private String comtime;
    /**
     * 回复数
     */
    private Integer replycount;


    public Integer getComid() {
        return comid;
    }

    public void setComid(Integer comid) {
        this.comid = comid;
    }

    public String getCommsg() {
        return commsg;
    }

    public void setCommsg(String commsg) {
        this.commsg = commsg;
    }

    public String getComname() {
        return comname;
    }

    public void setComname(String comname) {
        this.comname = comname;
    }

    public String getCommerid() {
        return commerid;
    }

    public void setCommerid(String commerid) {
        this.commerid = commerid;
    }

    public String getComsource() {
        return comsource;
    }

    public void setComsource(String comsource) {
        this.comsource = comsource;
    }

    public Integer getComstatus() {
        return comstatus;
    }

    public void setComstatus(Integer comstatus) {
        this.comstatus = comstatus;
    }

    public String getComtime() {
        return comtime;
    }

    public void setComtime(String comtime) {
        this.comtime = comtime;
    }

    public Integer getReplycount() {
        return replycount;
    }

    public void setReplycount(Integer replycount) {
        this.replycount = replycount;
    }

    public static final String COMID = "comid";

    public static final String COMMSG = "commsg";

    public static final String COMNAME = "comname";

    public static final String COMMERID = "commerid";

    public static final String COMSOURCE = "comsource";

    public static final String COMSTATUS = "comstatus";

    public static final String COMTIME = "comtime";

    public static final String REPLYCOUNT = "replycount";

    @Override
    protected Serializable pkVal() {
        return this.comid;
    }

    @Override
    public String toString() {
        return "OsFirstcomment{" +
        ", comid=" + comid +
        ", commsg=" + commsg +
        ", comname=" + comname +
        ", commerid=" + commerid +
        ", comsource=" + comsource +
        ", comstatus=" + comstatus +
        ", comtime=" + comtime +
        ", replycount=" + replycount +
        "}";
    }
}
