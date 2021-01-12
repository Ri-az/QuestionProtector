/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package globalpkg;

import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Jakir Hossain Riaz
 */
public class GlobalVariables {
    private static GlobalVariables object=new GlobalVariables();
    
    public static GlobalVariables getInstance(){
        if(object==null) object=new GlobalVariables();
        return object;
    }
    
    private JSONObject admin,user,general;
    private String usertype;
    private String userid;
    private boolean isvalidlogin;

    private HashMap<String,String> itemtoid=new HashMap<String,String>(); 

    public HashMap<String, String> getItemtoid() {
        return itemtoid;
        
    }

    public void setItemtoid(HashMap<String, String> itemtoid) {
        this.itemtoid = itemtoid;
    }

    public boolean isIsvalidlogin() {
        return isvalidlogin;
    }

    public void setIsvalidlogin(boolean isvalidlogin) {
        this.isvalidlogin = isvalidlogin;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }
    
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
    
    public GlobalVariables(){
        try {
//            admin=new JSONObject("{'items':['User','Previous Question','File Upload','Notice Upload'],'checks':[0,1,0,0],'subitems':['home.show',{'sitems':['item 1','item 2'],'links':['link1.show','link2.show']},'FileUpload.show','noticeupload.show']}");
              admin=new JSONObject("{'items':['User','Previous Question','File Upload','Notice Upload'],'checks':[0,0,0,0],'subitems':['home.show','previousquestion.show','FileUpload.show','noticeupload.show']}");
        } catch (JSONException ex) {
            Logger.getLogger(GlobalVariables.class.getName()).log(Level.SEVERE, null, ex);
        }
        //creating hashmap
        itemtoid.put("User", "user");
//        itemtoid.put("item 1","it1");
//        itemtoid.put("item 2","it2");
        itemtoid.put("Previous Question","previousquestion");
        itemtoid.put("File Upload","fileupload");
        itemtoid.put("Notice Upload","noticeupload");
        
    }
    
    public JSONObject getMenuitems(String utype){
        return admin;
    }
      
}
