/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
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
public class submitFreeze extends HttpServlet {
   
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

        String owner=request.getParameter("owner");
        String row=request.getParameter("row");


        int rowno=Integer.parseInt(row);


        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();



        int i=0;
        if(rowno==0)
            out.println("Data insertion unsucessfull");
        else{
        while(i<rowno){

            String itemcode="itemcode"+i;
            String status="status"+i;
            String mystatus=StatusConverter.convertStringToDigits(request.getParameter(status));
            String myitemcode=request.getParameter(itemcode);
            String hql = "update owner_item_master set freeze='1' where item_code='"+myitemcode+"' and user_name='"+owner+"' and status='"+mystatus+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();
            i++;
        }

       out.println("Data Inserted Successfully");
       tx.commit();
        }
}catch(Exception e){
    tx.rollback();
     System.out.println(e.getMessage());
    out.println(e);
}finally{

}
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    }
