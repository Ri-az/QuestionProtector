/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package globalpkg;

import dataaccessobject.Database;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Jakir Hossain Riaz
 */
public class Mail {

    public boolean sendmail(String tores, String id) {
        Database db = new Database();

        final String host = "smtp.gmail.com";
        final String username = "jakhos97@gmail.com";
        final String password = "rtkpyflblvrbmuil";
        String subject = "Question Protector Sign In Security Code";
        boolean sessionDebug = false;

        Random ran = new Random();
        String code = "";
        for (int i = 0; i < 6; i++) {
            code += ran.nextInt(9);
        }
        //System.out.println("Security Code: " + code);

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
            message.setText("Your logging security code is: " + code);

            Transport transport = session.getTransport("smtp");
            transport.connect(host, username, password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
            System.out.println("Done");

            GlobalVariables ob = GlobalVariables.getInstance();
            ob.setUserid(id);
            if (db.createconnection()) {
                String codeup = "update logininfo set logsecure='" + code + "'where id='" + id + "'";
                if (db.manipulate(codeup)) {
                    System.out.println("security code inserted into database");
                    return true;
                } else {
                    System.out.println("security code update failed");
                }
            }

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        db.closeconnection();
        return false;
    }
}
