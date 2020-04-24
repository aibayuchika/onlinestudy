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
 * @since 2020-04-23
 */
@Data
@TableName("os_ziliaotag")
public class OsZiliaotag extends Model<OsZiliaotag> {

    private static final long serialVersionUID = 1L;

    /**
     * 标签id
     */
    @TableId(value = "tagid", type = IdType.AUTO)
    private Integer tagid;
    /**
     * 标签名称
     */
    private String tagname;
    /**
     * 添加时间
     */
    private String addtime;


    public Integer getTagid() {
        return tagid;
    }

    public void setTagid(Integer tagid) {
        this.tagid = tagid;
    }

    public String getTagname() {
        return tagname;
    }

    public void setTagname(String tagname) {
        this.tagname = tagname;
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    public static final String TAGID = "tagid";

    public static final String TAGNAME = "tagname";

    public static final String ADDTIME = "addtime";

    @Override
    protected Serializable pkVal() {
        return this.tagid;
    }

    @Override
    public String toString() {
        return "OsZiliaotag{" +
        ", tagid=" + tagid +
        ", tagname=" + tagname +
        ", addtime=" + addtime +
        "}";
    }
}
