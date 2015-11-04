import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class logout extends HttpServlet
	{
		public void doGet(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException
			{
			         res.setContentType("text/html");
			         PrintWriter pw = res.getWriter();
			         HttpSession ses =req.getSession();
                                 ses.invalidate();
                                 res.sendRedirect("index.jsp");

			}

	}