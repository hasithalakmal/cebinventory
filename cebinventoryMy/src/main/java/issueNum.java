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
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class issueNum extends HttpServlet {
   
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
    HttpSession ses =request.getSession();
    String username=(String) ses.getAttribute("username");
    List ow= session.createQuery("from owner  where user_name='"+username+"'").list();
    owner ims=(owner)ow.get(0);
    String costid=ims.getCost_id();

for(int i=0;;i++){
    String receipt=year+"/iss/"+costid+"/"+i;
    List empList = session.createQuery("from transaction_header  where doc_number='"+receipt+"'").list();

    if(empList.isEmpty()|empList.equals(null)){

            pw.println(receipt);
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
