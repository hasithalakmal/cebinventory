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
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Isuru
 */
public class submitIssue extends HttpServlet {
   
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
        String req=request.getParameter("issue");
        String itemcode=request.getParameter("itemcode");
        //String itemname=request.getParameter("itemname");
        //String price=request.getParameter("price");
        //String value=request.getParameter("value");
        String remarks=request.getParameter("remarks");
        String issueto=request.getParameter("issueto");
        String status=request.getParameter("status");
        status=StatusConverter.convertStringToDigits(status);
        String unit=request.getParameter("unit");
        String qty=request.getParameter("qty");
        String date=request.getParameter("date");
        String manual=request.getParameter("manual");
        Session session = null;
        Transaction tx = null;

        try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();


        HttpSession ses =request.getSession();
        String owner=(String) ses.getAttribute("username");




        String item="0";
        String sec="0";
        String cost="0";
        List empList = session.createQuery("from owner where user_name='"+issueto+"'").list();

        List oims=session.createQuery("from owner_item_master where user_name='"+issueto+"' and status='"+status+"' and item_code='"+itemcode+"'").list();

        if(oims.isEmpty()|oims.equals(null)){
               
            if(empList.isEmpty() | empList.equals(null)){
            sec="0";
            cost="0";
        }

        else{

        owner cati= (owner)empList.get(0);
        sec=cati.getSection_id();
        cost=cati.getCost_id();
        }
        List empList1=session.createQuery("from owner_item_master where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'").list();

        owner_item_master oim=(owner_item_master)empList1.get(0);
        String quan=oim.getQuantity();
        if(Integer.parseInt(qty)<Integer.parseInt(quan)){

            int newqty=Integer.parseInt(quan)-Integer.parseInt(qty);
            String newqtys=Integer.toString(newqty);
            String hql = "update owner_item_master set quantity='"+newqtys+"' where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();



            owner_item_master oim1=new owner_item_master();
            oim1.setUser_name(issueto);
            oim1.setItem_code(itemcode);
            oim1.setCost_id(cost);
            oim1.setSection_id(sec);
            oim1.setQuantity(qty);
            oim1.setUnit_of_measure(unit);
            oim1.setStatus(status);
            oim1.setFreeze("0");
            oim1.setLended("0");
            oim1.setConflict_flag("0");
            session.save(oim1);
            session.flush();

        }

        else if(Integer.parseInt(qty)==Integer.parseInt(quan)){

       String hql = "update owner_item_master  set user_name='"+issueto+"', cost_id='"+cost+"', section_id='"+sec+"' where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'";
       Query q = session.createQuery(hql);
       q.executeUpdate();
     }
        else{
            out.println("ERROR:Quantity Not sufficient to fulfill the tequest");
            return;
        }
}
        else{

            if(itemcode.charAt(0)=='i'){

                out.println("Error:Inventory item dublicate");
                return;

            }


        List empList4=session.createQuery("from owner_item_master where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'").list();
        owner_item_master oim2=(owner_item_master)empList4.get(0);
        String quan2=oim2.getQuantity();

            int newqty1=Integer.parseInt(quan2)-Integer.parseInt(qty);
            if(newqty1<0){
                out.println("ERROR:Quantity Not Sufficent to fulfill the request");
                return;
            }
            else if(newqty1>=0){
            List empList3=session.createQuery("from owner_item_master where item_code='"+itemcode+"' and user_name='"+issueto+"' and status='"+status+"'").list();
            owner_item_master oim1=(owner_item_master)empList3.get(0);
            String quan1=oim1.getQuantity();


            String newqtys1=Integer.toString(newqty1);

            String hql= "update owner_item_master set quantity='"+newqtys1+"' where item_code='"+itemcode+"' and user_name='"+owner+"' and status='"+status+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();


            int newqty=Integer.parseInt(quan1)+Integer.parseInt(qty);
            String newqtys=Integer.toString(newqty);
            hql = "update owner_item_master set quantity='"+newqtys+"' where item_code='"+itemcode+"' and user_name='"+issueto+"' and status='"+status+"'";
            q = session.createQuery(hql);
            q.executeUpdate();
        }
        }

        transaction_header th=new transaction_header();

       th.setDoc_number(req);
       th.setDoc_date(date);
       th.setTransaction_type("issue");
       th.setUser_name(owner);
       th.setStatus("0");
       th.setRemarks(remarks);
       th.setIssue_to(issueto);
       session.save(th);
       session.flush();


       transaction_detail td=new transaction_detail();


       td.setDoc_number(req);
       td.setItem_code(itemcode);
       td.setQuantity(qty);
       td.setUnit_of_measure(unit);
       td.setStatus(status);
       td.setWbno(manual);
       session.save(td);
       session.flush();



        if(com.equals("Composite Item")){

        List list = session.createQuery("from item_master where composite_code='"+itemcode+"'").list();


        if(list.isEmpty() | list.equals(null)){

        }
        else{
        for(int i=0;i<list.size();i++){


        item_master itm= (item_master)list.get(i);
        transaction_detail td1=new transaction_detail();        
        item=itm.getItem_code().toString();
        



        List empList1=session.createQuery("from owner_item_master where item_code='"+item+"'").list();

        owner_item_master oim2=(owner_item_master)empList1.get(0);
        String quan=oim2.getQuantity();
        status=oim2.getStatus();
        
       String hql = "update owner_item_master  set user_name='"+issueto+"', cost_id='"+cost+"', section_id='"+sec+"' where item_code='"+item+"'";
       Query q = session.createQuery(hql);
       q.executeUpdate();



        td1.setDoc_number(req);
        td1.setItem_code(item);
        td1.setQuantity(quan);
        td1.setUnit_of_measure(unit);
        td1.setStatus(status);
        td1.setWbno(manual);
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
