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
@TableName("os_loginstatus")
public class OsLoginstatus extends Model<OsLoginstatus> {

    private static final long serialVersionUID = 1L;

    /**
     * 排序用id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 用户登录id
     */
    private String userid;
    /**
     * 登录时间
     */
    private String logintime;
    /**
     * 登录ip
     */
    private String loginip;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getLogintime() {
        return logintime;
    }

    public void setLogintime(String logintime) {
        this.logintime = logintime;
    }

    public String getLoginip() {
        return loginip;
    }

    public void setLoginip(String loginip) {
        this.loginip = loginip;
    }

    public static final String ID = "id";

    public static final String USERID = "userid";

    public static final String LOGINTIME = "logintime";

    public static final String LOGINIP = "loginip";

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "OsLoginstatus{" +
        ", id=" + id +
        ", userid=" + userid +
        ", logintime=" + logintime +
        ", loginip=" + loginip +
        "}";
    }
}
