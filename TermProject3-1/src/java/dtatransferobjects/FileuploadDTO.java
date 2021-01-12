/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtatransferobjects;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Jakir Hossain Riaz
 */
public class FileuploadDTO {

    @DateTimeFormat(pattern= "dd/MM/yyyy")
    private String date;
    private String subcode;
    private String board;
    private String time;
    private MultipartFile[] filename;
    
    //add file --------------------------------------
    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    

    public String getSubcode() {
        return subcode;
    }

    public void setSubcode(String subcode) {
        this.subcode = subcode;
    }

    public MultipartFile[] getFilename() {
        return filename;
    }
    public void setFilename(MultipartFile[] filename) {
        this.filename = filename;
    }
    
    public String getBoard() {
        return board;
    }

    public void setBoard(String board) {
        this.board = board;
    }
    
}
