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
 * @since 2020-04-23
 */
@Data
@TableName("os_ziliao")
public class OsZiliao extends Model<OsZiliao> {

    private static final long serialVersionUID = 1L;

    /**
     * 资料id
     */
    private String ziliaoid;
    /**
     * 资料名
     */
    private String ziliaoname;
    /**
     * 资料上传时间
     */
    private String ziliaouploadtime;
    /**
     * 资料类型
     */
    private Integer ziliaotype;
    /**
     * 资料大小
     */
    private Double ziliaosize;
    /**
     * 资料封面路径
     */
    private String ziliaocoverpath;
    /**
     * 资料存放路径
     */
    private String ziliaosourcepath;
    /**
     * 资料预览路径
     */
    private String ziliaopreviewpath;
    /**
     * 资料简介
     */
    private String ziliaoabstract;
    /**
     * 资料后缀
     */
    private String ziliaosuffix;
    /**
     * 资料上传者id
     */
    private String ziliaoupdatorid;
    /**
     * 资料上传者名
     */
    private String ziliaoupdatorname;
    /**
     * 资料状态
     */
    private Integer ziliaostatus;
    /**
     * 资料失败原因
     */
    private String ziliaofailreason;
    /**
     * 资料点击数
     */
    private Integer ziliaoclick;
    /**
     * 资料点赞数
     */
    private Integer ziliaozan;
    /**
     * 资料点弹数
     */
    private Integer ziliaotan;
    /**
     * 资料热度
     */
    private Double ziliaoheat;
    /**
     * 资料标签
     */
    private String ziliaotag;
    /**
     * 资料修改时间
     */
    private String ziliaoupdatetime;


    public String getZiliaoid() {
        return ziliaoid;
    }

    public void setZiliaoid(String ziliaoid) {
        this.ziliaoid = ziliaoid;
    }

    public String getZiliaoname() {
        return ziliaoname;
    }

    public void setZiliaoname(String ziliaoname) {
        this.ziliaoname = ziliaoname;
    }

    public String getZiliaouploadtime() {
        return ziliaouploadtime;
    }

    public void setZiliaouploadtime(String ziliaouploadtime) {
        this.ziliaouploadtime = ziliaouploadtime;
    }

    public Integer getZiliaotype() {
        return ziliaotype;
    }

    public void setZiliaotype(Integer ziliaotype) {
        this.ziliaotype = ziliaotype;
    }

    public Double getZiliaosize() {
        return ziliaosize;
    }

    public void setZiliaosize(Double ziliaosize) {
        this.ziliaosize = ziliaosize;
    }

    public String getZiliaocoverpath() {
        return ziliaocoverpath;
    }

    public void setZiliaocoverpath(String ziliaocoverpath) {
        this.ziliaocoverpath = ziliaocoverpath;
    }

    public String getZiliaosourcepath() {
        return ziliaosourcepath;
    }

    public void setZiliaosourcepath(String ziliaosourcepath) {
        this.ziliaosourcepath = ziliaosourcepath;
    }

    public String getZiliaopreviewpath() {
        return ziliaopreviewpath;
    }

    public void setZiliaopreviewpath(String ziliaopreviewpath) {
        this.ziliaopreviewpath = ziliaopreviewpath;
    }

    public String getZiliaoabstract() {
        return ziliaoabstract;
    }

    public void setZiliaoabstract(String ziliaoabstract) {
        this.ziliaoabstract = ziliaoabstract;
    }

    public String getZiliaosuffix() {
        return ziliaosuffix;
    }

    public void setZiliaosuffix(String ziliaosuffix) {
        this.ziliaosuffix = ziliaosuffix;
    }

    public String getZiliaoupdatorid() {
        return ziliaoupdatorid;
    }

    public void setZiliaoupdatorid(String ziliaoupdatorid) {
        this.ziliaoupdatorid = ziliaoupdatorid;
    }

    public String getZiliaoupdatorname() {
        return ziliaoupdatorname;
    }

    public void setZiliaoupdatorname(String ziliaoupdatorname) {
        this.ziliaoupdatorname = ziliaoupdatorname;
    }

    public Integer getZiliaostatus() {
        return ziliaostatus;
    }

