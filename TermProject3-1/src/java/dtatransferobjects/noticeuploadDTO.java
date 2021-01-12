/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtatransferobjects;

/**
 *
 * @author Jakir Hossain Riaz
 */

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;


public class noticeuploadDTO {
    @DateTimeFormat(pattern= "dd/MM/yyyy")
    private String date;
    private MultipartFile[] filename;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public MultipartFile[] getFilename() {
        return filename;
    }

    public void setFilename(MultipartFile[] filename) {
        this.filename = filename;
    }
}
