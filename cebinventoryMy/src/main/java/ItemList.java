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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Ranil
 */
public class ItemList extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        Session session = null;
        List itemList = null;
        try{
          if(request.getParameter("parameter").equals("load")){
            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session =sessionFactory.openSession();
            itemList = session.createQuery("from item_master order by item_code").list();
            for(int i=0; i<itemList.size(); i++){
                item_master itm = (item_master)itemList.get(i);
                String item_code = itm.getItem_code() ;
                String item_name = itm.getItem_name();
                String composite = itm.getComposite();
                String composite_code  = itm.getComposite_code();
                String status  = itm.getStatus();
                String is_inventory  = itm.getIs_inventory();
                String is_capital  = itm.getIs_capital();
                String price  = itm.getPrice();
                String value  = itm.getValue();
                String depreciation_rate  = itm.getDepreciation_rate();
                String serial_number  = itm.getSerial_number();
                String critical  = itm.getCritical();
                String unit_of_measure  = itm.getUnit_of_measure();
                pw.print(item_code+";"+item_name+";"+price+";"+value+";"+serial_number+";"+status+";"+depreciation_rate+";"+unit_of_measure+";"+composite+";"+composite_code+";"+is_inventory+";"+is_capital+";"+critical+"%");
            }
          }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }finally{
            session.flush();
            session.close();
        }
    }

}
