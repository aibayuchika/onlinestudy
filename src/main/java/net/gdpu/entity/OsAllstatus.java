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
 * @since 2020-03-01
 */
@Data
@TableName("os_allstatus")
public class OsAllstatus extends Model<OsAllstatus> {

    private static final long serialVersionUID = 1L;

    /**
     * 状态id
     */
    @TableId(value = "statusid", type = IdType.AUTO)
    private Integer statusid;
    /**
     * 状态名
     */
    private String statusname;


    public Integer getStatusid() {
        return statusid;
    }

    public void setStatusid(Integer statusid) {
        this.statusid = statusid;
    }

    public String getStatusname() {
        return statusname;
    }

    public void setStatusname(String statusname) {
        this.statusname = statusname;
    }

    public static final String STATUSID = "statusid";

    public static final String STATUSNAME = "statusname";

    @Override
    protected Serializable pkVal() {
        return this.statusid;
    }

    @Override
    public String toString() {
        return "OsAllstatus{" +
        ", statusid=" + statusid +
        ", statusname=" + statusname +
        "}";
    }
}
