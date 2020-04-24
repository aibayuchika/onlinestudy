package net.gdpu.utils;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hslf.extractor.PowerPointExtractor;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xslf.extractor.XSLFPowerPointExtractor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.stereotype.Component;

import java.io.*;

@Component
public class CheckBanWord {
    private String[] banword = {"你妈死了","操你妈","草你妈","你妈逼","维尼","维尼熊"};
    //检测违禁词
    public boolean checkBanword(String keyword){
        if(keyword == null || keyword.equals("")){
            System.out.println("关键字空");
        }
        for(int i = 0; i < banword.length; i++){
            if(keyword.contains(banword[i])){
                System.out.println("存在违禁词。");
                return true;
            }
        }
        return  false;
    }

    //文档转码检测违禁词
    //word转码
    public String translateWord(String filetype, String sourcefilePath){
        String thePath = "F:/uploadFile/";
        File source = new File(thePath + sourcefilePath);
        if(!source.exists()){
            return "sourcemiss";
        }
        if(filetype.equals(".docx")){
            try {
                FileInputStream fis = new FileInputStream(source);
                XWPFDocument xdoc = new XWPFDocument(fis);
                XWPFWordExtractor extractor = new XWPFWordExtractor(xdoc);
                String docx = extractor.getText().replace("\n", "<br>")
                        .replace(" ", "&nbsp;");
                fis.close();
                return docx;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(filetype.equals(".doc")){
            try {
                FileInputStream fis = new FileInputStream(source);
                HWPFDocument worddoc = new HWPFDocument(fis);
                WordExtractor extractor = new WordExtractor(worddoc);
                String doc = extractor.getText().replace("\n", "<br>")
                        .replace(" ", "&nbsp;");
                fis.close();
                return doc;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "fail";
    }

    //excel转码
    public String translateExcel(String filetype, String sourcefilePath){
        String thePath = "F:/uploadFile/";
        File source = new File(thePath + sourcefilePath);
        if(!source.exists()){
            return "sourcemiss";
        }
        if(filetype.equals(".xls")){
            String xls = "";
            try {
                FileInputStream fis = new FileInputStream(source);
                StringBuilder sb = new StringBuilder();
                jxl.Workbook jwb = Workbook.getWorkbook(fis);
                Sheet[] sheet = jwb.getSheets();
                for(int i = 0; i < sheet.length; i++){
                    Sheet rs = jwb.getSheet(i);
                    for(int j = 0; j < rs.getRows(); j++){
                        Cell[] cells = rs.getRow(j);
                        sb.append("\n");
                        for(int k = 0; k < cells.length; k++){
                            sb.append(cells[k].getContents() + " | ");
                        }
                    }
                }
                fis.close();
                xls += sb.toString();
                return xls;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(filetype.equals(".xlsx")){
            String xlsx = "";
            try {
                FileInputStream fis = new FileInputStream(source);
                StringBuilder sb = new StringBuilder();
                XSSFWorkbook xwb = new XSSFWorkbook(fis);
                XSSFSheet sheet = xwb.getSheetAt(0);
                for(int i = sheet.getFirstRowNum() + 1; i < sheet.getPhysicalNumberOfRows(); i++){
                    XSSFRow row = sheet.getRow(i);
                    sb.append("\n");
                    for(int j = row.getFirstCellNum(); j < row.getPhysicalNumberOfCells(); j++){
                        sb.append(row.getCell(j).toString() + " | ");
                    }
                }
                fis.close();
                xlsx += sb.toString();
                return xlsx;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "fail";
    }

    //ppt转码
    public String translatePPT(String filetype, String sourcefilePath){
        String thePath = "F:/uploadFile/";
        File source = new File(thePath + sourcefilePath);
        if(!source.exists()){
            return "sourcemiss";
        }
        if(filetype.equals(".ppt")){
            try {
                FileInputStream fis = new FileInputStream(source);
                PowerPointExtractor pptExtractor = new PowerPointExtractor(fis);
                String ppt = pptExtractor.getText().replace("\n", "<br>")
                        .replace(" ", "&nbsp;");
                fis.close();
                return ppt;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(filetype.equals(".pptx")){
            try {
                OPCPackage opcPackage = POIXMLDocument.openPackage("F:/uploadFile/" + sourcefilePath);
                XSLFPowerPointExtractor extractor = new XSLFPowerPointExtractor(opcPackage);
                String pptx = extractor.getText().replace("\n", "<br>")
                        .replace(" ", "&nbsp;");
                return pptx;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "fail";
    }

    //pdf转码
    public String translatePDF(String sourcefilepath){
        File source = new File("F:/uploadFile/" + sourcefilepath);
        if(!source.exists()){
            return "sourcemiss";
        }
        try {
            PDDocument pdDocument = PDDocument.load(source);
            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setSortByPosition(false);
            String pdf = stripper.getText(pdDocument).replace("\n", "<br>")
                    .replace(" ", "&nbsp;");
            pdDocument.close();
            return pdf;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    //txt转码
    public String translateTXT(String sourcefilepath){
        File source = new File("F:/uploadFile/" + sourcefilepath);
        StringBuilder txt = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new FileReader(source));
            String s = null;
            while ((s = br.readLine()) != null){
                txt.append(System.lineSeparator() + s);
            }
            br.close();
            return txt.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }
}
