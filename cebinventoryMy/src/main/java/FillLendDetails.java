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
public class FillLendDetails extends HttpServlet {

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
        List<transaction_detail> codeList = null;
        List<transaction_header> issueList = null;
        List<owner_item_master> statusList = null;
        List<item_master> nameList = null;
        String ret = "";

        String doc = request.getParameter("select");

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            Query q = session.createQuery("from transaction_detail tr where tr.doc_number='" + doc + "' and tr.status='Posted'");
            codeList = (List<transaction_detail>) q.list();

            if (codeList.size() == 1) {
                String code = codeList.get(0).getItem_code();

                Query q1 = session.createQuery("from transaction_header tr where tr.doc_number='" + doc + "'");
                issueList = (List<transaction_header>) q1.list();
                String issue = issueList.get(0).getIssue_to();

                Query q2 = session.createQuery("from owner_item_master ow where ow.item_code='" + code + "'");
                statusList = (List<owner_item_master>) q2.list();
                String status1 = statusList.get(0).getStatus();
                String status = StatusConverter.convertDigitsToString(status1);

                Query q3 = session.createQuery("from item_master im where im.item_code='" + code + "'");
                nameList = (List<item_master>) q3.list();

                String composite = nameList.get(0).getComposite();
                String name = nameList.get(0).getItem_name();

                ret = code + ":" + status + ":" + issue + ":" + composite + ":" + name;
            } else {
                Query q1 = session.createQuery("from transaction_header tr where tr.doc_number='" + doc + "'");

                issueList = (List<transaction_header>) q1.list();
                String issue = issueList.get(0).getIssue_to();

                for (int i = 0; i < codeList.size(); i++) {
                    String code = codeList.get(i).getItem_code();

                    Query q2 = session.createQuery("from owner_item_master ow where ow.item_code='" + code + "'");
                    statusList = (List<owner_item_master>) q2.list();
                    String status1 = statusList.get(0).getStatus();
                    String status = StatusConverter.convertDigitsToString(status1);

                    Query q3 = session.createQuery("from item_master im where im.item_code='" + code + "'");
                    nameList = (List<item_master>) q3.list();

                    String composite = nameList.get(0).getComposite();
                    String name = nameList.get(0).getItem_name();

                    ret = ret + code + ":" + status + ":" + issue + ":" + composite + ":" + name + ":";
                }
            }
        } finally {
            session.flush();
            session.close();
        }
        out.println(ret);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

   
}
