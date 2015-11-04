
import java.io.IOException;
import java.io.PrintWriter;
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
public class submitAdjustment extends HttpServlet {
   
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

        String adjustno=request.getParameter("adjustno");
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

            adjustments ad=new adjustments();

            String itemcode="itemcode"+i;
            String status="status"+i;
            String remarks="remarks"+i;
            String acqty="acqty"+i;
            String avqty="avqty"+i;


             ad.setAdjustment_no(adjustno);
             ad.setUser_name(owner);


             String mystatus=StatusConverter.convertStringToDigits(request.getParameter(status));
             ad.setStatus(mystatus);

             ad.setRemarks(request.getParameter(remarks));
             ad.setItem_code(request.getParameter(itemcode));
             ad.setActual_quantity(request.getParameter(acqty));
             ad.setAvailable_quantity(request.getParameter(avqty));
             ad.setApproved("Pending");
             i++;

             session.save(ad);
             session.flush();

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
