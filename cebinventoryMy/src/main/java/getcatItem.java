/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.List;
import org.hibernate.Query;
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
public class getcatItem extends HttpServlet {
   
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

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out=response.getWriter();
        String cate= request.getParameter("cat");
        String itm= request.getParameter("item");
        Session session = null;
        Transaction tx = null;
    try{
       SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
       session =sessionFactory.openSession();
       tx = session.beginTransaction();
      Query q=(Query)session.createQuery("Select Distinct category_code from category_item_master where category='"+cate+"'");

            List<Integer> ls=q.list();
            String s1=ls.get(0).toString();

      
        q=(Query)session.createQuery("Select Distinct item_code from category_item_master where item='"+itm+"'");
        ls=q.list();
        String s2=ls.get(0).toString();

        q=(Query)session.createQuery("Select last from category_item_last where item='"+itm+"'"+" "+"and category='"+cate+"'");
        
        List<String> ls1=q.list();
        if(ls1.isEmpty()){
               out.println("i/"+s1+"/"+s2+"/"+"0");
        }
        else{
            String s=ls1.get(0).trim();
            int a=Integer.parseInt(s);
        out.println(("i/"+s1+"/"+s2+"/"+(a+1)).trim());
        }
        tx.commit();
    }
    catch (Exception e){
        tx.rollback();
        out.println(e);
    }
    }

   

}
