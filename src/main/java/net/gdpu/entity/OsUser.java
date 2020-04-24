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
 * @since 2020-04-21
 */
@Data
@TableName("os_user")
public class OsUser extends Model<OsUser> {

    private static final long serialVersionUID = 1L;

    /**
     * 用户登录id
     */
    private String userid;
    /**
     * 用户密码
     */
    private String md5pass;
    /**
     * 用户名
     */
    private String username;
    /**
     * 用户类型
     */
    private Integer usertype;
    /**
     * 用户邮箱
     */
    private String usermail;
    /**
     * 注册日期
     */
    private String rigisttime;
    /**
     * 用户昵称
     */
    private String nickname;
    /**
     * 用户性别
     */
    private String usersex;
    /**
     * 是否黑名单
     */
    private Integer isblack;
    /**
     * 原密码
     */
    private String realpass;


    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getMd5pass() {
        return md5pass;
    }

    public void setMd5pass(String md5pass) {
        this.md5pass = md5pass;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getUsertype() {
        return usertype;
    }

    public void setUsertype(Integer usertype) {
        this.usertype = usertype;
    }

    public String getUsermail() {
        return usermail;
    }

    public void setUsermail(String usermail) {
        this.usermail = usermail;
    }

    public String getRigisttime() {
        return rigisttime;
    }

    public void setRigisttime(String rigisttime) {
        this.rigisttime = rigisttime;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUsersex() {
        return usersex;
    }

    public void setUsersex(String usersex) {
        this.usersex = usersex;
    }

    public Integer getIsblack() {
        return isblack;
    }

    public void setIsblack(Integer isblack) {
        this.isblack = isblack;
    }

    public String getRealpass() {
        return realpass;
    }

    public void setRealpass(String realpass) {
        this.realpass = realpass;
    }

    public static final String USERID = "userid";

    public static final String MD5PASS = "md5pass";

    public static final String USERNAME = "username";

    public static final String USERTYPE = "usertype";

    public static final String USERMAIL = "usermail";

    public static final String RIGISTTIME = "rigisttime";

    public static final String NICKNAME = "nickname";

    public static final String USERSEX = "usersex";

    public static final String ISBLACK = "isblack";

    public static final String REALPASS = "realpass";

    @Override
    protected Serializable pkVal() {
        return this.userid;
    }

    @Override
    public String toString() {
        return "OsUser{" +
        ", userid=" + userid +
        ", md5pass=" + md5pass +
        ", username=" + username +
        ", usertype=" + usertype +
        ", usermail=" + usermail +
        ", rigisttime=" + rigisttime +
        ", nickname=" + nickname +
        ", usersex=" + usersex +
        ", isblack=" + isblack +
        ", realpass=" + realpass +
        "}";
    }
}
