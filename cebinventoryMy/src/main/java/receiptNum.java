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
public class receiptNum extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
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
    String receipt=year+"/rec/"+costid+"/"+i;
    List empList = session.createQuery("from transaction_header  where doc_number='"+receipt+"'").list();
    
    if(empList.isEmpty()|empList.equals(null)){

            out.println(receipt+":"+username);
            break;
   }
    else
    continue;
    
}
tx.commit();
}catch(Exception e){
    tx.rollback();
    out.println(e);
}finally{

}
}

}

   
   


