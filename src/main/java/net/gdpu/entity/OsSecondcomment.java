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
 * @since 2020-03-17
 */
@Data
@TableName("os_secondcomment")
public class OsSecondcomment extends Model<OsSecondcomment> {

    private static final long serialVersionUID = 1L;

    /**
     * 二级评论排序用id
     */
    @TableId(value = "secrealid", type = IdType.AUTO)
    private Integer secrealid;
    /**
     * 二级评论id（与一级评论id相同）
     */
    private Integer seccomid;
    /**
     * 二级评论内容
     */
    private String seccommsg;
    /**
     * 二级评论者
     */
    private String seccomname;
    /**
     * 二级评论者id
     */
    private String seccommerid;
    /**
     * 二级评论源
     */
    private String seccomsource;
    /**
     * 二级评论状态
     */
    private Integer seccomstatus;
    /**
     * 二级评论时间
     */
    private String seccomtime;
    /**
     * 被回复者
     */
    private String replieder;


    public Integer getSecrealid() {
        return secrealid;
    }

    public void setSecrealid(Integer secrealid) {
        this.secrealid = secrealid;
    }

    public Integer getSeccomid() {
        return seccomid;
    }

    public void setSeccomid(Integer seccomid) {
        this.seccomid = seccomid;
    }

    public String getSeccommsg() {
        return seccommsg;
    }

    public void setSeccommsg(String seccommsg) {
        this.seccommsg = seccommsg;
    }

    public String getSeccomname() {
        return seccomname;
    }

    public void setSeccomname(String seccomname) {
        this.seccomname = seccomname;
    }

    public String getSeccommerid() {
        return seccommerid;
    }

    public void setSeccommerid(String seccommerid) {
        this.seccommerid = seccommerid;
    }

    public String getSeccomsource() {
        return seccomsource;
    }

    public void setSeccomsource(String seccomsource) {
        this.seccomsource = seccomsource;
    }

    public Integer getSeccomstatus() {
        return seccomstatus;
    }

    public void setSeccomstatus(Integer seccomstatus) {
        this.seccomstatus = seccomstatus;
    }

    public String getSeccomtime() {
        return seccomtime;
    }

    public void setSeccomtime(String seccomtime) {
        this.seccomtime = seccomtime;
    }

    public String getReplieder() {
        return replieder;
    }

    public void setReplieder(String replieder) {
        this.replieder = replieder;
    }

    public static final String SECREALID = "secrealid";

    public static final String SECCOMID = "seccomid";

    public static final String SECCOMMSG = "seccommsg";

    public static final String SECCOMNAME = "seccomname";

    public static final String SECCOMMERID = "seccommerid";

    public static final String SECCOMSOURCE = "seccomsource";

    public static final String SECCOMSTATUS = "seccomstatus";

    public static final String SECCOMTIME = "seccomtime";

    public static final String REPLIEDER = "replieder";

    @Override
    protected Serializable pkVal() {
        return this.secrealid;
    }

    @Override
    public String toString() {
        return "OsSecondcomment{" +
        ", secrealid=" + secrealid +
        ", seccomid=" + seccomid +
        ", seccommsg=" + seccommsg +
        ", seccomname=" + seccomname +
        ", seccommerid=" + seccommerid +
        ", seccomsource=" + seccomsource +
        ", seccomstatus=" + seccomstatus +
        ", seccomtime=" + seccomtime +
        ", replieder=" + replieder +
        "}";
    }
}
