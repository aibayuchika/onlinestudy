package net.gdpu.entity;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
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
 * @since 2020-04-19
 */
@Data
@TableName("os_dianzan")
public class OsDianzan extends Model<OsDianzan> {

    private static final long serialVersionUID = 1L;

    /**
     * 点赞id
     */
    @TableId(value = "dian_id", type = IdType.AUTO)
    private Integer dianId;
    /**
     * 点赞用户
     */
    @TableField("dian_userid")
    private String dianUserid;
    /**
     * 点赞情况（1赞，2弹）
     */
    @TableField("dian_status")
    private Integer dianStatus;
    /**
     * 点的时间
     */
    @TableField("dian_time")
    private String dianTime;
    /**
     * 资料id
     */
    @TableField("dian_ziliao")
    private String dianZiliao;


    public Integer getDianId() {
        return dianId;
    }

    public void setDianId(Integer dianId) {
        this.dianId = dianId;
    }

    public String getDianUserid() {
        return dianUserid;
    }

    public void setDianUserid(String dianUserid) {
        this.dianUserid = dianUserid;
    }

    public Integer getDianStatus() {
        return dianStatus;
    }

    public void setDianStatus(Integer dianStatus) {
        this.dianStatus = dianStatus;
    }

    public String getDianTime() {
        return dianTime;
    }

    public void setDianTime(String dianTime) {
        this.dianTime = dianTime;
    }

    public String getDianZiliao() {
        return dianZiliao;
    }

    public void setDianZiliao(String dianZiliao) {
        this.dianZiliao = dianZiliao;
    }

    public static final String DIAN_ID = "dian_id";

    public static final String DIAN_USERID = "dian_userid";

    public static final String DIAN_STATUS = "dian_status";

    public static final String DIAN_TIME = "dian_time";

    public static final String DIAN_ZILIAO = "dian_ziliao";

    @Override
    protected Serializable pkVal() {
        return this.dianId;
    }

    @Override
    public String toString() {
        return "OsDianzan{" +
        ", dianId=" + dianId +
        ", dianUserid=" + dianUserid +
        ", dianStatus=" + dianStatus +
        ", dianTime=" + dianTime +
        ", dianZiliao=" + dianZiliao +
        "}";
    }
}
