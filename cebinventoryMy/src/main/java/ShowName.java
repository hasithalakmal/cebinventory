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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author dell
 */
public class ShowName extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Session session = null;
        List<owner> nameList = null;
        String warn = "warn";
        String name = "name";

        String borrower = request.getParameter("textfield2");

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            Query q = session.createQuery("from owner o where o.user_name='" + borrower + "'");
            nameList = (List<owner>) q.list();

            if (nameList.size() == 0) {
                warn = "You have entered an invalid borrower name. Please enter a valid name";
            } else {
                String fname = nameList.get(0).getOwner_first_name();
                String lname = nameList.get(0).getOwner_last_name();

                name = fname + " " + lname;
            }
            out.println(warn + ":" + name);

        } catch (Exception e) {
        } finally {
            session.flush();
            session.close();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
