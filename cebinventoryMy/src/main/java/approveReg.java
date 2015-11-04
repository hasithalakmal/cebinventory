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
import org.hibernate.Query;
import org.hibernate.Transaction;

public class approveReg extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        Session session = null;
        Transaction tx=null;
        List requestList = null;
        try{
            if(request.getParameter("parameter").equals("load")){
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                session =sessionFactory.openSession();
                tx=session.beginTransaction();
                List empList = session.createQuery("from owner where approved='no'").list();
                int len=empList.size();
                for(int i=0;i<len;i++){
                    owner emp = (owner)empList.get(i);
                    String centre_id=emp.getCost_id();
                    String user_name=emp.getUser_name();
                    String last_name=emp.getOwner_last_name();
                    String first_name=emp.getOwner_first_name();
                    String section_id=emp.getSection_id();
                    String email=emp.getEmail();
                    pw.print(centre_id+";"+section_id+";"+user_name+";"+last_name+";"+first_name+";"+email+"%");
                    }
                tx.commit();
                }

            if(request.getParameter("parameter").equals("approve")){
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                session =sessionFactory.openSession();
                tx=session.beginTransaction();
                Query q = null;
                String userRole = request.getParameter("userRole");
                String userName = request.getParameter("userName");
                int a=1;
                if(request.getParameter("type").equals("Y")){
                    String status = request.getParameter("status");
                    String hql = "update owner  set user_role='"+userRole+"', approved='yes' where user_name='"+userName+"'";
                    q = (Query) session.createQuery(hql);
                    q.executeUpdate();
                    a=2;
                    }

                if(request.getParameter("type").equals("N")){
                    Query query = session.createQuery("delete from owner where user_name='"+userName+"'");
                    query.executeUpdate();
                    a=3;
                    }

                tx.commit();
                if(a==2){
                    pw.print("User's request to register approved successfully");
                    }
                else{
                    pw.print("User's request to register rejected succesfully");
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