    public void setZiliaostatus(Integer ziliaostatus) {
        this.ziliaostatus = ziliaostatus;
    }

    public String getZiliaofailreason() {
        return ziliaofailreason;
    }

    public void setZiliaofailreason(String ziliaofailreason) {
        this.ziliaofailreason = ziliaofailreason;
    }

    public Integer getZiliaoclick() {
        return ziliaoclick;
    }

    public void setZiliaoclick(Integer ziliaoclick) {
        this.ziliaoclick = ziliaoclick;
    }

    public Integer getZiliaozan() {
        return ziliaozan;
    }

    public void setZiliaozan(Integer ziliaozan) {
        this.ziliaozan = ziliaozan;
    }

    public Integer getZiliaotan() {
        return ziliaotan;
    }

    public void setZiliaotan(Integer ziliaotan) {
        this.ziliaotan = ziliaotan;
    }

    public Double getZiliaoheat() {
        return ziliaoheat;
    }

    public void setZiliaoheat(Double ziliaoheat) {
        this.ziliaoheat = ziliaoheat;
    }

    public String getZiliaotag() {
        return ziliaotag;
    }

    public void setZiliaotag(String ziliaotag) {
        this.ziliaotag = ziliaotag;
    }

    public String getZiliaoupdatetime() {
        return ziliaoupdatetime;
    }

    public void setZiliaoupdatetime(String ziliaoupdatetime) {
        this.ziliaoupdatetime = ziliaoupdatetime;
    }

    public static final String ZILIAOID = "ziliaoid";

    public static final String ZILIAONAME = "ziliaoname";

    public static final String ZILIAOUPLOADTIME = "ziliaouploadtime";

    public static final String ZILIAOTYPE = "ziliaotype";

    public static final String ZILIAOSIZE = "ziliaosize";

    public static final String ZILIAOCOVERPATH = "ziliaocoverpath";

    public static final String ZILIAOSOURCEPATH = "ziliaosourcepath";

    public static final String ZILIAOPREVIEWPATH = "ziliaopreviewpath";

    public static final String ZILIAOABSTRACT = "ziliaoabstract";

    public static final String ZILIAOSUFFIX = "ziliaosuffix";

    public static final String ZILIAOUPDATORID = "ziliaoupdatorid";

    public static final String ZILIAOUPDATORNAME = "ziliaoupdatorname";

    public static final String ZILIAOSTATUS = "ziliaostatus";

    public static final String ZILIAOFAILREASON = "ziliaofailreason";

    public static final String ZILIAOCLICK = "ziliaoclick";

    public static final String ZILIAOZAN = "ziliaozan";

    public static final String ZILIAOTAN = "ziliaotan";

    public static final String ZILIAOHEAT = "ziliaoheat";

    public static final String ZILIAOTAG = "ziliaotag";

    public static final String ZILIAOUPDATETIME = "ziliaoupdatetime";

    @Override
    protected Serializable pkVal() {
        return this.ziliaoid;
    }

    @Override
    public String toString() {
        return "OsZiliao{" +
        ", ziliaoid=" + ziliaoid +
        ", ziliaoname=" + ziliaoname +
        ", ziliaouploadtime=" + ziliaouploadtime +
        ", ziliaotype=" + ziliaotype +
        ", ziliaosize=" + ziliaosize +
        ", ziliaocoverpath=" + ziliaocoverpath +
        ", ziliaosourcepath=" + ziliaosourcepath +
        ", ziliaopreviewpath=" + ziliaopreviewpath +
        ", ziliaoabstract=" + ziliaoabstract +
        ", ziliaosuffix=" + ziliaosuffix +
        ", ziliaoupdatorid=" + ziliaoupdatorid +
        ", ziliaoupdatorname=" + ziliaoupdatorname +
        ", ziliaostatus=" + ziliaostatus +
        ", ziliaofailreason=" + ziliaofailreason +
        ", ziliaoclick=" + ziliaoclick +
        ", ziliaozan=" + ziliaozan +
        ", ziliaotan=" + ziliaotan +
        ", ziliaoheat=" + ziliaoheat +
        ", ziliaotag=" + ziliaotag +
        ", ziliaoupdatetime=" + ziliaoupdatetime +
        "}";
    }
}
