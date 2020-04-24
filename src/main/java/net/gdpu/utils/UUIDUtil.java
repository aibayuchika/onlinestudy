package net.gdpu.utils;

import java.util.UUID;

public class UUIDUtil {
    /**
     * UUID操作
     * **/
    //UUID校验
    public static boolean isValidUUID(String uuid){
        if(uuid == null){
            System.out.println("uuid is null");
        }
        String regex = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$";
        if(uuid.matches(regex)){
            return true;
        }
        return false;
    }
    //生成UUID
    public static String getRandomUUID(String str){
        if(str == null){
            return UUID.randomUUID().toString();
        }else {
            return UUID.nameUUIDFromBytes(str.getBytes()).toString();
        }
    }
}
