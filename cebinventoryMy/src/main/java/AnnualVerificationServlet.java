

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
public class AnnualVerificationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session =sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        List verificationList = null;
        try{
          if(request.getParameter("parameter").equals("search")){
            String verificationNo = request.getParameter("verificationNo");
            verificationList = session.createQuery("from verification where verification_no='"+verificationNo+"' and approved='Pending' order by item_code, status").list();
            if(!verificationList.isEmpty()){
                verification v = (verification)verificationList.get(0);
                List ownerList = session.createQuery("from owner where user_name='"+v.getUser_name()+"'").list();
                String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                for(int i=0; i<verificationList.size(); i++){
                    verification ver = (verification)verificationList.get(i);
                    List itemList = session.createQuery("from item_master where item_code='"+ver.getItem_code()+"'").list();
                    String item_code = ver.getItem_code();
                    String item_name = ((item_master)itemList.get(0)).getItem_name();
                    String current_status = StatusConverter.convertDigitsToString(ver.getStatus());
                    String requested_status = StatusConverter.convertDigitsToString(ver.getRequested_status());
                    String actual_quantity = ver.getActual_quantity();
                    String available_quantity = ver.getAvailable_quantity();
                    String date = ver.getDate();
                    String remarks = ver.getRemarks();
                    pw.print(item_code+";"+item_name+";"+current_status+";"+requested_status+";"+actual_quantity+";"+available_quantity+";"+remarks+";"+owner+";"+v.getUser_name()+";"+verificationNo+";"+date+"%");
                }
            }
            else{
                pw.print("zzzz");
            }
          }
          else if(request.getParameter("parameter").equals("view")){
                verificationList = session.createQuery("select distinct verification_no from verification where approved='Pending' order by verification_no").list();
                if(!verificationList.isEmpty()){
                    for(int i=0; i<verificationList.size(); i++){
                        String verNo = (String) verificationList.get(i);
                        List verificationList1 = session.createQuery("select user_name from verification where verification_no='"+verNo+"'").list();
                        String userName = (String) verificationList1.get(0);
                        List ownerList = session.createQuery("from owner where user_name='"+userName+"'").list();
                        String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                        pw.println("Verification No : "+verNo+"     Owner : "+owner+" ");
                    }
                }
                else {
                    pw.println("All annual verifications have been approved.");
                }
          }
          else if(request.getParameter("parameter").equals("update")){
            Query q = null;
            String verificationNo = request.getParameter("verificationNo");
            String itemCode = request.getParameter("itemCode");
            String userName = request.getParameter("userName");
            String currentStatus = StatusConverter.convertStringToDigits(request.getParameter("currentStatus"));
            String requestedStatus = StatusConverter.convertStringToDigits(request.getParameter("requestedStatus"));
            String quantity = request.getParameter("quantity");
            String availableQantity = request.getParameter("availableQuantity");
            if(request.getParameter("type").equals("Y")){
                List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                if(!ownerItemList.isEmpty()){
                    int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                    if(currentStatus.equals(requestedStatus)){
                        if(Integer.parseInt(availableQantity) >= 0){
                            String hql = "update owner_item_master  set quantity='"+availableQantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            String hql1 = "update verification  set approved='Yes' where  verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.println("Successfully Updated!");
                        }
                        else{
                            String hql = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
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
                                String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
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
                                    String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println("Successfully Updated!");
                                } else if(itemCode.charAt(0)=='i'){
                                    String hql = "update owner_item_master  set status='"+requestedStatus+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println("Successfully Updated!");
                                }
                            }
                        }
                        else{
                            String hql = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.print("Conflicting request!");
                        }
                    }
                }
                else {
                    String hql1 = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                    q = (Query) session.createQuery(hql1);
                    q.executeUpdate();
                    pw.print("Conflicting request! Item does not exist.");
                }
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update verification  set approved='No' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.print("Successfully Updated!");
            }
          }
          else if(request.getParameter("parameter").equals("updateAll")){
            Query q = null;
            String verificationNo = request.getParameter("verificationNo");
            if(request.getParameter("type").equals("Y")){
                boolean flag = false;
                verificationList = session.createQuery("from verification where verification_no='"+verificationNo+"' and approved='Pending'").list();
                for(int i=0; i<verificationList.size(); i++){
                    String itemCode = ((verification)verificationList.get(i)).getItem_code();
                    String userName = ((verification)verificationList.get(i)).getUser_name();
                    String currentStatus = ((verification)verificationList.get(i)).getStatus();
                    String requestedStatus = ((verification)verificationList.get(i)).getRequested_status();
                    String quantity = ((verification)verificationList.get(i)).getActual_quantity();
                    String availableQantity = ((verification)verificationList.get(i)).getAvailable_quantity();
                    if(request.getParameter("type").equals("Y")){
                        List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'").list();
                        if(!ownerItemList.isEmpty()){
                            int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                            if(currentStatus.equals(requestedStatus)){
                                if(Integer.parseInt(availableQantity)>=0){
                                    String hql = "update owner_item_master  set quantity='"+availableQantity+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                }
                                else{
                                    if(!flag){
                                        pw.println("The following changes could not be made due to conflicts :-");
                                        flag = true;
                                    }
                                    String hql = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
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
                                        String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
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
                                            String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                                            q = (Query) session.createQuery(hql1);
                                            q.executeUpdate();
                                        } else if(itemCode.charAt(0)=='i'){
                                            String hql = "update owner_item_master  set status='"+requestedStatus+"', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                            q = (Query) session.createQuery(hql);
                                            q.executeUpdate();
                                            String hql1 = "update verification  set approved='Yes' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
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
                                    String hql = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                                    q = (Query) session.createQuery(hql);
                                    q.executeUpdate();
                                    String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+currentStatus+"'";
                                    q = (Query) session.createQuery(hql1);
                                    q.executeUpdate();
                                    pw.println(" User ID : "+userName+"  Item Code : "+itemCode+" Current Status : "+StatusConverter.convertDigitsToString(currentStatus)+" Requested Status : "+StatusConverter.convertDigitsToString(requestedStatus)+" Actual Quantity : "+quantity+" Available Quantity : "+availableQantity);
                                }
                            }
                        }
                        else {
                            String hql1 = "update verification  set approved='Conflict' where verification_no='"+verificationNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and  status='"+currentStatus+"' and requested_status='"+requestedStatus+"'";
                            q = (Query) session.createQuery(hql1);
                            q.executeUpdate();
                            pw.println("The item with Item Code : "+itemCode+" and Status : "+currentStatus+" does not exist!");
                        }
                    }
                }
                pw.println("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update verification  set approved='No' where verification_no='"+verificationNo+"' and approved='Pending'";
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
