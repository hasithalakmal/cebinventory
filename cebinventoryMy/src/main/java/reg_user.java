import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;


import java.lang.Object.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class reg_user extends HttpServlet{
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    Session session = null;
    Transaction tx=null;
    String sectionNo = (String)(request.getParameter("select3"));
    String centreNo=(String)(request.getParameter("select2"));
    String firstName = request.getParameter("tf_firstName");
    String lastName = request.getParameter("tf_lastName");
    String email = request.getParameter("tf_email");
    String userName = request.getParameter("tf_userName");
    String password = request.getParameter("tf_password");
    String role;
    HttpSession ses =request.getSession();
    byte[] cleartext = password.getBytes("UTF8");
    String username=(String)ses.getAttribute("username");
    if(username == null){
        role= "not defined";

    }
    else{
        role =(String)(request.getParameter("select"));
    }
    try{
        DESKeySpec keySpec = new DESKeySpec("Your secret Key phrase".getBytes("UTF8"));
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(keySpec);
        sun.misc.BASE64Encoder base64encoder = new BASE64Encoder();
        sun.misc.BASE64Decoder base64decoder = new BASE64Decoder();

        Cipher cipher = Cipher.getInstance("DES"); // cipher is not thread safe
        cipher.init(Cipher.ENCRYPT_MODE, key);
        String encrypedPwd = base64encoder.encode(cipher.doFinal(cleartext));

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx=session.beginTransaction();
        owner contact = new owner();
        contact.setUser_name(userName);
        contact.setOwner_first_name(firstName);
        contact.setOwner_last_name(lastName);
        contact.setSection_id(sectionNo);
        contact.setCost_id(centreNo);
        contact.setEmail(email);
        contact.setPassword(encrypedPwd);

        contact.setUser_role(role);
        if(role.equals("not defined")){
            contact.setApproved("no");
        }
        else{
        contact.setApproved("yes");
        }
        contact.setStatus("working");

        session.save(contact);

        tx.commit();
        pw.print("Succesfully registered");
        if(role.equals("not defined")){
            response.sendRedirect("login/register.jsp");
        }
        else{
        response.sendRedirect("admin/adduser.jsp");
        }

    }catch(Exception e){
        tx.rollback();
        pw.print(e.getMessage());
        System.out.println(e.getMessage());
    }finally{
        session.flush();
        session.close();
    }
  }
}