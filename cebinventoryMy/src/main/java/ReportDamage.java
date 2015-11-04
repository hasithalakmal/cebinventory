/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author dell
 */
public class ReportDamage extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     */
    //public class SendRedirect extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        List<owner_item_master> itemList = null;
        String status = "";
        String warn = "warn";
        String status2 = null;
        Session session = null;
        HttpSession session1 = null;

        session1 = request.getSession();
        String user1= session1.getAttribute("username").toString();

        String code = request.getParameter("txtname");
        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            Query q = session.createQuery("from owner_item_master o where o.item_code='" + code + "' and user_name='"+user1+"'");
            itemList = (List<owner_item_master>) q.list();
            if (itemList.size() == 0) {
                warn = "You are not authorized to report a damage for this item. Please enter a valid item code";
            }

            for (int i = 0; i < itemList.size(); i++) {
                status2 = StatusConverter.convertDigitsToString(itemList.get(i).getStatus()) + ":";
                status = status + status2;
            }
        } catch (Exception e) {
        } finally {
            session.flush();
            session.close();
        }
        out.println(warn + ":" + status);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

   
}
