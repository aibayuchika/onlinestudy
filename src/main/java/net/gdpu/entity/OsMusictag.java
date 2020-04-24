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
@TableName("os_musictag")
public class OsMusictag extends Model<OsMusictag> {

    private static final long serialVersionUID = 1L;

    /**
     * 音乐tagid
     */
    @TableId(value = "mtagid", type = IdType.AUTO)
    private Integer mtagid;
    /**
     * 音乐tag名
     */
    private String mtagname;
    /**
     * 添加时间
     */
    private String addtime;


    public Integer getMtagid() {
        return mtagid;
    }

    public void setMtagid(Integer mtagid) {
        this.mtagid = mtagid;
    }

    public String getMtagname() {
        return mtagname;
    }

    public void setMtagname(String mtagname) {
        this.mtagname = mtagname;
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    public static final String MTAGID = "mtagid";

    public static final String MTAGNAME = "mtagname";

    public static final String ADDTIME = "addtime";

    @Override
    protected Serializable pkVal() {
        return this.mtagid;
    }

    @Override
    public String toString() {
        return "OsMusictag{" +
        ", mtagid=" + mtagid +
        ", mtagname=" + mtagname +
        ", addtime=" + addtime +
        "}";
    }
}
