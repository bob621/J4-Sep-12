<%@page import="java.sql.*,java.util.*"%>
<HTML>
   <HEAD>
       <TITLE> Add a Customer </TITLE>
   </HEAD>

   <BODY>

     <H1>Adding Customer to Database</H1>
     <%
       String fname=request.getParameter("first_name");
       String lname=request.getParameter("last_name");
       int cid =Integer.parseInt(request.getParameter("customer_id"));
       int age=Integer.parseInt(request.getParameter("age"));
       double ovalue=Double.parseDouble(request.getParameter("order_value"));
       int ci = 0;
       String fn = "", ln="";
       int ag=0;
       double ov=0.0;
       ResultSet rs=null;

       try{
	  Class.forName("com.mysql.jdbc.Driver").newInstance();
	  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/orderdatabase?user=root&password=sesame");
	  Statement st=con.createStatement();
	  st.executeUpdate("INSERT INTO customer(customer_id, first_name,last_name,age,order_value) values("+cid+",'"+fname+"','"+lname+"',"+age+","+ovalue+")");
//	  Statement st2= con.createStatement();
	  rs = st.executeQuery ("SELECT customer_id, first_name, last_name, age, order_value FROM customer WHERE first_name='"+fname+"'");

	  if (rs.next()){
	  ci = rs.getInt(1);
	  fn = rs.getString("first_name");
	  ln = rs.getString("last_name");
	  ag = rs.getInt(4);
	  ov = rs.getDouble("order_value");
	 }else {
          ci = 0;
          fn = "Fake";
          ln = "Fake2";
          ag = 11;
          ov = 0.91;
     }
	   } catch(SQLException e){
	  }

     %>
       <TABLE BORDER="1">
	  <TR>
	      <TH> Customer Addition </TH>
	  </TR>
	  <TR>
	     <TD> Customer ID: </TD>
             <TD><%=rs.getInt(1)%></TD>
          </TR>
             <TD> First Name: </TD>
	     <TD> <%out.println (fn); %></TD>
          </TR>
	  <TR>
             <TD> Last Name: </TD>
	     <TD> <%=rs.getString("last_name")%> </TD>
	  </TR>
	  <TR>
             <TD> Age: </TD>
	     <TD> <%out.println(age);%></TD>
	  </TR>
	  <TR>
             <TD> Order Value: </TD>
	     <TD> <%out.println(ov);%></TD>
	  </TR>

	</TABLE>
     <%
//        }//while
     %>

     <A HREF="http://localhost:8080/jsp/L5/Assign5.1/InputCustomer.jsp">Click Here to Add One More</a>
     <BR>
     <A HREF="http://localhost:8080/jsp/L5/Assign5.1/CustomerList.jsp">Click Here for Customer List</a
   </BODY>
</HTML>