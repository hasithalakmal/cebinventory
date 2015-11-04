/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author dell
 */
public class ReturnItem extends HttpServlet {

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

        try {
            SessionFactory sessionFactory1 = new Configuration().configure().buildSessionFactory();
            session = sessionFactory1.openSession();

            transaction = session.beginTransaction();

            String doc = request.getParameter("select");
            String check = request.getParameter("cb");
            String code = request.getParameter("textfield");
            String label = request.getParameter("lb");
            String textfield3 = request.getParameter("textfield3");
            String borrower = request.getParameter("textfield2");

            int size = check.split(":").length;
            String[] checkb = new String[size];
            checkb = check.split(":");

            int size1 = label.split(":").length + 5;
            String[] lab = new String[size1];
            lab = label.split(":");
            String ch = "";
            for (int j = 0; j < size; j++) {
                ch = ch + "true:";
            }

            if (check.equals(ch) || size == 1) {

                Query q = session.createQuery("update transaction_header set status='Returned' where doc_number='" + doc + "'");
                q.executeUpdate();

                Query q2 = session.createQuery("update transaction_detail set status='Returned' where doc_number='" + doc + "'");
                q2.executeUpdate();

                for (int i = 0; i < lab.length / 3; i++) {
                    Query q3 = session.createQuery("update owner_item_master set lended='0' where item_code='" + lab[i * 3] + "'");
                    q3.executeUpdate();
                }
                Query q4 = session.createQuery("update owner_item_master set lended='0' where item_code='" + code + "'");
                q4.executeUpdate();

               

                transaction.commit();

                out.println("Successfully returned the items");
            } else {
                for (int i = 0; i < checkb.length; i++) {
                    if (checkb[i].equals("true")) {

                        Query q1 = session.createQuery("update transaction_detail set status='Returned' where doc_number='" + doc + "' and item_code='" + lab[i * 3] + "'");
                        q1.executeUpdate();

                        Query q3 = session.createQuery("update owner_item_master set lended='0' where item_code='" + lab[i * 3] + "'");
                        q3.executeUpdate();
                    }
                }
                /*Query q2 = session.createQuery("update transaction_detail set status='Returned' where  item_code='" + code + "'");
                q2.executeUpdate();

                Query q4 = session.createQuery("update owner_item_master set lended='0' where item_code='" + code + "'");
                q4.executeUpdate();*/

                transaction.commit();

                out.println("Successfully returned the items");
            }
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
