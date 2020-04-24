package net.gdpu.utils;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import org.springframework.stereotype.Component;

import java.io.File;
import java.net.ConnectException;

@Component
public class TransToPdf {

    public static String trans2Pdf(String sourcePath, String uuid){
        System.out.println("the sourcefile path is : " + sourcePath);
        File sourceFile = new File(sourcePath);
        if(!sourceFile.exists()){
            System.out.println("源文件不存在！");
            return "sourcemiss";
        }
        try{
            File desFile = new File("F:/uploadFile/previews" + uuid + ".pdf");
            OpenOfficeConnection connection = new SocketOpenOfficeConnection("127.0.0.1", 8100);
            connection.connect();
            DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
            converter.convert(sourceFile, desFile);
            return "success";
        } catch (ConnectException e) {
            e.printStackTrace();
        }
        return "fail";
    }

}
