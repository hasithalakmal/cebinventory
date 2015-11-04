import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Log extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        List<owner> ownerList = null;
        HttpSession session1 = null;
        String warn = "warn";
        String page = "page";
        String username = request.getParameter("textfield");
        String password = request.getParameter("textfield2");

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();

        try {

            Query q = session.createQuery("from owner o where o.user_name='" + username + "'");
            ownerList = (List<owner>) q.list();

            if (ownerList.size() != 0) {

                String pword2 = ownerList.get(0).getPassword();
                String appr = ownerList.get(0).getApproved();
                String role = ownerList.get(0).getUser_role();

                DESKeySpec keySpec = new DESKeySpec("Your secret Key phrase".getBytes("UTF8"));
                SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
                SecretKey key = keyFactory.generateSecret(keySpec);
                sun.misc.BASE64Encoder base64encoder = new BASE64Encoder();
                sun.misc.BASE64Decoder base64decoder = new BASE64Decoder();

                byte[] encrypedPwdBytes = base64decoder.decodeBuffer(pword2);

                Cipher cipher = Cipher.getInstance("DES");
                cipher.init(Cipher.DECRYPT_MODE, key);
                byte[] plainTextPwdBytes = (cipher.doFinal(encrypedPwdBytes));
                String pword=new String(plainTextPwdBytes);


                if (pword.equals(password) && appr.equals("yes")) {

                    session1 = request.getSession();
                    session1.setAttribute("username", username);
                    if (role.equals("Normal User")) {
                        page = "user/get_item_details.jsp";
                    } else if (role.equals("Manager")) {
                        page = "manager/approve_damaged_items.jsp";

                    } else if (role.equals("Supervisor")) {
                        page = "Supervisor/add_inventory_item.jsp";
                    } else if (role.equals("Administrator")) {
                        page = "admin/approve_reg.jsp";
                    }
                } else if (!pword.equals(password)) {
                    warn = "Incorrect Password";
                } else if (!appr.equals("yes")) {
                    warn = "You are not still an authorized user";
                }
            } else if (ownerList.size() == 0) {
                warn = "Username does not exist";
            }

        } catch (Exception e) {
        } finally {
            session.flush();
            session.close();
        }

        out.println(warn + ":" + page);

    }
}

