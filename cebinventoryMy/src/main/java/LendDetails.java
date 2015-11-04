/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author dell
 */
public class LendDetails extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        List<transaction_header> lendList = null;
        List<String> docList = null;
        List<transaction_detail> codeList = null;
        Session session = null;
        String ret = "";
        String warn = "";
        HttpSession session1 = null;

        session1 = request.getSession();
        String user1= session1.getAttribute("username").toString();

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            Query q = session.createQuery("from transaction_header tr where tr.transaction_type='lend' and tr.status='Posted' and tr.user_name='"+user1+"'");
            lendList = (List<transaction_header>) q.list();

            if (lendList.size() != 0) {
                for (int i = 0; i < lendList.size(); i++) {

                    ret = ret + lendList.get(i).getDoc_number() + ":";
                    System.out.println(lendList.get(i).getDoc_number() + ":");
                }
            } else if (lendList.size() == 0) {
                warn = "You haven't lended any item";
            }
        } finally {
            session.flush();
            session.close();
        }
        out.println(warn + ":" + ret);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
