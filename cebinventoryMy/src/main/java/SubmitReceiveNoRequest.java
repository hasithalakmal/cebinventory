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
public class SubmitReceiveNoRequest extends HttpServlet {
   
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


        //String itemname=request.getParameter("itemname");
        //String price=request.getParameter("price");
        //String value=request.getParameter("value");
        String remarks=request.getParameter("remarks");
        String owner=request.getParameter("owner");
        String wbnum=request.getParameter("wbnum");
        String receipt=request.getParameter("receipt");
        String date=request.getParameter("date");
        String count=request.getParameter("count");
        

        int c=Integer.parseInt(count);
        String qtyarray[]=new String[100];
        String statusarray[]=new String[100];
        String unitarray[]=new String[100];
        String comarray[]=new String[100];
        String itemcodearray[]=new String[100];

        int i=0;

   
       while(i<=c){


            String itemcode="itemcode"+i;
            String itemstatus="itemstatus"+i;
            String unit="unit"+i;
            String com="com"+i;
            String qty="qty"+i;

             if(itemcode.equals(null) | itemcode.equals(""))
             break;
             else{
             qtyarray[i]=request.getParameter(qty);
             statusarray[i]=StatusConverter.convertStringToDigits(request.getParameter(itemstatus));
             unitarray[i]=request.getParameter(unit);
             comarray[i]=request.getParameter(com);
             itemcodearray[i]=request.getParameter(itemcode);
             i++;
             }
        }

        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();
        String item="0";
        String sec="0";
        String cost="0";

       transaction_header th=new transaction_header();
       th.setDoc_number(receipt);
       th.setDoc_date(date);
       th.setTransaction_type("receive");
       th.setUser_name(owner);
       th.setStatus("0");
       th.setRemarks(remarks);
       session.save(th);
       session.flush();

        for(int y=0;y<i;y++){

           List oims=session.createQuery("from owner_item_master where user_name='"+owner+"' and status='"+statusarray[y]+"' and item_code='"+itemcodearray[y]+"'").list();

        if(oims.isEmpty()|oims.equals(null)){
        owner_item_master owneritm= new owner_item_master();

        owneritm.setUser_name(owner);
        owneritm.setItem_code(itemcodearray[y]);

        List empList = session.createQuery("from owner where user_name='"+owner+"'").list();

        
        if(empList.isEmpty() | empList.equals(null)){
            sec="0";
            cost="0";
        }

        else{

        owner cati= (owner)empList.get(0);
        sec=cati.getSection_id();
        cost=cati.getCost_id();
        }

        owneritm.setCost_id(cost);
        owneritm.setSection_id(sec);
        owneritm.setQuantity(qtyarray[y]);
        owneritm.setUnit_of_measure(unitarray[y]);
        owneritm.setStatus(statusarray[y]);
        owneritm.setFreeze("0");
        owneritm.setConflict_flag("0");
        owneritm.setLended("0");
        session.save(owneritm);
        session.flush();
        }
        else{

               if(itemcodearray[y].charAt(0)=='i'){

                        out.println("Error:Inventory Item Dublicate");
                        return;
               }

        List empList1=session.createQuery("from owner_item_master where item_code='"+itemcodearray[y]+"' and user_name='"+owner+"' and status='"+statusarray[y]+"'").list();
        owner_item_master oim=(owner_item_master)empList1.get(0);
        String quan=oim.getQuantity();

            int newqty=Integer.parseInt(quan)+Integer.parseInt(qtyarray[y]);
            String newqtys=Integer.toString(newqty);
            String hql = "update owner_item_master set quantity='"+newqtys+"' where item_code='"+itemcodearray[y]+"' and user_name='"+owner+"' and status='"+statusarray[y]+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();

        }


        transaction_detail td=new transaction_detail();


       td.setDoc_number(receipt);
       td.setItem_code(itemcodearray[y]);
       td.setQuantity(qtyarray[y]);
       td.setUnit_of_measure(unitarray[y]);
       td.setWbno(wbnum);
       td.setStatus(statusarray[y]);
       session.save(td);
       session.flush();



        if(comarray[y].equals("Composite Item")){

        List list = session.createQuery("from item_master where composite_code='"+itemcodearray[y]+"'").list();


        if(list.isEmpty() | list.equals(null)){



        }
        else{
        for(int b=0;b<list.size();b++){
        item_master itm= (item_master)list.get(b);
        owner_item_master owneritm1= new owner_item_master();
        transaction_detail td1=new transaction_detail();


        item=itm.getItem_code().toString();
        String status=itm.getStatus();
       

        
        owneritm1.setUser_name(owner);
        owneritm1.setItem_code(item);


        owneritm1.setCost_id(cost);
        owneritm1.setSection_id(sec);
        owneritm1.setQuantity(qtyarray[y]);
        owneritm1.setUnit_of_measure(unitarray[y]);
        owneritm1.setStatus(status);
        owneritm1.setFreeze("0");
        owneritm1.setLended("0");
        owneritm1.setConflict_flag("0");
        session.save(owneritm1);
        session.flush();
 
        td1.setDoc_number(receipt);
        td1.setItem_code(item);
        td1.setQuantity(qtyarray[y]);
        td1.setUnit_of_measure(unitarray[y]);
        td1.setWbno(wbnum);
        td1.setStatus(date);
        td1.setStatus(status);
        session.save(td1);
        session.flush();

        }

        }

        }
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

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   
}
