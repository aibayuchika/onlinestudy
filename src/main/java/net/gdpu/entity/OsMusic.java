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
@TableName("os_music")
public class OsMusic extends Model<OsMusic> {

    private static final long serialVersionUID = 1L;

    /**
     * 音乐id
     */
    private String musicid;
    /**
     * 音乐名
     */
    private String musicname;
    /**
     * 音乐分类
     */
    private String musictag;
    /**
     * 演唱者
     */
    private String artist;
    /**
     * 上传时间
     */
    private String uploadtime;
    /**
     * 修改时间
     */
    private String updatetime;
    /**
     * 音乐储存路径
     */
    private String musicpath;
    /**
     * 音乐状态
     */
    private Integer musicstatus;


    public String getMusicid() {
        return musicid;
    }

    public void setMusicid(String musicid) {
        this.musicid = musicid;
    }

    public String getMusicname() {
        return musicname;
    }

    public void setMusicname(String musicname) {
        this.musicname = musicname;
    }

    public String getMusictag() {
        return musictag;
    }

    public void setMusictag(String musictag) {
        this.musictag = musictag;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getUploadtime() {
        return uploadtime;
    }

    public void setUploadtime(String uploadtime) {
        this.uploadtime = uploadtime;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }

    public String getMusicpath() {
        return musicpath;
    }

    public void setMusicpath(String musicpath) {
        this.musicpath = musicpath;
    }

    public Integer getMusicstatus() {
        return musicstatus;
    }

    public void setMusicstatus(Integer musicstatus) {
        this.musicstatus = musicstatus;
    }

    public static final String MUSICID = "musicid";

    public static final String MUSICNAME = "musicname";

    public static final String MUSICTAG = "musictag";

    public static final String ARTIST = "artist";

    public static final String UPLOADTIME = "uploadtime";

    public static final String UPDATETIME = "updatetime";

    public static final String MUSICPATH = "musicpath";

    public static final String MUSICSTATUS = "musicstatus";

    @Override
    protected Serializable pkVal() {
        return this.musicid;
    }

    @Override
    public String toString() {
        return "OsMusic{" +
        ", musicid=" + musicid +
        ", musicname=" + musicname +
        ", musictag=" + musictag +
        ", artist=" + artist +
        ", uploadtime=" + uploadtime +
        ", updatetime=" + updatetime +
        ", musicpath=" + musicpath +
        ", musicstatus=" + musicstatus +
        "}";
    }
}
