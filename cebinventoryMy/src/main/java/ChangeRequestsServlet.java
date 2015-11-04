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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Query;
import org.hibernate.Transaction;

/**
 *
 * @author Ranil
 */
public class ChangeRequestsServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session =sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        List requestList = null;
        try{
          if(request.getParameter("parameter").equals("load")){
            requestList = session.createQuery("from status_change_requests where approved='Pending' order by user_name, date, item_code").list();
            if(!requestList.isEmpty()){
                for(int i=0; i<requestList.size(); i++){
                    status_change_requests scr = (status_change_requests)requestList.get(i);
                    List ownerList = session.createQuery("from owner where user_name='"+scr.getUser_name()+"'").list();
                    List itemList = session.createQuery("from item_master where item_code='"+scr.getItem_code()+"'").list();
                    String item_code = scr.getItem_code();
                    String item_name = ((item_master)itemList.get(0)).getItem_name();
                    String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                    String current_status = StatusConverter.convertDigitsToString(scr.getCurrent_status());
                    String requested_status = StatusConverter.convertDigitsToString(scr.getRequested_status());
                    String description = scr.getDescription();
                    String cause = scr.getCause();
                    String quantity =  scr.getQuantity();
                    String available_quantity =  scr.getAvailable_quantity();
                    String date = scr.getDate();
                    pw.print(owner+";"+date+";"+item_code+";"+item_name+";"+current_status+";"+requested_status+";"+quantity+";"+available_quantity+";"+description+";"+cause+";"+scr.getUser_name()+"%");
                }
             }
             else{
                pw.print("zzzz");
             }
          }
          else if(request.getParameter("parameter").equals("update")){
            Query q = null;
            String itemCode = request.getParameter("itemCode");
            String userName = request.getParameter("userName");
            String date = request.getParameter("date");
            String currentStatus = StatusConverter.convertStringToDigits(request.getParameter("currentStatus"));
            String requestedStatus = StatusConverter.convertStringToDigits(request.getParameter("requestedStatus"));
            String quantity = request.getParameter("quantity");
            String availableQantity = request.getParameter("availableQantity");
            if(request.getParameter("type").equals("Y")){
                List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                if(!ownerItemList.isEmpty()){
                    int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                    if(currentStatus.equals(requestedStatus)){
                        if(Integer.parseInt(availableQantity) >= 0){
                            String hql = "update owner_item_master  set quantity='"+availableQantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            String hql1 = "update status_change_requests  set approved='Yes' where  item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.println("Successfully Updated!");
                        }
                        else{
                            String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.print("Conflicting request!");
                        }
                    }
                    else {
                        if(actualQuantity >= Integer.parseInt(availableQantity)){
                            List ownerItemListTemp = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+requestedStatus+"'").list();
                            if(!ownerItemListTemp.isEmpty()){
                                int newQty = Integer.parseInt(((owner_item_master)ownerItemListTemp.get(0)).getQuantity())+Integer.parseInt(availableQantity);
                                String hql2 = "update owner_item_master  set quantity='"+newQty+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+requestedStatus+"'";
                                q = (Query) session.createQuery(hql2);
                                q.executeUpdate();
                                String newQuantity = String.valueOf(actualQuantity-Integer.parseInt(availableQantity));
                                String hql = "update owner_item_master  set quantity='"+newQuantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                q = (Query) session.createQuery(hql);
                                q.executeUpdate();
                                String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                q = (Query) session.createQuery(hql1);
                                q.executeUpdate();
                                pw.println("Successfully Updated!");
                            }
                            else {
                                if (itemCode.charAt(0)=='s'){
                                    List ownerItemListTemp1 = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                                    owner_item_master oim = (owner_item_master)ownerItemListTemp1.get(0);
                                    owner_item_master om = new owner_item_master();
                                    om.setConflict_flag(oim.getConflict_flag());
                                    om.setCost_id(oim.getCost_id());
                                    om.setFreeze(oim.getFreeze());
                                    om.setItem_code(oim.getItem_code());
                                    om.setQuantity(availableQantity);
                                    om.setSection_id(oim.getSection_id());
                                    om.setStatus(requestedStatus);
                                    om.setUnit_of_measure(oim.getUnit_of_measure());
                                    om.setUser_name(oim.getUser_name());
                                    om.setLended(oim.getLended());
                                    session.save(om);
                                    String newQuantity = String.valueOf(actualQuantity-Integer.parseInt(availableQantity));
                                    String hql2 = "update owner_item_master  set quantity='"+newQuantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql2);
                                    q.executeUpdate();
                                    String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println("Successfully Updated!");
                                } else if(itemCode.charAt(0)=='i'){
                                    String hql = "update owner_item_master  set status='"+requestedStatus+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println("Successfully Updated!");
                                }
                            }
                        }
                        else{
                            String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.print("Conflicting request!");
                        }
                    }
                }
                else{
                    String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                    q = (Query) session.createQuery(hql);
                    q.executeUpdate();
                    pw.print("Conflicting request!");
                }
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update status_change_requests  set approved='No' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.print("Successfully Updated!");
            }
          }
          else if(request.getParameter("parameter").equals("updateAll")){
            Query q = null;
            if(request.getParameter("type").equals("Y")){
                boolean flag = false;
                requestList = session.createQuery("from status_change_requests where approved='Pending'").list();
                for(int i=0; i<requestList.size(); i++){
                    String itemCode = ((status_change_requests)requestList.get(i)).getItem_code();
                    String userName = ((status_change_requests)requestList.get(i)).getUser_name();
                    String date = ((status_change_requests)requestList.get(i)).getDate();
                    String currentStatus = ((status_change_requests)requestList.get(i)).getCurrent_status();
                    String requestedStatus = ((status_change_requests)requestList.get(i)).getRequested_status();
                    String quantity = ((status_change_requests)requestList.get(i)).getQuantity();
                    String availableQantity = ((status_change_requests)requestList.get(i)).getAvailable_quantity();
                    if(request.getParameter("type").equals("Y")){
                        List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                        if(!ownerItemList.isEmpty()){
                            int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                            if(currentStatus.equals(requestedStatus)){
                                if(Integer.parseInt(availableQantity) >= 0){
                                    String hql = "update owner_item_master  set quantity='"+availableQantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update status_change_requests  set approved='Yes' where  item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                }
                                else{
                                    if(!flag){
                                        pw.println("The following changes could not be made due to conflicts :-");
                                        flag = true;
                                    }
                                    String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println(" User ID : "+userName+"  Item Code : "+itemCode+" Current Status : "+StatusConverter.convertDigitsToString(currentStatus)+" Actual Quantity : "+quantity+" Available Quantity : "+availableQantity);
                                }
                            }
                            else {
                                if(actualQuantity >= Integer.parseInt(availableQantity)){
                                    List ownerItemListTemp = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+requestedStatus+"'").list();
                                    if(!ownerItemListTemp.isEmpty()){
                                        int newQty = Integer.parseInt(((owner_item_master)ownerItemListTemp.get(0)).getQuantity())+Integer.parseInt(availableQantity);
                                        String hql2 = "update owner_item_master  set quantity='"+newQty+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+requestedStatus+"'";
                                        q = (Query) session.createQuery(hql2);
                                        q.executeUpdate();
                                        String newQuantity = String.valueOf(actualQuantity-Integer.parseInt(availableQantity));
                                        String hql = "update owner_item_master  set quantity='"+newQuantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                        q = (Query) session.createQuery(hql);
                                        q.executeUpdate();
                                        String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                        q = (Query) session.createQuery(hql1);
                                        q.executeUpdate();
                                    }
                                    else {
                                        if (itemCode.charAt(0)=='s'){
                                            List ownerItemListTemp1 = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                                            owner_item_master oim = (owner_item_master)ownerItemListTemp1.get(0);
                                            owner_item_master om = new owner_item_master();
                                            om.setConflict_flag(oim.getConflict_flag());
                                            om.setCost_id(oim.getCost_id());
                                            om.setFreeze(oim.getFreeze());
                                            om.setItem_code(oim.getItem_code());
                                            om.setQuantity(availableQantity);
                                            om.setSection_id(oim.getSection_id());
                                            om.setStatus(requestedStatus);
                                            om.setUnit_of_measure(oim.getUnit_of_measure());
                                            om.setUser_name(oim.getUser_name());
                                            om.setLended(oim.getLended());
                                            session.save(om);
                                            String newQuantity = String.valueOf(actualQuantity-Integer.parseInt(availableQantity));
                                            String hql2 = "update owner_item_master  set quantity='"+newQuantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                            q = (Query) session.createQuery(hql2);
                                            q.executeUpdate();
                                            String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                            q = (Query) session.createQuery(hql1);
                                            q.executeUpdate();
                                        } else if(itemCode.charAt(0)=='i'){
                                            String hql = "update owner_item_master  set status='"+requestedStatus+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                            q = (Query) session.createQuery(hql);
                                            q.executeUpdate();
                                            String hql1 = "update status_change_requests  set approved='Yes' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                            q = (Query) session.createQuery(hql1);
                                            q.executeUpdate();
                                        }
                                    }
                                }
                                else{
                                    if(!flag){
                                        pw.println("The following changes could not be made due to conflicts :-");
                                        flag = true;
                                    }
                                    String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println(" User ID : "+userName+"  Item Code : "+itemCode+" Current Status : "+StatusConverter.convertDigitsToString(currentStatus)+" Requested Status : "+StatusConverter.convertDigitsToString(requestedStatus)+" Actual Quantity : "+quantity+" Available Quantity : "+availableQantity);
                                }
                            }
                        }
                        else{
                            String hql = "update status_change_requests  set approved='Conflict' where item_code='"+itemCode+"' and user_name='"+userName+"' and  date='"+date+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            pw.println("Item Code : "+itemCode+" and Status : "+currentStatus+" does not exist!");
                        }
                    }
                }
                pw.println("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update status_change_requests  set approved='No' where approved='Pending'";
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
            session.flush();
            session.close();
        }
    }

}
