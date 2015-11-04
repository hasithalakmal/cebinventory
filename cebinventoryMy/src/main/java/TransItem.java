/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Vector;
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
import org.hibernate.mapping.Array;

/**
 *
 * @author dell
 */
public class TransItem extends HttpServlet {

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
        String doc = request.getParameter("textfield4");
        String check = request.getParameter("cb");
        String code = request.getParameter("textfield");
        String label = request.getParameter("lb");
        String status = request.getParameter("status");
        String borrower = request.getParameter("textfield2");

        int size = check.split(":").length;
        String[] checkb = new String[size];
        checkb = check.split(":");

        int size1 = label.split(":").length + 5;
        String[] lab = new String[size1];
        lab = label.split(":");

        try {
            SessionFactory sessionFactory1 = new Configuration().configure().buildSessionFactory();
            session = sessionFactory1.openSession();

            transaction = session.beginTransaction();

            for (int i = 0; i < size; i++) {
                if (checkb[i].equals("true")) {
                    String a = lab[(i * 3)];
                    String b = lab[(i * 3) + 1];
                    String c = lab[(i * 3) + 2];

                    transaction_detail tr = new transaction_detail();

                    Query q2 = session.createQuery("update owner_item_master set lended='1' where  item_code='" + a + "'");
                    q2.executeUpdate();

                    tr.setDoc_number(doc);
                    tr.setItem_code(a);
                    tr.setUnit_of_measure("num");
                    tr.setQuantity("1");
                    tr.setStatus("Posted");

                    session.save(tr);
                }
            }

            Query q2 = session.createQuery("update owner_item_master set lended='1' where  item_code='" + code + "'");
            q2.executeUpdate();

            transaction_header tr1 = new transaction_header();
            transaction_detail tr2 = new transaction_detail();

            tr1.setDoc_number(doc);
            tr1.setIssue_to(borrower);
            tr1.setStatus("Posted");
            tr1.setDoc_date(date);
            tr1.setTransaction_type("lend");
            tr1.setUser_name(user1);
            session.save(tr1);

            tr2.setDoc_number(doc);
            tr2.setItem_code(code);
            tr2.setStatus("Posted");
            tr2.setQuantity("1");
            tr2.setUnit_of_measure("num");
            session.save(tr2);

            transaction.commit();
            out.println("Transfer Successful");

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            transaction.rollback();
        } finally {
            session.flush();
            session.close();
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
