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
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.classic.Session;

/**
 *
 * @author Isuru
 */
public class getStockItem extends HttpServlet {
   
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
        String name= request.getParameter("cat");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pw= response.getWriter();
        Session session = null;
        Transaction tx = null;
try{ // This step will read hibernate.cfg.xml
SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
session =sessionFactory.openSession();
tx = session.beginTransaction();
List empList = session.createQuery("from stock_category_item  where category='"+name+"'").list();
for(int i=0; i<empList.size();i++){
stock_category_item cati= (stock_category_item)empList.get(i);
pw.println(cati.getItem()+":");
}
tx.commit();
}catch(Exception e){
    tx.rollback();
    pw.println(e);
}finally{
//session.close();
}
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    
}
