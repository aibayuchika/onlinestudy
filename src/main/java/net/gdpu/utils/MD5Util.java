package net.gdpu.utils;

import org.springframework.stereotype.Component;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Component
public class MD5Util {
    public String string2MD5(String key){
        MessageDigest md5 = null;
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        char[] charArray = key.toCharArray();
        byte[] byteArray = new byte[charArray.length];

        for(int i = 0; i < charArray.length; i++)
            byteArray[i] = (byte) charArray[i];
        byte[] md5Byte = md5.digest(byteArray);
        StringBuffer hexValue = new StringBuffer();
        for(int j = 0; j < md5Byte.length; j++){
            int val = ((int) md5Byte[j]) & 0xff;
            if(val < 16)
                hexValue.append("0");
            hexValue.append(Integer.toHexString(val));
        }
        return hexValue.toString();
    }
}
