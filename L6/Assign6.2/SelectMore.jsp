<!-- Begin: SelectMore.jsp -->
<%@ page import="java.sql.*" %>




<HTML>
<HEAD>
    <STYLE TYPE="text/css">
	.defaultText{font-family:Helvetica,Arial;font-size:10pt;}
	.tableEvenRow{font-family:Helvetica,Arial;font-size:9pt;background-color:#E6E6E6;}
	.tableOddRow{font-family:Helvetica,Arial;font-size:9pt;background-color:#FFFFFF;}
    </STYLE>
    <SCRIPT>
    function handleCheckout(obj)
    {
	if (obj.value == "Update")
	{
	    document.forms.main.action="SelectMore.jsp";
	}
	else if (obj.value == "Checkout")
	{
	    document.forms.main.action="Checkout.jsp";
	}
	document.forms.main.submit();
    }
    </SCRIPT>
</HEAD>
<BODY>
    <FORM name="main" >
	<table align="center">
	    <tr class="tableEvenRow">
		<td></td>
		<td>Item #</td>
		<td>Item Name</td>
		<td>Price</td>
		<td>Quantity</td>
	    </tr>
<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/orderdatabase?user=root&password=sesame");
Statement statement = connection.createStatement();
String sqlItemList = "SELECT * FROM item";
ResultSet rs = statement.executeQuery(sqlItemList);
Double penPrice=0.0, pencilPrice=0.0, eraserPrice=0.0, price=0.0;
boolean bPenSelect = false, bPencilSelect = false, bEraserSelect = false;
boolean checked=false;
String penQty = "1", pencilQty = "1", eraserQty = "1";
String it_qty = "1"; 
double totalBill = 0.0, it_price = 0.0;
String it_name="", strClass="tableEvenRow";
int it_id=0;

while (rs.next()){
   it_name = rs.getString("item_name");
   it_id = rs.getInt("item_id");
   checked = false;
   it_qty = "1";
   it_price = Double.parseDouble(rs.getString("item_price").toString());
   if (it_name.equals("Pen")){
      String penSelect = request.getParameter("PenSelect");
      if (penSelect != null && penSelect.equals("on"))
      {
        penPrice = Double.parseDouble(rs.getString("item_price").toString());
	bPenSelect = true;
        checked = true;
	penQty = request.getParameter(it_name+"Qty");
//        out.println (penQty);
        it_qty = penQty;
	totalBill += Integer.parseInt(penQty) * penPrice;
      }
   }else if (it_name.equals("Pencil")){
    String pencilSelect = request.getParameter("PencilSelect");
    if (pencilSelect != null && pencilSelect.equals("on"))
    {
	bPencilSelect = true;
        pencilPrice = Double.parseDouble(rs.getString("item_price").toString());
        checked = true;
	pencilQty = request.getParameter(it_name+"Qty");
  //      out.println (pencilQty);
        it_qty = pencilQty;
	totalBill += Integer.parseInt(pencilQty) * pencilPrice;
    }
   }else if (it_name.equals("Eraser")){
    String eraserSelect = request.getParameter("EraserSelect");
    if (eraserSelect != null && eraserSelect.equals("on"))
    {
	bEraserSelect = true;
        checked = true;
        eraserPrice = Double.parseDouble(rs.getString("item_price").toString());
	eraserQty = request.getParameter(it_name+"Qty");
        it_qty = eraserQty;
    //    out.println (eraserQty);
	totalBill += Integer.parseInt(eraserQty) * eraserPrice;
    }
   }
//out.println (totalBill);
if (strClass.equals("tableEvenRow")) strClass = "tableOddRow";
else strClass = "tableEvenRow";
%>
<tr class="tableOddRow">
    <td>
       <INPUT type="checkbox" name=<%=it_name+"Select"%>
	    <%= (checked? "CHECKED" : "") %>/>
		</td>
		<td><%=it_id%></td>
		<td><%=it_name%></td>
		<td><%=it_price%></td>
		<td>
		    <INPUT type="text" name= <%=it_name+"Qty"%> size="3"
			    value="<%=it_qty %>"></INPUT>
		</td>
	    </tr>
<%
}//while
%>
	   
	    <tr class="defaultText"><td colspan=5><hr></td></tr>
	    <tr class="defaultText">
		<td colspan=5 align="center"> Total Bill: <%= totalBill %></td>
	    </tr>
	    <tr class="defaultText"><td colspan=5><hr></td></tr>
	    <tr class="defaultText">
		<td align="center" colspan=3>
		    <INPUT type="button" name="update" value="Update"
			    onclick="handleCheckout(this)">
		</td>
		<td align="center" colspan=3>
		    <INPUT type="button" name="checkout" value="Checkout"
			    onclick="handleCheckout(this)">
		</td>
	    </tr>
	</table>
    </FORM>
</BODY>
</HTML>
<!-- End: SelectMore.jsp -->