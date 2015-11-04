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
public class ApproveAuctioningServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session =sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        List auctionList = null;
        try{
          if(request.getParameter("parameter").equals("search")){
            String auctionNo = request.getParameter("auctionNo");
            auctionList = session.createQuery("from auctioning_list where auction_no='"+auctionNo+"' and approved='Pending' order by user_name, item_code, status").list();
            if(!auctionList.isEmpty()){
                for(int i=0; i<auctionList.size(); i++){
                    auctioning_list auc = (auctioning_list)auctionList.get(i);
                    List ownerList = session.createQuery("from owner where user_name='"+auc.getUser_name()+"'").list();
                    String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                    List itemMasterList = session.createQuery("from item_master where item_code='"+auc.getItem_code()+"'").list();
                    String item_code = auc.getItem_code();
                    String item_name = ((item_master)itemMasterList.get(0)).getItem_name();
                    String status = StatusConverter.convertDigitsToString(auc.getStatus());
                    String quantity = auc.getQuantity();
                    String remarks = auc.getRemarks();
                    String price = auc.getPrice();
                    String value = auc.getValue();
                    String selling_price = auc.getSelling_price();
                    String cause_for_auction = auc.getCause_for_auction();
                    pw.print(owner+";"+item_code+";"+item_name+";"+status+";"+quantity+";"+remarks+";"+price+";"+value+";"+selling_price+";"+cause_for_auction+";"+auc.getUser_name()+";"+auctionNo+"%");
                }
            }
            else{
                pw.print("zzzz");
            }
          }
          else if(request.getParameter("parameter").equals("view")){
                auctionList = session.createQuery("select distinct auction_no from auctioning_list where approved='Pending' order by auction_no").list();
                if(!auctionList.isEmpty()){
                    for(int i=0; i<auctionList.size(); i++){
                        String aucNo = (String) auctionList.get(i);
                        pw.println("Auction No : "+aucNo);
                    }
                }
                else {
                    pw.println("All auctioning lists have been approved.");
                }
          }
          else if(request.getParameter("parameter").equals("update")){
            Query q = null;
            String itemCode = request.getParameter("itemCode");
            String userName = request.getParameter("userName");
            String auctionNo = request.getParameter("auctionNo");
            String status = StatusConverter.convertStringToDigits(request.getParameter("status"));
            String quantity = request.getParameter("quantity");
            if(request.getParameter("type").equals("Y")){
                List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'").list();
                int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                int difference = actualQuantity-Integer.parseInt(quantity);
                if(difference >= 0){
                    String newStatus = status.substring(0, 3) + "1";
                    List ownerItemListTemp = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+newStatus+"'").list();
                    if(!ownerItemListTemp.isEmpty()){
                        int newQty = Integer.parseInt(((owner_item_master)ownerItemListTemp.get(0)).getQuantity())+Integer.parseInt(quantity);
                        String hql2 = "update owner_item_master  set quantity='"+newQty+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+newStatus+"'";
                        q = (Query) session.createQuery(hql2);
                        q.executeUpdate();
                        String hql = "update owner_item_master  set quantity='"+difference+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                        q = (Query) session.createQuery(hql);
                        q.executeUpdate();
                    }
                    else {
                        List ownerItemListTemp1 = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'").list();
                        owner_item_master oim = (owner_item_master)ownerItemListTemp1.get(0);
                        if(itemCode.charAt(0)=='s'){
                            String hql = "update owner_item_master  set quantity='"+difference+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                            owner_item_master om = new owner_item_master();
                            om.setConflict_flag(oim.getConflict_flag());
                            om.setCost_id(oim.getCost_id());
                            om.setFreeze(oim.getFreeze());
                            om.setItem_code(oim.getItem_code());
                            om.setQuantity(quantity);
                            om.setSection_id(oim.getSection_id());
                            om.setStatus(newStatus);
                            om.setUnit_of_measure(oim.getUnit_of_measure());
                            om.setUser_name(oim.getUser_name());
                            om.setLended(oim.getLended());
                            session.save(om);
                        }
                        else if(itemCode.charAt(0)=='i'){
                            String hql = "update owner_item_master  set status='"+newStatus+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                        }
                    }
                    String hql1 = "update auctioning_list  set approved='Yes' where  auction_no='"+auctionNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql1);
                    q.executeUpdate();
                    pw.println("Successfully Updated!");
                }
                else{
                    String hql = "update auctioning_list set approved='Conflict' where auction_no='"+auctionNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql);
                    q.executeUpdate();
                    String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql1);
                    q.executeUpdate();
                    pw.println("Conflicting request!");
                }
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update auctioning_list  set approved='No' where  auction_no='"+auctionNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.println("Successfully Updated!");
            }
          }
          else if(request.getParameter("parameter").equals("updateAll")){
            Query q = null;
            String auctionNo = request.getParameter("auctionNo");
            if(request.getParameter("type").equals("Y")){
                boolean flag = false;
                auctionList = session.createQuery("from auctioning_list where auction_no='"+auctionNo+"' and approved='Pending'").list();
                for(int i=0; i<auctionList.size(); i++){
                    String itemCode = ((auctioning_list)auctionList.get(i)).getItem_code();
                    String userName = ((auctioning_list)auctionList.get(i)).getUser_name();
                    String status = ((auctioning_list)auctionList.get(i)).getStatus();
                    String quantity = ((auctioning_list)auctionList.get(i)).getQuantity();
                    List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'").list();
                    int actualQuantity = Integer.parseInt(((owner_item_master)ownerItemList.get(0)).getQuantity());
                    int difference = actualQuantity-Integer.parseInt(quantity);
                    if(difference >= 0){
                        String newStatus = status.substring(0, 3) + "1";
                        List ownerItemListTemp = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+newStatus+"'").list();
                        if(!ownerItemListTemp.isEmpty()){
                            int newQty = Integer.parseInt(((owner_item_master)ownerItemListTemp.get(0)).getQuantity())+Integer.parseInt(quantity);
                            String hql2 = "update owner_item_master  set quantity='"+newQty+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+newStatus+"'";
                            q = (Query) session.createQuery(hql2);
                            q.executeUpdate();
                            String hql = "update owner_item_master  set quantity='"+difference+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                            q = (Query) session.createQuery(hql);
                            q.executeUpdate();
                        }
                        else {
                            List ownerItemListTemp1 = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'").list();
                            owner_item_master oim = (owner_item_master)ownerItemListTemp1.get(0);
                            if(itemCode.charAt(0)=='s'){
                                String hql = "update owner_item_master  set quantity='"+difference+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                                q = (Query) session.createQuery(hql);
                                q.executeUpdate();
                                owner_item_master om = new owner_item_master();
                                om.setConflict_flag(oim.getConflict_flag());
                                om.setCost_id(oim.getCost_id());
                                om.setFreeze(oim.getFreeze());
                                om.setItem_code(oim.getItem_code());
                                om.setQuantity(quantity);
                                om.setSection_id(oim.getSection_id());
                                om.setStatus(newStatus);
                                om.setUnit_of_measure(oim.getUnit_of_measure());
                                om.setUser_name(oim.getUser_name());
                                om.setLended(oim.getLended());
                                session.save(om);
                            }
                            else if(itemCode.charAt(0)=='i'){
                                String hql = "update owner_item_master  set status='"+newStatus+"' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                                q = (Query) session.createQuery(hql);
                                q.executeUpdate();
                            }
                        }
                        String hql1 = "update auctioning_list  set approved='Yes' where  auction_no='"+auctionNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                        q = (Query) session.createQuery(hql1);
                        q.executeUpdate();
                    }
                    else{
                        if(!flag){
                            pw.println("The following adjustments could not be made due to conflicts :-");
                            flag = true;
                        }
                        String hql = "update auctioning_list set approved='Conflict' where auction_no='"+auctionNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                        q = (Query) session.createQuery(hql);
                        q.executeUpdate();
                        String hql1 = "update owner_item_master  set conflict_flag='1' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                        q = (Query) session.createQuery(hql1);
                        q.executeUpdate();
                        pw.println(" User ID : "+userName+"  Item Code : "+itemCode+" Item Status : "+StatusConverter.convertDigitsToString(status)+" Quantity : "+quantity);
                    }
                }
                pw.println("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update auctioning_list  set approved='No' where  auction_no='"+auctionNo+"' and approved='Pending'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.println("Successfully Updated!");
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
