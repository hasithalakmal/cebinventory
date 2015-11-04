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
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author dell
 */
public class ItemDetails extends HttpServlet {

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

        List<owner_item_master> itemList = null;
        List<item_master> itemList1 = null;
        List<transaction_detail> codeList = null;
        List<transaction_header> docList = null;
        Session session = null;
        List<transaction_header> docList1 = null;
        List<transaction_detail> codeList1 = null;
        List<owner_item_master> detailList = null;
        List<item_master> nameList1 = null;
        HttpSession session1 = null;

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

           session1 = request.getSession();
           String user1= session1.getAttribute("username").toString();

            Query q = session.createQuery("from owner_item_master o where o.user_name='"+user1+"'");
            itemList = (List<owner_item_master>) q.list();

            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table border='1' width='700'>");
            out.println("<tr><td width='100'>Item</td><td width='75'>Quantity</td><td width='125'>Unit of Measure</td><td width='150'>Status</td><td width='50'>Availability</td><td width='125'>Lended or Borrowed</td></tr>");

            for (int i = 0; i < itemList.size(); i++) {

                String item_code = (itemList.get(i)).getItem_code();
                String quantity = (itemList.get(i)).getQuantity();
                String uom = (itemList.get(i)).getUnit_of_measure();
                String len = (itemList.get(i)).getLended();
                String lended = null;
                if (len.equals("1")) {
                    Query q1 = session.createQuery("from transaction_detail tr where tr.item_code='" + item_code + "' and status='Posted'");
                    codeList = (List<transaction_detail>) q1.list();

                    String doc = codeList.get(0).getDoc_number();

                    Query q2 = session.createQuery("from transaction_header tr where tr.doc_number='" + doc + "'");
                    docList = (List<transaction_header>) q2.list();

                    String issue = docList.get(0).getIssue_to();

                    lended = "Lended to " + issue;
                } else if (len.equals("0")) {
                    lended = "-";
                }

                String status1 = (itemList.get(i)).getStatus();
                String status = StatusConverter.convertDigitsToString(status1);
                String[] arr=status.split("->");
                String available =arr[1];
                Query q1 = session.createQuery("from item_master i where i.item_code='" + item_code + "'");
                itemList1 = (List<item_master>) q1.list();

                String name = itemList1.get(0).getItem_name();

                out.println("<tr>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + quantity + "</td>");
                out.println("<td>" + uom + "</td>");
                out.println("<td>" + status + "</td>");
                out.println("<td>" + available + "</td>");
                out.println("<td>" + lended + "</td>");
                out.println("</tr>");
            }

            Query q1 = session.createQuery("from transaction_header tr where tr.issue_to='bhagya' and status='Posted'");
            docList1 = (List<transaction_header>) q1.list();

            if (docList1.size() != 0) {
                for (int i = 0; i < docList1.size(); i++) {
                    String doc = docList1.get(i).getDoc_number();

                    Query q2 = session.createQuery("from transaction_detail tr where tr.doc_number='" + doc + "' and status='Posted'");
                    codeList1 = (List<transaction_detail>) q2.list();

                    for (int j = 0; j < codeList1.size(); j++) {

                        Query q3 = session.createQuery("from owner_item_master o where o.item_code='" + codeList1.get(j).getItem_code() + "'");
                        detailList = (List<owner_item_master>) q3.list();

                        Query q4 = session.createQuery("from item_master i where i.item_code='" + codeList1.get(j).getItem_code() + "'");
                        nameList1 = (List<item_master>) q4.list();

                        String name = nameList1.get(0).getItem_name();
                        String user = detailList.get(0).getUser_name();
                        String uom = detailList.get(0).getUnit_of_measure();
                        String status1 = detailList.get(0).getStatus();
                        String status = StatusConverter.convertDigitsToString(status1);
                        String qty = codeList1.get(0).getQuantity();
                        String borrow = "Borrowed from " + user;
                        String lost = (detailList.get(i)).getLost_found();
                        String available = null;

                        if (lost.equals("1")) {
                            available = "Lost";
                        } else if (lost.equals("0")) {
                            available = "Available";
                        }
                        out.println("<tr>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + qty + "</td>");
                        out.println("<td>" + uom + "</td>");
                        out.println("<td>" + status + "</td>");
                        out.println("<td>" + available + "</td>");
                        out.println("<td>" + borrow + "</td>");
                        out.println("</tr>");
                    }
                }
            }
            out.println("</table");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
        } finally {
            session.flush();
            session.close();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
