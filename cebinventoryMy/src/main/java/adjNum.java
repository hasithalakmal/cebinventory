/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class adjNum extends HttpServlet {
   
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

             response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        Calendar toDay = Calendar.getInstance();
        int year = toDay.get(Calendar.YEAR);

        Session session = null;
        Transaction tx = null;
try{
SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
session =sessionFactory.openSession();
tx = session.beginTransaction();
for(int i=0;;i++){
    String adj=year+"/adj/"+i;
    List empList = session.createQuery("from adjustments  where adjustment_no='"+adj+"'").list();

    if(empList.isEmpty()|empList.equals(null)){

            pw.println(adj);
            break;
   }
    else
    continue;

}
tx.commit();
}catch(Exception e){
    tx.rollback();
    pw.println(e);
}finally{

}
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   

}
