
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
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
public class ChangeStatus extends HttpServlet {

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

        Transaction transaction = null;
        String test = "";
        HttpSession session1 = null;
        List<owner_item_master> detailList = null;
        String actqty=null;
        String acqty;

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

        Session session = null;
        String unwanted = null;
        String lost = null;
        String auctioning = null;

        String code = request.getParameter("txtname");
        String status1 = request.getParameter("select1");
        String status2 = request.getParameter("select");

        String lost1 = request.getParameter("checkbox1");
        System.out.println(lost1);
        if (lost1.equals("true")) {
            lost = "Lost";
        } else if (lost1.equals("false")) {
            lost = "Available";
        }
        String unwanted1 = request.getParameter("checkbox2");
        if (unwanted1.equals("true")) {
            unwanted = "Unwanted";
        } else if (unwanted1.equals("false")) {
            unwanted = "Wanted";
        }
        String auctioning1 = request.getParameter("checkbox3");
        if (auctioning1.equals("true")) {
            auctioning = "Auctioning";
        } else if (auctioning1.equals("false")) {
            auctioning = "Non-Auctioning";
        }
        String description = request.getParameter("ta_damageDescription");
        String cause = request.getParameter("textfield2");
        String qty = request.getParameter("textfield4");
        String newstatus1 = status2 + lost + unwanted + auctioning;

        try {
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session = sessionFactory.openSession();

            transaction = session.beginTransaction();

            status_change_requests change = new status_change_requests();
            change.setUser_name(user1);
            change.setItem_code(code);


            Query q = session.createQuery("from owner_item_master ow where ow.item_code='" + code +"'");
            detailList = (List<owner_item_master>) q.list();
            actqty=detailList.get(0).getQuantity();
if(lost.equals("Lost")){
            acqty=Integer.toString(Integer.parseInt(actqty)-Integer.parseInt(qty));
            }

else
    acqty=actqty;

            String status = StatusConverter.convertStringToDigits(status1);
            String newstatus = StatusConverter.convertStringToDigits(newstatus1);

            change.setRequested_status(newstatus);
            change.setCurrent_status(status);
            change.setDescription(description);
            change.setCause(cause);
            change.setQuantity(qty);
            change.setDate(date);
            change.setApproved("Pending");
            change.setAvailable_quantity(acqty);

            session.save(change);
            test = "Successfully reported";
            transaction.commit();


        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            test = "Your request for changing status for this item has not been sent.";
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
