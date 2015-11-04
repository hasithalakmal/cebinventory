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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class fillDat extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

            response.setContentType("text/html;charset=UTF-8");
       PrintWriter out = response.getWriter();
       String itmc=request.getParameter("itemcode").trim();
       
       Session session = null;
       Transaction tx = null;
    try{
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session =sessionFactory.openSession();
            tx = session.beginTransaction();


            HttpSession ses =request.getSession();
            String own=(String) ses.getAttribute("username");


           List items= session.createQuery("from owner_item_master  where item_code='"+itmc+"' and user_name='"+own+"'").list();
           owner_item_master it= (owner_item_master)items.get(0);
           List itm=session.createQuery("from item_master  where item_code='"+itmc+"'").list();
           item_master ims=(item_master)itm.get(0);
           
           out.println(StatusConverter.convertDigitsToString(it.getStatus())+":"+ims.getItem_name()+":"+it.getUnit_of_measure()+":"+ims.getPrice()+":"+ims.getValue()+":"+ims.getComposite());
           tx.commit();
        }
    catch (Exception e){
        tx.rollback();
      out.println(e);
    }


    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   
}
