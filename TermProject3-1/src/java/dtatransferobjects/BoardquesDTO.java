/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtatransferobjects;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Jakir Hossain Riaz
 */
public class BoardquesDTO {
     @DateTimeFormat(pattern= "dd/MM/yyyy")
    private String date;
    private String subcode;
    private String board;
    private MultipartFile[] filename;

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

    public String getBoard() {
        return board;
    }

    public void setBoard(String board) {
        this.board = board;
    }

    public MultipartFile[] getFilename() {
        return filename;
    }

    public void setFilename(MultipartFile[] filename) {
        this.filename = filename;
    }
}
