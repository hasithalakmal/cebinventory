
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

public class ApproveAdjustmentsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = session =sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        List adjustmentsList = null;
        try{
          if(request.getParameter("parameter").equals("search")){
            String adjustmentsNo = request.getParameter("adjustmentNo");
            adjustmentsList = session.createQuery("from adjustments where adjustment_no='"+adjustmentsNo+"' and approved='Pending' order by item_code, status").list();
            if(!adjustmentsList.isEmpty()){
                adjustments a = (adjustments)adjustmentsList.get(0);
                List ownerList = session.createQuery("from owner where user_name='"+a.getUser_name()+"'").list();
                String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                for(int i=0; i<adjustmentsList.size(); i++){
                    adjustments adj = (adjustments)adjustmentsList.get(i);
                    List itemMasterList = session.createQuery("from item_master where item_code='"+adj.getItem_code()+"'").list();
                    String item_code = adj.getItem_code();
                    String item_name = ((item_master)itemMasterList.get(0)).getItem_name();
                    String current_status = StatusConverter.convertDigitsToString(adj.getStatus());
                    String actual_quantity = adj.getActual_quantity();
                    String available_quantity = adj.getAvailable_quantity();
                    String remarks = adj.getRemarks();
                    int diff = Integer.parseInt(available_quantity)-Integer.parseInt(actual_quantity);
                    pw.print(item_code+";"+item_name+";"+current_status+";"+actual_quantity+";"+available_quantity+";"+String.valueOf(diff)+";"+remarks+";"+owner+";"+a.getUser_name()+";"+adjustmentsNo+"%");
                }
            }
            else{
                pw.print("zzzz");
            }
          }
          else if(request.getParameter("parameter").equals("view")){
                List adjustmentList = session.createQuery("select distinct adjustment_no from adjustments where approved='Pending' order by adjustment_no").list();
                if(!adjustmentList.isEmpty()){
                    for(int i=0; i<adjustmentList.size(); i++){
                        String adjNo = (String) adjustmentList.get(i);
                        List adjustmentList1 = session.createQuery("select user_name from adjustments where adjustment_no='"+adjNo+"'").list();
                        String userName = (String) adjustmentList1.get(0);
                        List ownerList = session.createQuery("from owner where user_name='"+userName+"'").list();
                        String owner = ((owner)ownerList.get(0)).getOwner_first_name()+" "+((owner)ownerList.get(0)).getOwner_last_name();
                        pw.println("Adjustment No : "+adjNo+"     Owner : "+owner+" ");
                    }
                }
                else {
                    pw.println("All adjustments have been approved.");
                }
          }
          else if(request.getParameter("parameter").equals("update")){
            Query q = null;
            String itemCode = request.getParameter("itemCode");
            String userName = request.getParameter("userName");
            String adjustmentNo = request.getParameter("adjustmentNo");
            String status = StatusConverter.convertStringToDigits(request.getParameter("status"));
            String availableQty = request.getParameter("availableQuantity");
            if(request.getParameter("type").equals("Y")){
                List ownerItemList = session.createQuery("from owner_item_master where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'").list();
                if(!ownerItemList.isEmpty()){
                    String hql1 = "update owner_item_master  set quantity='"+availableQty+"', conflict_flag='0', freeze='0' where item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql1);
                    q.executeUpdate();
                    String hql = "update adjustments  set approved='Yes' where  adjustment_no='"+adjustmentNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql);
                    q.executeUpdate();
                    pw.print("Successfully Updated!");
                }
                else {                  
                    String hql = "update adjustments  set approved='Conflict' where  adjustment_no='"+adjustmentNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                    q = (Query) session.createQuery(hql);
                    q.executeUpdate();
                    pw.print("Conflicting Request. Item does not exist!");
                }
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update adjustments  set approved='No' where  adjustment_no='"+adjustmentNo+"' and item_code='"+itemCode+"' and user_name='"+userName+"' and status='"+status+"'";
                q = (Query) session.createQuery(hql);
                q.executeUpdate();
                pw.print("Successfully Updated!");
            }
          }
          else if(request.getParameter("parameter").equals("updateAll")){
            Query q = null;
            boolean flag=false;
            String adjustmentNo = request.getParameter("adjustmentNo");
            if(request.getParameter("type").equals("Y")){
                adjustmentsList = session.createQuery("from adjustments where adjustment_no='"+adjustmentNo+"' and approved='Pending'").list();
                for(int i=0; i<adjustmentsList.size(); i++){
                    adjustments adj = (adjustments)adjustmentsList.get(i);
                    List ownerItemList = session.createQuery("from owner_item_master where item_code='"+adj.getItem_code()+"' and user_name='"+adj.getUser_name()+"' and status='"+adj.getStatus()+"'").list();
                    if(!ownerItemList.isEmpty()){
                        String hql1 = "update owner_item_master  set quantity='"+adj.getAvailable_quantity()+"', conflict_flag='0', freeze='0' where item_code='"+adj.getItem_code()+"' and user_name='"+adj.getUser_name()+"' and status='"+adj.getStatus()+"'";
                        q = (Query) session.createQuery(hql1);
                        q.executeUpdate();
                        String hql = "update adjustments  set approved='Yes' where  adjustment_no='"+adjustmentNo+"' and item_code='"+adj.getItem_code()+"' and user_name='"+adj.getUser_name()+"' and status='"+adj.getStatus()+"'";
                        q = (Query) session.createQuery(hql);
                        q.executeUpdate();
                    }
                    else{
                        if(!flag){
                            pw.println("The following adjustments could not be made due to conflicts :-");
                            flag = true;
                        }
                        String hql = "update adjustments  set approved='Conflict' where  adjustment_no='"+adjustmentNo+"' and item_code='"+adj.getItem_code()+"' and user_name='"+adj.getUser_name()+"' and status='"+adj.getStatus()+"'";
                        q = (Query) session.createQuery(hql);
                        q.executeUpdate();
                        pw.println(" User ID : "+adj.getUser_name()+"  Item Code : "+adj.getItem_code()+" Item Status : "+StatusConverter.convertDigitsToString(adj.getStatus())+" Actual Quantity : "+adj.getActual_quantity()+" Available Quantity : "+adj.getAvailable_quantity());
                    }

                }
                pw.println("Successfully Updated!");
            }
            else if(request.getParameter("type").equals("N")){
                String hql = "update adjustments  set approved='No' where adjustment_no='"+adjustmentNo+"' and approved='Pending'";
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
