package net.gdpu.entity;

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
@TableName("os_discuss")
public class OsDiscuss extends Model<OsDiscuss> {

    private static final long serialVersionUID = 1L;

    private String discussid;
    private String discussname;
    private String creatorid;
    private String creator;
    private String discussabstract;
    private String createtime;
    private Integer commentcount;


    public String getDiscussid() {
        return discussid;
    }

    public void setDiscussid(String discussid) {
        this.discussid = discussid;
    }

    public String getDiscussname() {
        return discussname;
    }

    public void setDiscussname(String discussname) {
        this.discussname = discussname;
    }

    public String getCreatorid() {
        return creatorid;
    }

    public void setCreatorid(String creatorid) {
        this.creatorid = creatorid;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getDiscussabstract() {
        return discussabstract;
    }

    public void setDiscussabstract(String discussabstract) {
        this.discussabstract = discussabstract;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public Integer getCommentcount() {
        return commentcount;
    }

    public void setCommentcount(Integer commentcount) {
        this.commentcount = commentcount;
    }

    public static final String DISCUSSID = "discussid";

    public static final String DISCUSSNAME = "discussname";

    public static final String CREATORID = "creatorid";

    public static final String CREATOR = "creator";

    public static final String DISCUSSABSTRACT = "discussabstract";

    public static final String CREATETIME = "createtime";

    public static final String COMMENTCOUNT = "commentcount";

    @Override
    protected Serializable pkVal() {
        return this.discussid;
    }

    @Override
    public String toString() {
        return "OsDiscuss{" +
        ", discussid=" + discussid +
        ", discussname=" + discussname +
        ", creatorid=" + creatorid +
        ", creator=" + creator +
        ", discussabstract=" + discussabstract +
        ", createtime=" + createtime +
        ", commentcount=" + commentcount +
        "}";
    }
}
