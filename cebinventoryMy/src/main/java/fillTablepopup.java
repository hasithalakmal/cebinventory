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
public class fillTablepopup extends HttpServlet {


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
        String cat=request.getParameter("cat");
        String item=request.getParameter("item");
        Session session = null;
        Transaction tx = null;
try{ // This step will read hibernate.cfg.xml
SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
session =sessionFactory.openSession();
tx = session.beginTransaction();
Query q=(Query)session.createQuery("Select Distinct category_code from stock_category_item where category='"+cat+"'");

            List<String> ls=q.list();
            String s1=ls.get(0);



        q=(Query)session.createQuery("Select Distinct item_code from stock_category_item where item='"+item+"'");
        ls=q.list();
        String s2=ls.get(0);
        String itcode="s/"+s1+"/"+s2;
        

List empList = session.createQuery("from item_master where item_code like '%"+itcode+"%'").list();


for(int i=0; i<empList.size();i++){
item_master oim= (item_master)empList.get(i);
pw.println(oim.getItem_code()+":"+oim.getItem_name()+":"+oim.getPrice()+"%");
}
tx.commit();
}catch(Exception e){
    tx.rollback();
    pw.println(e);
}finally{
//session.close();
}

    }


}
