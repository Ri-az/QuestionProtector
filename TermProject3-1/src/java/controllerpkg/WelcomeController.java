/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerpkg;

import dataaccessobject.Database;
import dtatransferobjects.*;
import globalpkg.*;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Jakir Hossain Riaz
 */
@Controller
public class WelcomeController implements Controller {

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String welcomemethod(ModelMap model) {
        model.addAttribute("logindto", new LoginDTO());
        return "welcome";
    }

    @RequestMapping(value = "/checkvalidity", method = RequestMethod.POST)
    public String checkvalididtymethod(@ModelAttribute LoginDTO logindto, ModelMap model) {
        Database db = new Database();
        if (db.createconnection()) {
            String query = "select * from logininfo where username = '" + logindto.getUname() + "' and password='" + logindto.getPass() + "'";
            ResultSet output = db.search(query);
            try {
                if (output.next()) {
                    String tores = output.getString("email");

                    //mail section---------------------
                    Mail m = new Mail();
                    if (m.sendmail(tores, output.getString("id"))) {
//                    GlobalVariables ob = GlobalVariables.getInstance();
//                    ob.setUserid(output.getString("id"));
                    model.addAttribute("secure", "show");
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(WelcomeController.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println("query error");
            }

        }
        db.closeconnection();
        return "welcome";
    }

    @RequestMapping(value = "/security", method = RequestMethod.POST)
    public String securitymethod(@ModelAttribute LoginDTO logindto, ModelMap model) {
        GlobalVariables gv = GlobalVariables.getInstance();
        String id = gv.getUserid();
        Database db = new Database();
        String securitycode;
        if (db.createconnection()) {
            try {
                String qr = "select *from logininfo where id='" + id + "'";
                ResultSet rs = db.search(qr);
                if (rs.next()) {
                    securitycode = rs.getString("logsecure");
                    if (securitycode.equals(logindto.getSec())) {

                        gv.setUsertype(rs.getString("category"));
                        gv.setIsvalidlogin(true);

                        model.addAttribute("Uname", rs.getString("username"));
                        model.addAttribute("board", rs.getString("board"));
                        model.addAttribute("uid", rs.getString("id"));

                        if (rs.getString("category").equals("admin")) {
                            return "home";
                        } else if (rs.getString("category").equals("user")) {
                            return "userpage";
                        }
                    }
                }

            } catch (SQLException ex) {
                Logger.getLogger(WelcomeController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        db.closeconnection();
        model.addAttribute("secure", "show");
        return "welcome";

    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String homeMethod(ModelMap model) {
        GlobalVariables gv = GlobalVariables.getInstance();
        if (gv.isIsvalidlogin()) {
            model.addAttribute("homedto", new HomeDTO());
            return "home";
        }
        return "welcome";
    }

    @RequestMapping(value = "/adduser", method = RequestMethod.POST)
    public String addusermethod(@ModelAttribute HomeDTO homedto, ModelMap model) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "insert into logininfo values(" + 0 + ",'" + homedto.getUname() + "','" + homedto.getPwd() + "','" + homedto.getBrd() + "','" + homedto.getCity() + "','" + homedto.getMbl() + "','" + homedto.getEmail() + "','" + homedto.getType() + "','" + homedto.getCentercode() + "',3465,4567)";
            if (db.manipulate(qr)) {
                model.addAttribute("checkadduser", "ok");
            } else {
                model.addAttribute("checkadduser", "no");
            }
        } else {
            model.addAttribute("checkadduser", "no");
        }
        db.closeconnection();
        return "home";
    }

    @RequestMapping(value = "/deleteuser")
    public String deleteusermethod(@RequestParam int id, HttpServletRequest rq, HttpServletResponse rs) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "delete from logininfo where id=" + id;
            db.manipulate(qr);
        } else {
            System.out.println("delete connection error.");
        }
        db.closeconnection();
        return "home";
    }

    @RequestMapping(value = "/updateuser", method = RequestMethod.POST)
    public String updateusermethod(@ModelAttribute HomeDTO homedto, ModelMap model) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "update logininfo set username='" + homedto.getUname1() + "', password='" + homedto.getPwd1() + "', board='" + homedto.getBrd1() + "',city='" + homedto.getCity1() + "',phoneno='" + homedto.getMbl1() + "',email='" + homedto.getEmail1() + "',category='" + homedto.getType1() + "',centercode='" + homedto.getCentercode1() + "' where id='" + homedto.getTableid() + "'";
            if (db.manipulate(qr)) {
                model.addAttribute("checkadduser", "ok");
            } else {
                model.addAttribute("checkadduser", "no");
            }
        } else {
            model.addAttribute("checkadduser", "no");
        }
        db.closeconnection();
        return "home";
    }

    @RequestMapping(value = "/FileUpload", method = RequestMethod.GET)
    public String FileUploadmethod(ModelMap model) {
        model.addAttribute("filedto", new FileuploadDTO());
        return "FileUpload";
    }

    @RequestMapping(value = "/fileuploadaction", method = RequestMethod.POST)
    public String fileuploadactionmethod(@ModelAttribute FileuploadDTO fileuploaddto, ModelMap model) throws IOException {

        Database db = new Database();
        if (db.createconnection()) {
            String date = fileuploaddto.getDate();
            String subcode = fileuploaddto.getSubcode();
            for (MultipartFile m : fileuploaddto.getFilename()) {

                String qr = "insert into fileinfo values ('" + 0 + "','" + date + "','" + subcode + "','" + m.getOriginalFilename() + "', ?,'" + m.getSize() + "','" + m.getContentType() + "','" + fileuploaddto.getBoard() + "','" + fileuploaddto.getTime() + "')";
                if (db.fileupload(qr, m)) {
                    System.out.println("Successfully uploaded files");
                } else {
                    System.out.println("files upload failed");
                }
            }
        } else {
            System.out.println("Database connection error");
        }
        db.closeconnection();
        model.addAttribute("filedto", new FileuploadDTO());
        return "FileUpload";
    }

    @RequestMapping(value = "/FileShow", method = RequestMethod.GET)
    public String fileshowmethod(@RequestParam int id, @RequestParam String tab, ModelMap model) {
        model.addAttribute("index", id);
        model.addAttribute("table", tab);
        return "FileShow";
    }

    @RequestMapping(value = "/deleteFile")
    public String deleteFilemethod(@RequestParam int id, HttpServletRequest rq, HttpServletResponse rs) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "delete from fileinfo where id=" + id;
            db.manipulate(qr);
        } else {
            System.out.println("delete connection error.");
        }
        db.closeconnection();
        return "FileUpload";
    }

    @RequestMapping(value = "/searchfile", method = RequestMethod.GET)
    public String SearchFilemethod(@RequestParam String date, @RequestParam String scode, @RequestParam String board, ModelMap model) {
        if (date == null || date.isEmpty()) {
            date = "";
        }
        if (scode == null || scode.isEmpty() || scode.equals("ALL")) {
            scode = "";
        }
        if (board == null || board.isEmpty() || board.equals("all")) {
            board = "";
        }
        model.addAttribute("date", date);
        model.addAttribute("scode", scode);
        model.addAttribute("board", board);
        return "FileUpload";
    }

    @RequestMapping(value = "/randnumb", method = RequestMethod.GET)
    public String Randmethod(@RequestParam String date, @RequestParam String scode, @RequestParam String board, @RequestParam int cnt, ModelMap mdl, HttpServletRequest rq, HttpServletResponse rs) {
        System.out.println(date + " " + scode + " " + board);

        if (date == null || date.isEmpty()) {
            date = "";
        }
        if (scode == null || scode.isEmpty()) {
            scode = "";
        }
        if (board == null || board.isEmpty() || board.equals("all")) {
            board = "";
        }

        Random ran = new Random();
        int n = ran.nextInt(cnt) + 1;

        mdl.addAttribute("date", date);
        mdl.addAttribute("scode", scode);
        mdl.addAttribute("board", board);
        mdl.addAttribute("myrnd", n);
        return "FileUpload";
    }

    @RequestMapping(value = "/sendrandfile", method = RequestMethod.GET)
    public String sendrandfilemethod(@RequestParam String fileid, @RequestParam String board, ModelMap model) {
        Database db = new Database();
        if (db.createconnection()) {
            if (!fileid.equals("0")) {
                String qr = "update usertype set fileid='" + fileid + "'where board='" + board + "'";

                if (db.manipulate(qr)) {
                    System.out.println("file send successful");
                    model.addAttribute("Alert", "yes");
                }
            } else {
                System.out.println("file send unsuccessful");
                model.addAttribute("Alert", "no");
            }
        } else {
            System.out.println("database connnection error in sendfile");
            model.addAttribute("Alert", "no");
        }
        db.closeconnection();
        return "FileUpload";
    }

    @RequestMapping(value = "/userpage", method = RequestMethod.GET)
    public String userpagemethod(ModelMap model) {
        return "userpage";
    }

    @RequestMapping(value = "/questionsecurity", method = RequestMethod.GET)
    public String questionsecuritymethod(@RequestParam String fid, @RequestParam String uid, ModelMap model) {
        String uname = "";
        String ubrd = "";
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "select *from logininfo where id='" + uid + "'";
            ResultSet rs = db.search(qr);
            try {
                while (rs.next()) {
                    String tores = rs.getString("email");
                    uname = rs.getString("username");
                    ubrd = rs.getString("board");
                    //mail section
                    final String host = "smtp.gmail.com";
                    final String username = "jakhos97@gmail.com";
                    final String password = "rtkpyflblvrbmuil";
                    String subject = "Question Protector Security Code";
                    boolean sessionDebug = false;

                    Random ran = new Random();
                    String code = "";
                    for (int i = 0; i < 6; i++) {
                        code += ran.nextInt(9);
                    }
                    System.out.println("Security Code: " + code);

                    Properties props = new Properties();
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.host", host);
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.starttls.required", true);

                    java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());

                    Session session = Session.getInstance(props, null);
                    session.setDebug(sessionDebug);

                    try {

                        Message message = new MimeMessage(session);
                        message.setFrom(new InternetAddress(username));
                        InternetAddress[] address = {new InternetAddress(tores)};
                        message.setRecipients(Message.RecipientType.TO, address);
                        message.setSubject(subject);
                        message.setText("Your question security code is: " + code);

                        Transport transport = session.getTransport("smtp");
                        transport.connect(host, username, password);
                        transport.sendMessage(message, message.getAllRecipients());
                        transport.close();
                        System.out.println("Done");

                        if (db.createconnection()) {
                            String codeup = "update logininfo set quessecure='" + code + "'where id='" + uid + "'";
                            if (db.manipulate(codeup)) {
                                System.out.println("security code inserted into database");
                            } else {
                                System.out.println("security code update failed");
                            }
                        }

                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }

                }
            } catch (SQLException ex) {
                Logger.getLogger(WelcomeController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        db.closeconnection();
        model.addAttribute("fileid", fid);
        model.addAttribute("uid", uid);
        model.addAttribute("showdialoge", "yes");
        model.addAttribute("Uname", uname);
        model.addAttribute("board", ubrd);
        return "userpage";
    }

    @RequestMapping(value = "/checkquessecurity", method = RequestMethod.GET)
    public String checkquessecuritymethod(@RequestParam String fid, @RequestParam String uid, @RequestParam String check, ModelMap model) {
        Database db = new Database();
        String textsec = check;
        if (db.createconnection()) {
            try {
                String qr = "select * from logininfo where id='" + uid + "'";
                ResultSet rs = db.search(qr);
                while (rs.next()) {
                    String val = rs.getString("quessecure");
                    if (val.equals(textsec)) {
                        model.addAttribute("index", fid);
                        model.addAttribute("table", "1");
                        return "FileShow";
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(WelcomeController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        model.addAttribute("fileid", fid);
        model.addAttribute("uid", uid);
        return "QuestionSecurity.show";

    }

    @RequestMapping(value = "/genhome", method = RequestMethod.GET)
    public String genhomemethod(ModelMap model) {
        return "genhome";
    }
    
    @RequestMapping(value = "/boardquesgen", method = RequestMethod.GET)
    public String boardquesgenmethod(ModelMap model,@RequestParam String s) {
        model.addAttribute("s",s);
        return "boardquesgen";
    }

    @RequestMapping(value = "/result", method = RequestMethod.GET)
    public String resultmethod(ModelMap model) {
        return "result";
    }

    @RequestMapping(value = "/notice", method = RequestMethod.GET)
    public String noticemethod(ModelMap model) {
        return "notice";
    }
    
    @RequestMapping(value = "/previousquestion", method = RequestMethod.GET)
    public String previousqustionmethod(ModelMap model) {
        model.addAttribute("boardquesdto", new BoardquesDTO());
        return "previousquestion";
    }
    
    @RequestMapping(value = "/boardquesupaction", method = RequestMethod.POST)
    public String fileuploadquesactionmethod(@ModelAttribute BoardquesDTO boardquesdto, ModelMap model) throws IOException {

        Database db = new Database();
        if (db.createconnection()) {
            String date = boardquesdto.getDate();
            String subcode = boardquesdto.getSubcode();
            for (MultipartFile m : boardquesdto.getFilename()) {

                String qr = "insert into boardques values ('" + 0 + "','" + date + "','" + subcode + "','" + m.getOriginalFilename() + "', ?,'" + m.getSize() + "','" + m.getContentType() + "','" + boardquesdto.getBoard()+ "')";
                if (db.fileupload(qr, m)) {
                    System.out.println("Successfully uploaded files");
                } else {
                    System.out.println("files upload failed");
                }
            }
        } else {
            System.out.println("Database connection error");
        }
        db.closeconnection();
        model.addAttribute("boardquesdto", new BoardquesDTO());
        return "previousquestion";
    }
    
    @RequestMapping(value = "/deleteboardques")
    public String deleteboardquesmethod(@RequestParam int id, HttpServletRequest rq, HttpServletResponse rs) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "delete from boardques where id=" + id;
            db.manipulate(qr);
        } else {
            System.out.println("delete connection error.");
        }
        db.closeconnection();
        return "previousquestion";
    }

    @RequestMapping(value = "/noticeupload", method = RequestMethod.GET)
    public String noticeuploadmethod(ModelMap model) {
        model.addAttribute("noticedto", new noticeuploadDTO());
        return "noticeupload";
    }

    @RequestMapping(value = "/noticeuploadaction", method = RequestMethod.POST)
    public String noticeuploadactionmethod(@ModelAttribute noticeuploadDTO noticedto, ModelMap model) throws IOException {

        Database db = new Database();
        if (db.createconnection()) {
            String date = noticedto.getDate();
            for (MultipartFile m : noticedto.getFilename()) {

                String qr = "insert into noticeinfo values ('" + 0 + "','" + date + "','" + m.getOriginalFilename() + "', ?,'" + m.getSize() + "','" + m.getContentType() + "')";
                if (db.fileupload(qr, m)) {
                    System.out.println("Successfully uploaded files");
                } else {
                    System.out.println("files upload failed");
                }
            }
        } else {
            System.out.println("Database connection error");
        }
        db.closeconnection();
        model.addAttribute("noticedto", new noticeuploadDTO());
        return "noticeupload";
    }

    @RequestMapping(value = "/deletenotice")
    public String deletenoticemethod(@RequestParam int id, HttpServletRequest rq, HttpServletResponse rs) {
        Database db = new Database();
        if (db.createconnection()) {
            String qr = "delete from noticeinfo where id=" + id;
            db.manipulate(qr);
        } else {
            System.out.println("delete connection error.");
        }
        db.closeconnection();
        return "noticeupload";
    }

    @Override
    public String value() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Class<? extends Annotation> annotationType() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
