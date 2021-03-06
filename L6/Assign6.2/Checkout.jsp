<!-- Begin: Checkout.jsp -->
<%@page import="java.sql.*, java.util.*"%>
<%
    boolean bPenSelect = false, bPencilSelect = false, bEraserSelect = false;
    String penQty = "1", pencilQty = "1", eraserQty = "1", itemList = "";
    int penID=0, pencilID=0, eraserID=0;

    double totalBill = 0.0; String penSelect = request.getParameter("PenSelect");

    String itemName = "";

      if (penSelect != null && penSelect.equals("on"))
      {
	bPenSelect = true;
	itemList += "Pen";
	penQty = request.getParameter("PenQty");
	totalBill += Integer.parseInt(penQty) * 2.00;
      }
      String pencilSelect = request.getParameter("PencilSelect");
      if (pencilSelect != null && pencilSelect.equals("on"))
      {
	bPencilSelect = true;
	itemList += "Pencil";
	pencilQty = request.getParameter("PencilQty");
	totalBill += Integer.parseInt(pencilQty) * 1.00;
      }
      String eraserSelect = request.getParameter("EraserSelect");
      if (eraserSelect != null && eraserSelect.equals("on"))
      {
	bEraserSelect = true;
	itemList += "Eraser";
	eraserQty = request.getParameter("EraserQty");
	totalBill += Integer.parseInt(eraserQty) * 0.50;
      }


   int oid = 0, uid=0, od_id = 0;;
   uid = Integer.parseInt(session.getAttribute("UID").toString());
   ResultSet rsItem = null, rsOrder = null, rsOrderDet=null;
   try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/orderdatabase?user=root&password=sesame");
    Statement stmt = con.createStatement();
    Statement stmt2 = con.createStatement();

    rsOrder = stmt.executeQuery ("SELECT MAX(order_id) FROM order_submitted");
    if (rsOrder.next()){
       oid = rsOrder.getInt(1) + 1;
    } else {
       oid = 1;
    }
    stmt.executeUpdate("INSERT INTO order_submitted(order_id, user_id, submit_date) values("+oid+", "+uid+", CURRENT_TIMESTAMP)");
    rsOrderDet = stmt2.executeQuery ("SELECT MAX(order_detail_id) FROM order_detail");
    if (rsOrderDet.next()){
       od_id = rsOrderDet.getInt(1) + 1;
    } else {
       od_id = 1;
    }
    if (bPenSelect){
       rsItem = stmt.executeQuery ("SELECT item_id FROM item WHERE item_name='Pen'");
       if (rsItem.next()) penID = rsItem.getInt(1);
       stmt.executeUpdate("INSERT INTO order_detail(order_detail_id, order_id, item_id, item_qty) value("+od_id+", "+oid+","+penID+", "+penQty+")");
//       out.println(od_id);
       od_id +=1;
    }

    if (bPencilSelect) {
       rsItem = stmt.executeQuery ("SELECT item_id FROM item WHERE item_name='Pencil'");
       if (rsItem.next()) pencilID = rsItem.getInt(1);
       stmt.executeUpdate("INSERT INTO order_detail(order_detail_id, order_id, item_id, item_qty) value("+od_id+", "+oid+","+pencilID+", "+pencilQty+")");
       od_id +=1;
    }

    if (bEraserSelect){
       rsItem = stmt.executeQuery ("SELECT item_id FROM item WHERE item_name='Eraser'");
       if (rsItem.next()) eraserID = rsItem.getInt(1);
       stmt.executeUpdate("INSERT INTO order_detail(order_detail_id, order_id, item_id, item_qty) value("+od_id+", "+oid+","+eraserID+", "+eraserQty+")");
       od_id +=1 ;
    }

  } catch (SQLException e){

  }
%>
<HTML>
<HEAD>
    <STYLE TYPE="text/css">
	.defaultText{font-family:Helvetica,Arial;font-size:10pt;}
	.tableEvenRow{font-family:Helvetica,Arial;font-size:9pt;background-color:#E6E6E6;}
	.tableOddRow{font-family:Helvetica,Arial;font-size:9pt;background-color:#FFFFFF;}
    </STYLE>
</HEAD>
<BODY>
    Thank you <%=session.getAttribute("FULL_NAME") + " " %>, for your order! The details of your order number <%=od_id%> are as follows:<br><br>
    <table>
	<tr class="tableEvenRow">
	    <td>Item #</td>
	    <td>Item Name</td>
	    <td>Price</td>
	    <td>Quantity</td>
	</tr>
	<%
	if (bPenSelect)
	{
	%>
	<tr class="tableOddRow">
	    <td>101</td>
	    <td>Pen</td>
	    <td>2.00</td>
	    <td><%= penQty %></td>
	</tr>
	<%
	}
	if (bPencilSelect)
	{
	%>
	    <tr class="tableEvenRow">
		<td>102</td>
		<td>Pencil</td>
		<td>1.00</td>
		<td><%= pencilQty %></td>
	    </tr>
	<%
	}
	if (bEraserSelect)
	{
	%>
	    <tr class="tableOddRow">
		<td>103</td>
		<td>Eraser</td>
		<td>0.50</td>
		<td><%= eraserQty %></td>
	    </tr>
	<%
	}
	%>
	    <tr class="defaultText"><td colspan=4><hr></td></tr>
	    <tr class="defaultText">
		<td colspan=4 align="center"> Total Bill: <%= totalBill %></td>
	    </tr>
	    <tr class="defaultText"><td colspan=4><hr></td></tr>
	</table>
</BODY>
</HTML>
<!-- End: Checkout.jsp -->