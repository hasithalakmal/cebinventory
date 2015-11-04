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
public class submitReceive extends HttpServlet {
   
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
        
        String com=request.getParameter("com");
        String receipt=request.getParameter("receipt");
        String req=request.getParameter("request");
        String itemcode=request.getParameter("itemcode");
        //String itemname=request.getParameter("itemname");
        //String price=request.getParameter("price");
        //String value=request.getParameter("value");
        String remarks=request.getParameter("remarks");
        String owner=request.getParameter("owner");
        String status=request.getParameter("status");
        status=StatusConverter.convertStringToDigits(status);
        String unit=request.getParameter("unit");
        String wbnum=request.getParameter("wbnum");
        String qty=request.getParameter("qty");
        String date=request.getParameter("date");
       

        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();

        String item="0";
        String sec="0";
        String cost="0";

        

        List oims=session.createQuery("from owner_item_master where user_name='"+owner+"' and status='"+status+"' and item_code='"+itemcode+"'").list();

        if(oims.isEmpty()|oims.equals(null)){

        owner_item_master owneritm= new owner_item_master();

        owneritm.setUser_name(owner);
        owneritm.setItem_code(itemcode);

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
        owneritm.setQuantity(qty);
        owneritm.setUnit_of_measure(unit);
        owneritm.setStatus(status);
        owneritm.setFreeze("0");
        owneritm.setLended("0");
        owneritm.setConflict_flag("0");
        session.save(owneritm);
        session.flush();
        }
        else{

            if(itemcode.charAt(0)=='i'){

                out.println("Error:Inventory item dublicate");
                return;

            }

        List empList1=session.createQuery("from owner_item_master where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'").list();
        owner_item_master oim=(owner_item_master)empList1.get(0);
        String quan=oim.getQuantity();

            int newqty=Integer.parseInt(quan)+Integer.parseInt(qty);
            String newqtys=Integer.toString(newqty);
            String hql = "update owner_item_master set quantity='"+newqtys+"' where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();
        }

        transaction_header th=new transaction_header();

       th.setDoc_number(receipt);
       th.setDoc_date(date);
       th.setTransaction_type("receive");
       th.setUser_name(owner);
       th.setStatus("0");
       th.setRequest_no(req);
       th.setRemarks(remarks);
       session.save(th);
       session.flush();


       transaction_detail td=new transaction_detail();


       td.setDoc_number(receipt);
       td.setItem_code(itemcode);
       td.setQuantity(qty);
       td.setUnit_of_measure(unit);
       td.setWbno(wbnum);
       td.setStatus(status);
       session.save(td);
       session.flush();

       

        if(com.equals("Composite Item")){

        List list = session.createQuery("from item_master where composite_code='"+itemcode+"'").list();


        if(list.isEmpty() | list.equals(null)){

            

        }
        else{
        for(int i=0;i<list.size();i++){
        item_master itm= (item_master)list.get(i);
        owner_item_master owneritm1= new owner_item_master();
        transaction_detail td1=new transaction_detail();
        String comstatus="0";

        

        item=itm.getItem_code().toString();
        comstatus=itm.getStatus().toString();
        

        owneritm1.setUser_name(owner);
        owneritm1.setItem_code(item);


        owneritm1.setCost_id(cost);
        owneritm1.setSection_id(sec);
        owneritm1.setQuantity(qty);
        owneritm1.setUnit_of_measure(unit);
        owneritm1.setStatus(comstatus);
        owneritm1.setFreeze("0");
        owneritm1.setLended("0");
        owneritm1.setConflict_flag("0");
        session.save(owneritm1);
        session.flush();
       
        td1.setDoc_number(receipt);
        td1.setItem_code(item);
        td1.setQuantity(qty);
        td1.setUnit_of_measure(unit);
        td1.setWbno(wbnum);
        td1.setStatus(comstatus);
        session.save(td1);
        session.flush();



        }

        }
        }

       out.println("submit data successfully");
       tx.commit();
}catch(Exception e){
    tx.rollback();
    out.println(e);
}finally{

}
    }

}