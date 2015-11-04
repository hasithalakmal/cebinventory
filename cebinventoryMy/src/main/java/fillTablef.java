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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class fillTablef extends HttpServlet {
   
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
        PrintWriter pw= response.getWriter();
        String owner=request.getParameter("owner");
        Session session = null;
        Transaction tx = null;
try{ // This step will read hibernate.cfg.xml
SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
session =sessionFactory.openSession();
tx = session.beginTransaction();
List empList = session.createQuery("from owner_item_master where user_name='"+owner+"' and freeze='0'").list();
//List empList = session.createQuery("from catitm").list();
//empList contains the list of Employee

for(int i=0; i<empList.size();i++){
owner_item_master oim= (owner_item_master)empList.get(i);
String itemcode=oim.getItem_code();
List empList1 = session.createQuery("from item_master  where item_code='"+itemcode+"'").list();
item_master im=(item_master)empList1.get(0);
pw.println(oim.getItem_code()+":"+StatusConverter.convertDigitsToString(oim.getStatus())+":"+im.getItem_name()+":"+oim.getQuantity()+":"+im.getRemarks()+":"+im.getPrice()+":"+im.getValue()+"%");
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
