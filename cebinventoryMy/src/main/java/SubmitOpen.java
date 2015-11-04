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
public class SubmitOpen extends HttpServlet {
   
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



        String docnum=request.getParameter("docnum");
        String owner=request.getParameter("owner");
        String date=request.getParameter("date");
        String count=request.getParameter("count");


        int c=Integer.parseInt(count);

        String itemcodearray[]=new String[100];
        String itemnamearray[]=new String[100];
        String qtyarray[]=new String[100];
        String statusarray[]=new String[100];
        String pdatearray[]=new String[100];
        String companyarray[]=new String[100];
        String refarray[]=new String[100];


        int i=0;


       while(i<=c){


            String itemcode="itemcode"+i;
            String itemname="itemname"+i;
            String status="status"+i;
            String qty="qty"+i;
            String pdate="pdate"+i;
            String company="company"+i;
            String ref="ref"+i;


             if(itemcode.equals(null) | itemcode.equals(""))
             break;
             else{
             qtyarray[i]=request.getParameter(qty);
             statusarray[i]=StatusConverter.convertStringToDigits(request.getParameter(status));
             pdatearray[i]=request.getParameter(pdate);
             companyarray[i]=request.getParameter(company);
             itemcodearray[i]=request.getParameter(itemcode);
             itemnamearray[i]=request.getParameter(itemname);
             refarray[i]=request.getParameter(ref);
             i++;
             }
        }


        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();

         for(int a=0;a<i;a++){

         openning_stock os=new openning_stock();
         os.setDoc_number(docnum);
         os.setOwner(owner);
         os.setDoc_date(date);
         os.setItem_code(itemcodearray[a]);
         os.setItem_name(itemnamearray[a]);
         os.setQuantity(qtyarray[a]);
         os.setStatus(statusarray[a]);
         os.setCompany(companyarray[a]);
         os.setReceive_date(pdatearray[a]);
         os.setReference(refarray[a]);
         os.setConfirmed("0");
         session.save(os);
         session.flush();

    }

        out.println("submit data successfully");
       tx.commit();
}catch(Exception e){
    tx.rollback();
     System.out.println(e.getMessage());
    out.println(e);
}finally{

}




   }
    

}
