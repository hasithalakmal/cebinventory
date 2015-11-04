import java.io.IOException;
import java.io.PrintWriter;
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
public class getReceipt extends HttpServlet {
   
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
         Session session = null;
         Transaction tx = null;

    try{
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session =sessionFactory.openSession();
            tx = session.beginTransaction();
            HttpSession ses =request.getSession();
            String user=(String) ses.getAttribute("username");

        List empList = session.createQuery("from owner_item_master where user_name='"+user+"'").list();



    for(int i=0; i<empList.size();i++){
    owner_item_master itm= (owner_item_master)empList.get(i);
    String code=itm.getItem_code();
    List empList1 = session.createQuery("from transaction_detail where item_code='"+code+"'").list();
    transaction_detail td=(transaction_detail)empList1.get(0);
    out.println(td.getDoc_number()+":"+code+"%");
    }
        tx.commit();
    }
    catch (Exception e){
        tx.rollback();
        out.println(e);
    }

    }
  

}
