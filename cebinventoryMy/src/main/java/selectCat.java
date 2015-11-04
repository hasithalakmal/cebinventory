/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
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
public class selectCat extends HttpServlet {
   
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
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
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
            Query q=session.createQuery("SELECT DISTINCT category FROM category_item_master");
            List<String> ls=q.list();
            for(int i=0; i<ls.size();i++){
            pw.println(ls.get(i)+":");
   }
            tx.commit();
   }
    catch (Exception e){
        tx.rollback();
        pw.println(e);
    }
    }
}