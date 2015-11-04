import java.io.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.servlet.*;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.Query;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;



public class update extends HttpServlet{
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    Session session = null;
    Transaction tx=null;
    String sectionNo = (String)(request.getParameter("select2"));
    String firstName = request.getParameter("firname");
    String lastName = request.getParameter("laname");
    String email = request.getParameter("email");
    String passworde=request.getParameter("password");
    String centreNo=(String)(request.getParameter("select3"));
    HttpSession ses =request.getSession();
    String username=(String)ses.getAttribute("username");

    try{
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx=session.beginTransaction();
        byte[] cleartext = passworde.getBytes("UTF8");
        DESKeySpec keySpec = new DESKeySpec("Your secret Key phrase".getBytes("UTF8"));
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(keySpec);
        sun.misc.BASE64Encoder base64encoder = new BASE64Encoder();
        sun.misc.BASE64Decoder base64decoder = new BASE64Decoder();

        Cipher cipher = Cipher.getInstance("DES"); // cipher is not thread safe
        cipher.init(Cipher.ENCRYPT_MODE, key);
        String password = base64encoder.encode(cipher.doFinal(cleartext));


        String hql = "update owner set owner_last_name='"+lastName+"', owner_first_name='"+firstName+"', email='"+email+"', section_id='"+sectionNo+"', password='"+password+"', cost_id='"+centreNo+"' where user_name='"+username+"'";
        Query q = session.createQuery(hql);
        q.executeUpdate();
        response.sendRedirect("admin/edit_profile.jsp");
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