import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
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


public class selectSec extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String coName= request.getParameter("coce");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pw= response.getWriter();
        Session session = null;
        Transaction tx=null;
            try{
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                session =sessionFactory.openSession();
                tx=session.beginTransaction();
                List empList = session.createQuery("from section_master  where center_name='"+coName+"'").list();
                for(int i=0; i<empList.size();i++){
                    section_master cati= (section_master)empList.get(i);
                    pw.println(cati.getSection_name()+";");
                }
                tx.commit();
            }catch(Exception e){
                tx.rollback();
            }finally{

            }
    }
}

   