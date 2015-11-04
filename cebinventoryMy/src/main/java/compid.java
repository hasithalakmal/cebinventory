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
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class compid extends HttpServlet {
   
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
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws
                              ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
   Session session = null;
   Transaction tx = null;

    try{
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session =sessionFactory.openSession();
            tx = session.beginTransaction();
        List empList = session.createQuery("from item_master where composite='Composite Item'").list();
//List empList = session.createQuery("from catitm").list();
//empList contains the list of Employee

for(int i=0; i<empList.size();i++){
item_master itm= (item_master)empList.get(i);
pw.println(itm.getItem_code()+":"+itm.getItem_name()+":"+itm.getSerial_number()+"%");
}
 tx.commit();
}
    catch (Exception e){
      tx.rollback();
      pw.println(e);
    }
    }

   
    

}
