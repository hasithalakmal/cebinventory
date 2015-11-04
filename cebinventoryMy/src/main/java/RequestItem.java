/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Bhagya
 */
public class RequestItem extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Session session = null;
        String test = null;
        Transaction transaction = null;
        HttpSession session1 = null;

        session1 = request.getSession();
        String user1= session1.getAttribute("username").toString();

        Calendar toDay = Calendar.getInstance();
        int date1 = toDay.get(Calendar.DATE);
        int month = toDay.get(Calendar.MONTH);
        int year = toDay.get(Calendar.YEAR);
        String date2 = Integer.toString(date1);
        String month1 = Integer.toString(month);
        String year1 = Integer.toString(year);

        String date = date2 + "/" + month1 + "/" + year1;
        String reqNum = request.getParameter("textfield3");
        String item = request.getParameter("textarea2");
        String qty = request.getParameter("textfield2");
        String remarks = request.getParameter("textarea");

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            transaction = session.beginTransaction();

            request_item req = new request_item();
            req.setUser_name(user1);
            req.setDate(date);
            req.setItem_description(item);
            req.setQuantity(qty);
            req.setRemarks(remarks);
            req.setRequest_id(reqNum);
            req.setApproved("0");

            session.save(req);
            transaction.commit();
            test = "Successfully sent your request";

        } catch (Exception ex) {
            test = "Your request has not been sent";
            transaction.rollback();
        } finally {
            session.flush();
            session.close();
        }
        out.println(test);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
