/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class submitinventory extends HttpServlet {
   
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


        String category=request.getParameter("cat");
        String type=request.getParameter("type");
        String itemcode=request.getParameter("itemcode").trim();
        String namedescription=request.getParameter("namedescription");
        String price=request.getParameter("price");
        String value=request.getParameter("value");
        String snum=request.getParameter("snum");
        String remarks=request.getParameter("remarks");
        String composite=request.getParameter("composite");
        String compositecode=request.getParameter("compositecode");
        String depreciate=request.getParameter("depreciate");
        String critical=request.getParameter("critical");
        String capital=request.getParameter("capital");
        String image=request.getParameter("image");
        String warranty=request.getParameter("warranty");
        String sdate=request.getParameter("sdate");
        String edate=request.getParameter("edate");
        String leadt=request.getParameter("leadt");
        String location=request.getParameter("location");
        String vendor=request.getParameter("vendor");
        Session session = null;
        Transaction tx = null;
try{

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        session =sessionFactory.openSession();
        tx = session.beginTransaction();


        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date warranty1 = dateFormat.parse(warranty);
        Date edate1=dateFormat.parse(edate);


        File file = new File("C:/image/"+image);
        byte[] bFile = new byte[(int) file.length()];
        try {
	     FileInputStream fileInputStream = new FileInputStream(file);
	     //convert file into array of bytes
	     fileInputStream.read(bFile);
	     fileInputStream.close();
        } catch (Exception e) {
	     e.printStackTrace();
        }





item_master itm1 = new item_master();
itm1.setImage(bFile);
itm1.setItem_code(itemcode);
itm1.setItem_name(namedescription);
if(composite.equals("Composite Item".trim())){
    itm1.setComposite("Composite Item");

}
else if(composite.equals("Non Composite Item".trim())){
    itm1.setComposite("Non Composite Item");
}
    else
        itm1.setComposite("Part of Composite Item");

itm1.setComposite_code(compositecode);
itm1.setStatus("0000");
itm1.setUnit_of_measure("Num");
itm1.setIs_inventory("1");
if(capital.equals("true")){
itm1.setIs_capital("1");
}
else
    itm1.setIs_capital("0");

itm1.setPrice(price);
itm1.setSerial_number(snum);
itm1.setValue(value);
itm1.setDepreciation_rate(depreciate);
itm1.setRemarks(remarks);
if(critical.equals("true"))
        itm1.setCritical("1");
else
        itm1.setCritical("0");
//out.println("isuru");
itm1.setWarranty_expiry_date(warranty1);
itm1.setService_start_date(sdate);
itm1.setService_end_date(edate1);
itm1.setLead_time(leadt);
itm1.setVendor(vendor);
itm1.setLocation(location);
session.save(itm1);
session.flush();

String[] result = itemcode.split("/");
String str=result[3];
str=str.trim();

     int a=Integer.parseInt(str);
     //out.println(a+"");
     str=Integer.toString(a);

     
 Query q=(Query)session.createQuery("from category_item_last where item='"+type+"'"+" "+"and category='"+category+"'");

        List<String> ls1=q.list();
        if(ls1.isEmpty() | ls1==null){
               category_item_last itmc=new category_item_last();
               itmc.setCategory(category);
               itmc.setItem(type);
               itmc.setLast(str);
               session.save(itmc);
               session.flush();
        }
        else{
            session.flush();
String hql = "update category_item_last  set last="+str+" where category='"+category+"'"+" "+"and item='"+type+"'";
q = session.createQuery(hql);
q.executeUpdate();
}
out.println("Data Inserted Successfully");
tx.commit();
}catch(Exception e){
    tx.rollback();
    out.println(e);
}finally{

}

       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   
}
