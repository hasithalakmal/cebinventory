/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
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
public class TransferItem extends HttpServlet {

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


        List<owner_item_master> itemList = null;
        List<owner_item_master> statusList = null;
        List<item_master> subItemList = null;
        List<item_master> nameList = null;
        ArrayList<String> subCode = new ArrayList<String>();
        String status = "";
        String status1 = null;
        String warn = "warn";
        String name = "aa";
        Session session = null;
        HttpSession session1 = null;

        session1 = request.getSession();
        String user1= session1.getAttribute("username").toString();

        try {


            if (request.getParameter("textfield").length() != 0) {
                String code = request.getParameter("textfield");

                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                session = sessionFactory.openSession();

                Query q = session.createQuery("from owner_item_master o where o.item_code='" + code + "' and o.user_name='"+user1+"' and o.lended='0'");
                itemList = (List<owner_item_master>) q.list();

                Query q1 = session.createQuery("from item_master i where i.composite_code='" + code + "'");
                subItemList = (List<item_master>) q1.list();

                Query q2 = session.createQuery("from item_master i where i.item_code='" + code + "'");
                nameList = (List<item_master>) q2.list();

                if (itemList.size() != 0) {
                    status1 = itemList.get(0).getStatus();
                    name = nameList.get(0).getItem_name();
                    status =StatusConverter.convertDigitsToString(status1);
                } else if (itemList.size() == 0) {
                    warn = "You have no permission to transfer this item.Please enter a valid item code.";
                }
            }

            out.println(warn + ":" + status + ":" + name);

            if (itemList.size() != 0) {
                for (int i = 0; i < subItemList.size(); i++) {
                    Query q1 = session.createQuery("from owner_item_master o where o.item_code='" + subItemList.get(i).getItem_code() + "'");
                    statusList = (List<owner_item_master>) q1.list();
                    String status2 = statusList.get(0).getStatus();
                    String status3 =StatusConverter.convertDigitsToString(status2);

                    out.println(":" + subItemList.get(i).getItem_code() + ":" + subItemList.get(i).getItem_name() + ":" + status3);
                }
            }

        } catch (Exception e) {
        } finally {
            session.flush();
            session.close();
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
   