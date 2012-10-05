<!-- Begin: InputCustomer.jsp -->
<%@page import="java.sql.*,java.util.*"%>

<HTML>
<HEAD>
<STYLE>
.defaultText {font-family:Helvetica,Arial; font-size:10pt; color:black;}
.errorText {font-family:Helvetica,Arial; font-size:10pt; color:red;}
</STYLE>
<SCRIPT LANGUAGE="JAVASCRIPT">
function validate()
{
if (document.forms.main.first_name.value == "")
{
alert("First Name cannot be empty.");
return false;
}
else if (document.forms.main.last_name.value == "")
{
alert("Last Name cannot be empty.");
return false;
}
else if (document.forms.main.age.value <= 0)
{
alert("Age cannot be zero or less");
return false;
}
else if (document.forms.main.order_value.value < 0)
{
alert("Order Value cannot be negative");
return false;
}
return true;
}
</SCRIPT>
</HEAD>
<BODY>
<%
      int cid=0;
      ResultSet rs = null; 

       try{
	  Class.forName("com.mysql.jdbc.Driver").newInstance();
	  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/orderdatabase?user=root&password=sesame");
	  Statement st=con.createStatement();
	  rs = st.executeQuery("SELECT MAX(customer_id) FROM customer");
          if (rs.next()){
            cid = rs.getInt(1) + 1; 
      }
         
      }catch (SQLException e){
      }

%>


<FORM name="main" ACTION="InsertCustomer.jsp" METHOD="POST">
<TABLE>
<TR CLASS="defaultText">
<BR />
<TD>Customer ID:</TD>
<TD><INPUT type="text" name="customer_id" value=<%out.println(cid);%> READONLY></INPUT></TD>
</TR>

<TR CLASS="defaultText">
<TD>First Name:</TD>
<TD><INPUT type="text" name="first_name"></INPUT></TD>
<TD>Last Name:</TD>
<TD><INPUT type="text" name="last_name"></INPUT></TD>
</TR>

<TR CLASS="defaultText">
<TD>Age:</TD>
<TD><INPUT type="text" name="age"></INPUT></TD>
<TD>Order Value ($):</TD>
<TD><INPUT type="text" name="order_value"></INPUT></TD>
</TR>

<TR CLASS="defaultText">
<TD COLSPAN=2 ALIGN="CENTER">
<INPUT type="submit" VALUE="Submit" onclick="return validate()"></INPUT>
</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>
<!-- End: InputCustomer.jsp -->