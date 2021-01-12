/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataaccessobject;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Jakir Hossain Riaz
 */
public class Database {

    Connection con;

    public boolean createconnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/questionprotector", "root", "110305");

            return true;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("db connection error");
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("db connection error sq1");
            return false;
        }
    }

    public boolean closeconnection() {
        try {
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("connection closing error");
            return false;
        }
    }

    public ResultSet search(String qr) {
        Statement st;
        try {
            st = con.createStatement();
            return st.executeQuery(qr);
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("search queru execution error");
            return null;
        }
    }

    public boolean manipulate(String qr) {
        try {
            Statement st;
            st = con.createStatement();
            st.executeUpdate(qr);
            System.out.println("query successful");
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("query error");
            return false;
        }
    }

    public boolean fileupload(String qr, MultipartFile mf) {
        PreparedStatement ps;
        try {
            ps = con.prepareStatement(qr);
            ByteArrayInputStream bais = new ByteArrayInputStream(mf.getBytes());
            ps.setBinaryStream(1, bais);
            System.out.println("before execute update");
            ps.executeUpdate();
            System.out.println("blob file inserted");
            
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (IOException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }

}
