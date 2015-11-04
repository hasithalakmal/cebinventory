import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Query;
import org.hibernate.Transaction;


public class remove_user extends HttpServlet{
@Override
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    Session session = null;
    Transaction tx=null;

    try{

        if(request.getParameter("parameter").equals("remove")){

            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            session =sessionFactory.openSession();
            tx=session.beginTransaction();
            String username=request.getParameter("userName");
            String cause=request.getParameter("cause");

            String hql ="update owner set status='"+cause+"' where user_name='"+username+"'";
            Query q = session.createQuery(hql);
            q.executeUpdate();

            List empList = session.createQuery("from owner_item_master where user_name='"+username+"'").list();
            int len=empList.size();

            for(int i=0;i<len;i++){
                owner_item_master emp = (owner_item_master)empList.get(i);
                String centre_id=emp.getCost_id();
                String user_name=emp.getUser_name();
                String section_id=emp.getSection_id();
                String item_code=emp.getItem_code();

                List empList2 = session.createQuery("from item_master where item_code='"+item_code+"'").list();
                item_master emp2 = (item_master)empList2.get(0);
                String item_name=emp2.getItem_name();

                String quantity=emp.getQuantity();
                String uom=emp.getUnit_of_measure();
                String status=emp.getStatus();
                String sta=StatusConverter.convertDigitsToString(status);
                pw.print(centre_id+";"+section_id+";"+user_name+";"+item_code+";"+item_name+";"+uom+";"+quantity+";"+sta+"%");
            }
            tx.commit();

        }

        int a=1;
        if(request.getParameter("parameter").equals("return")){
            if(request.getParameter("type").equals("Y")){
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                session =sessionFactory.openSession();
                tx=session.beginTransaction();
                String username=request.getParameter("userName");

                List own = session.createQuery("from owner where user_name='"+username+"'").list();
                owner emp3 = (owner)own.get(0);
                String costid=emp3.getCost_id();
                String sectionid=emp3.getSection_id();

                List sup = session.createQuery("from owner where user_role='Supervisor' AND cost_id='"+costid+"' AND section_id='"+sectionid+"'").list();

                owner emp4 = (owner)sup.get(0);
                String supervisor=emp4.getUser_name();

                 int qua=0;
                int qua2=0;

                List empList = session.createQuery("from owner_item_master where user_name='"+username+"'").list();
                int len=empList.size();
                List empList2 = session.createQuery("from owner_item_master where user_name='"+supervisor+"'").list();
                int len2=empList.size();
                for(int i=0;i<len;i++){
                    owner_item_master empo = (owner_item_master)empList.get(i);
                    String item_code=empo.getItem_code();
                    String quantity=empo.getQuantity();
                    qua=Integer.parseInt(quantity);
                    for(int j=0;j<len2;j++){
                        owner_item_master emps = (owner_item_master)empList2.get(j);
                        String item_code2=emps.getItem_code();
                        String quantity2=empo.getQuantity();
                        qua2=Integer.parseInt(quantity2);
                        if (item_code.equals(item_code2)){


                            qua=qua+qua2;
                            String hql ="update owner_item_master set quantity='"+qua+"' where item_code='"+item_code+"'";
                            Query q = session.createQuery(hql);
                            q.executeUpdate();
                            Query query = session.createQuery("delete from owner_item_master where item_code='"+item_code+"' AND user_name='"+username+"'");
                            query.executeUpdate();

                            }
                        }
                }


                String hql2 ="update owner_item_master set user_name='"+supervisor+"' where user_name='"+username+"'";
                Query q2 = session.createQuery(hql2);
                q2.executeUpdate();
                a=2;

            }

            if(request.getParameter("type").equals("N")){
                a=3;
            }
            tx.commit();
            if(a==2){
                    pw.print("User's items are transferred to the Superviosr");
                    }
            else if(a==3){
                    pw.print("User's items are not transferred to the Supervisor. It is still under the user");
                    }
        }
    }catch(Exception e){
        tx.rollback();
        System.out.println(e.getMessage());
    }finally{
        session.flush();
      session.close();
      }
    }
}