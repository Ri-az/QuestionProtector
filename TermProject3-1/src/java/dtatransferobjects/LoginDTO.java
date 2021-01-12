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
public class LoginDTO {
    private String uname;
    private String pass;
    private String sec;

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
    public String getSec() {
        return sec;
    }

    public void setSec(String sec) {
        this.sec = sec;
    }
    
}
