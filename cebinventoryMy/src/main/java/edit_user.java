import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.List;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class edit_user extends HttpServlet{
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    Session session = null;
    Transaction tx=null;

    try{
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx=session.beginTransaction();
        HttpSession ses =request.getSession();
        String username=(String)ses.getAttribute("username");

        List empList = session.createQuery("from owner where user_name='"+username+"'").list();

        pw.println("<HTML>");
        pw.println("<HEAD>");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/val.js");
        dispatcher.include(request, response);
        pw.println("</HEAD>");
        pw.println("<BODY>");
        pw.println("<TABLE WIDTH='340'>");
        pw.println("<form id='form2' name='form2' action='../update' onSubmit='return validateFormOnSubmit(form2);'>");
        pw.println("<tr><td width='160'>&nbsp;</td><td width='170'>&nbsp;</td> </tr>");
        owner emp = (owner)empList.get(0);
        String last_name=emp.getOwner_last_name();
        String first_name=emp.getOwner_first_name();
        String section_id=emp.getSection_id();
        String centre_id=emp.getCost_id();
        String email=emp.getEmail();
        String password2=emp.getPassword();


        DESKeySpec keySpec = new DESKeySpec("Your secret Key phrase".getBytes("UTF8"));
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(keySpec);
        sun.misc.BASE64Encoder base64encoder = new BASE64Encoder();
        sun.misc.BASE64Decoder base64decoder = new BASE64Decoder();

        byte[] encrypedPwdBytes = base64decoder.decodeBuffer(password2);

        Cipher cipher = Cipher.getInstance("DES");
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] plainTextPwdBytes = (cipher.doFinal(encrypedPwdBytes));
        String password=new String(plainTextPwdBytes);

        String newPassword;

        pw.println("<tr><td>Centre No: </td>");
        pw.println("<td colspan='2'><select name='select2'  id='coce' onclick='selectCoCe();selectSec();'  onchange='selectSec();'></select></td>");
        pw.println("</tr>");

        pw.println("<tr><td>Section No: </td>");
        pw.println("<td colspan='2'><select name='select3' id='sec'></select></td>");
        pw.println("</tr>");

        pw.println("<tr><td>First Name: </td>");
        pw.println("<td><input name='firname' id='firname' value="+first_name+"></td>");
        pw.println("</tr>");

        pw.println("<tr><td>Last Name: </td>");
        pw.println("<td><input name='laname' id='laname' value="+last_name+"></td>");
        pw.println("</tr>");

        pw.println("<tr><td>Email: </td>");
        pw.println("<td><input name='email' id='email' value="+email+"></td>");
        pw.println("</tr>");
        pw.println("<tr><td>New Password: </td>");
        pw.println("<td><input name='password' id='password' type='password' value="+password+"></td>");
        pw.println("</tr>");
        pw.println("<tr><td>Confirm New Password: </td>");
        pw.println("<td><input name='newPassword' id='newPassword' type='password' value="+password+"></td>");
        pw.println("</tr>");

        pw.println("<tr><td> </td>");
        pw.println("<td><input type='submit' value='update' onclick='return validateFormOnSubmit(form2)'> </td>");
        pw.println("</tr>");
        pw.println("</TABLE>");
        pw.println("</form>");
        tx.commit();


        }catch(Exception e){
            tx.rollback();
            System.out.println(e.getMessage());
        }finally{
            session.flush();
            session.close();
        }
    }
}