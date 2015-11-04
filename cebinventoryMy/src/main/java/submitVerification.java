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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class submitVerification extends HttpServlet {
   
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

        String vno=request.getParameter("vno");
        String owner=request.getParameter("owner");
        String date=request.getParameter("date");
        String row=request.getParameter("row");
        String subrow=request.getParameter("subrow");

        int rowno=Integer.parseInt(row);
        int subrowno=Integer.parseInt(subrow);

        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();
       
        int i=0;
        while(i<rowno){

            verification vrf=new verification();
            String itemcode="itemcode"+i;
            String status="status"+i;
            String remarks="remarks"+i;
            String rqty="rqty"+i;
            String cqty="cqty"+i;
            String newstatus="newstatus"+i;
            



             vrf.setVerification_no(vno);
             vrf.setUser_name(owner);
             vrf.setDate(date);

             String mystatus=StatusConverter.convertStringToDigits(request.getParameter(status));
             vrf.setStatus(mystatus);
             String mynewstatus="0000";
             if(request.getParameter(newstatus).equals("No Change"))
              mynewstatus=mystatus;
            else if(request.getParameter(newstatus).equals("Defective"))
              mynewstatus="2"+mystatus.substring(1);
            else if(request.getParameter(newstatus).equals("Damaged"))
              mynewstatus="1"+mystatus.substring(1);
            else if(request.getParameter(newstatus).equals("Obsolete"))
              mynewstatus="3"+mystatus.substring(1);

             vrf.setRequested_status(mynewstatus);
             vrf.setRemarks(request.getParameter(remarks));
             vrf.setItem_code(request.getParameter(itemcode));
             vrf.setActual_quantity(request.getParameter(rqty));
             vrf.setAvailable_quantity(request.getParameter(cqty));
             vrf.setApproved("Pending");
             i++;
             session.save(vrf);
             session.flush();
             
        }

        int y=0;

        while(y<subrowno){


            verification vrf=new verification();
            String itcode="itcode"+y;
            String itstatus="itstatus"+y;
            String itremarks="itremarks"+y;
            String itrqty="itrqty"+y;
            String itcqty="itcqty"+y;
            String itnewstatus="itnewstatus"+y;

             vrf.setVerification_no(vno);
             vrf.setUser_name(owner);
             vrf.setDate(date);

             String mystatus=StatusConverter.convertStringToDigits(request.getParameter(itstatus));
             vrf.setStatus(mystatus);



             String mynewstatus="0000";
             if(itnewstatus.equals("No Change"))
            itnewstatus=mystatus;
            else if(request.getParameter(itnewstatus).equals("Defective"))
              mynewstatus="2"+mystatus.substring(1);
            else if(request.getParameter(itnewstatus).equals("Damaged"))
              mynewstatus="1"+mystatus.substring(1);
            else if(request.getParameter(itnewstatus).equals("Obsolete"))
              mynewstatus="3"+mystatus.substring(1);

             vrf.setRequested_status(mynewstatus);
             vrf.setRemarks(request.getParameter(itremarks));
             vrf.setItem_code(request.getParameter(itcode));
             vrf.setActual_quantity(request.getParameter(itrqty));
             vrf.setAvailable_quantity(request.getParameter(itcqty));
              vrf.setApproved("Pending");
             session.save(vrf);
             session.flush();
             y++;

        }
        out.println("Data Inserted Successfully");
       tx.commit();
}catch(Exception e){
    tx.rollback();
     System.out.println(e.getMessage());
    out.println(e);
}finally{

}

       
    }

  

}
