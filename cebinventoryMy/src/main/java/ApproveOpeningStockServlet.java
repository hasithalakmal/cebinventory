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
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Ranil
 */

public class ApproveOpeningStockServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = session =sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        List stockList = null;
        try{
          if(request.getParameter("parameter").equals("search")){
            String docNo = request.getParameter("docNo");
            stockList = session.createQuery("from openning_stock where doc_number='"+docNo+"' and confirmed='0' order by owner, item_code").list();
            if(!stockList.isEmpty()){
                for(int i=0; i<stockList.size(); i++){
                    openning_stock opstk = (openning_stock)stockList.get(i);
                    List ownerList = session.createQuery("from owner where user_name='"+opstk.getOwner()+"'").list();
                    String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                    String doc_date = opstk.getDoc_date();
                    String item_code = opstk.getItem_code();
                    String item_name = opstk.getItem_name();
                    String status = StatusConverter.convertDigitsToString(opstk.getStatus());
                    String quantity = opstk.getQuantity();
                    String company = opstk.getCompany();
                    String receive_date= opstk.getReceive_date();
                    String reference = opstk.getReference();
                    pw.print(owner+";"+item_code+";"+item_name+";"+status+";"+quantity+";"+company+";"+receive_date+";"+reference+";"+doc_date+";"+opstk.getOwner()+";"+docNo+"%");
                }
            }
            else{
                pw.print("zzzz");
            }
          }
          else if(request.getParameter("parameter").equals("view")){
                List documentList = session.createQuery("select distinct doc_number from openning_stock where confirmed='0' order by doc_number").list();
                if(!documentList.isEmpty()){
                    for(int i=0; i<documentList.size(); i++){
                        String docNo = (String) documentList.get(i);
                        pw.println("Document No : "+docNo);
                    }
                }
                else {
                    pw.println("All opening stock have been approved.");
                }
          }
          else if(request.getParameter("parameter").equals("update")){
            Query q = null;
            String itemCode = request.getParameter("itemCode");
            String userName = request.getParameter("userName");
            String docNo = request.getParameter("docNo");
            if(request.getParameter("type").equals("Y")){
                String hql = "update openning_stock  set confirmed='1' where doc_number='"+docNo+"' and item_code='"+itemCode+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                stockList = session.createQuery("from openning_stock where doc_number='"+docNo+"' and item_code='"+itemCode+"'").list();
                openning_stock opstk = (openning_stock)stockList.get(0);
                List ownerList = session.createQuery("from owner where user_name='"+userName+"'").list();
                owner ow = (owner)ownerList.get(0);
                List itemList = session.createQuery("from item_master where item_code='"+itemCode+"'").list();
                item_master itm = (item_master)itemList.get(0);
                owner_item_master om = new owner_item_master();
                om.setConflict_flag("0");
                om.setCost_id(ow.getCost_id());
                om.setFreeze("0");
                om.setItem_code(opstk.getItem_code());
                om.setQuantity(opstk.getQuantity());
                om.setSection_id(ow.getSection_id());
                om.setStatus(opstk.getStatus());
                om.setUnit_of_measure(itm.getUnit_of_measure());
                om.setUser_name(opstk.getOwner());
                om.setLended("0");
                session.save(om);
                pw.print("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update openning_stock  set confirmed='2' where doc_number='"+docNo+"' and item_code='"+itemCode+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.print("Successfully Updated!");
            }
          }
          else if(request.getParameter("parameter").equals("updateAll")){
            Query q = null;
            String docNo = request.getParameter("docNo");
            if(request.getParameter("type").equals("Y")){
                stockList = session.createQuery("from openning_stock where doc_number='"+docNo+"' and confirmed='0'").list();
                for(int i=0; i<stockList.size(); i++){
                    pw.print("asd"+stockList.size());
                    openning_stock opstk = (openning_stock)stockList.get(i);
                    List ownerList = session.createQuery("from owner where user_name='"+opstk.getOwner()+"'").list();
                    owner ow = (owner)ownerList.get(0);
                    List itemList = session.createQuery("from item_master where item_code='"+opstk.getItem_code()+"'").list();
                    item_master itm = (item_master)itemList.get(0);
                    owner_item_master om = new owner_item_master();
                    om.setConflict_flag("0");
                    om.setCost_id(ow.getCost_id());
                    om.setFreeze("0");
                    om.setItem_code(opstk.getItem_code());
                    om.setQuantity(opstk.getQuantity());
                    om.setSection_id(ow.getSection_id());
                    om.setStatus(opstk.getStatus());
                    om.setUnit_of_measure(itm.getUnit_of_measure());
                    om.setUser_name(opstk.getOwner());
                    om.setLended("0");
                    session.save(om);
                }
                String hql = "update openning_stock  set confirmed='1' where doc_number='"+docNo+"' and confirmed='0'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.println("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update openning_stock  set confirmed='2' where doc_number='"+docNo+"' and confirmed='0'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.print("Successfully Updated!");
            }
          }
          tx.commit();
        }catch(HibernateException he){
            tx.rollback();
            System.out.println(he.getMessage());
        }catch(Exception e){
            System.out.println(e.getMessage());
        }finally{
            pw.flush();
            session.flush();
            session.close();
        }
    }

}
