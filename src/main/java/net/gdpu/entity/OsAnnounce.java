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
 * @since 2020-02-20
 */
@Data
@TableName("os_announce")
public class OsAnnounce extends Model<OsAnnounce> {

    private static final long serialVersionUID = 1L;

    /**
     * 公告id
     */
    @TableId(value = "announceid", type = IdType.AUTO)
    private Integer announceid;
    /**
     * 公告名
     */
    private String announcename;
    /**
     * 公告内容
     */
    private String announcemsg;
    /**
     * 公告时间
     */
    private String announcetime;
    /**
     * 公告人
     */
    private String announcer;
    /**
     * 公告状态
     */
    private Integer annoucestatus;


    public Integer getAnnounceid() {
        return announceid;
    }

    public void setAnnounceid(Integer announceid) {
        this.announceid = announceid;
    }

    public String getAnnouncename() {
        return announcename;
    }

    public void setAnnouncename(String announcename) {
        this.announcename = announcename;
    }

    public String getAnnouncemsg() {
        return announcemsg;
    }

    public void setAnnouncemsg(String announcemsg) {
        this.announcemsg = announcemsg;
    }

    public String getAnnouncetime() {
        return announcetime;
    }

    public void setAnnouncetime(String announcetime) {
        this.announcetime = announcetime;
    }

    public String getAnnouncer() {
        return announcer;
    }

    public void setAnnouncer(String announcer) {
        this.announcer = announcer;
    }

    public Integer getAnnoucestatus() {
        return annoucestatus;
    }

    public void setAnnoucestatus(Integer annoucestatus) {
        this.annoucestatus = annoucestatus;
    }

    public static final String ANNOUNCEID = "announceid";

    public static final String ANNOUNCENAME = "announcename";

    public static final String ANNOUNCEMSG = "announcemsg";

    public static final String ANNOUNCETIME = "announcetime";

    public static final String ANNOUNCER = "announcer";

    public static final String ANNOUCESTATUS = "annoucestatus";

    @Override
    protected Serializable pkVal() {
        return this.announceid;
    }

    @Override
    public String toString() {
        return "OsAnnounce{" +
        ", announceid=" + announceid +
        ", announcename=" + announcename +
        ", announcemsg=" + announcemsg +
        ", announcetime=" + announcetime +
        ", announcer=" + announcer +
        ", annoucestatus=" + annoucestatus +
        "}";
    }
}
