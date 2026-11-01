<%@ page import="java.sql.*" %>
<%@ page import="com.library.DB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
private String esc(String s) {
 if(s==null)return "";
 return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;");
}
%>
<%
String message=request.getParameter("message");
int books=0,students=0,active=0,unpaid=0;
try(Connection c=DB.getConnection();Statement s=c.createStatement()) {
 try(ResultSet r=s.executeQuery("SELECT COUNT(*) FROM BOOKS")){if(r.next())books=r.getInt(1);}
 try(ResultSet r=s.executeQuery("SELECT COUNT(*) FROM STUDENTS")){if(r.next())students=r.getInt(1);}
 try(ResultSet r=s.executeQuery("SELECT COUNT(*) FROM ISSUES WHERE RETURN_DATE IS NULL")){if(r.next())active=r.getInt(1);}
 try(ResultSet r=s.executeQuery("SELECT NVL(SUM(FINE),0) FROM ISSUES WHERE FINE_PAID='N' AND RETURN_DATE IS NOT NULL")){if(r.next())unpaid=r.getInt(1);}
} catch(SQLException e){message="Database error: "+e.getMessage();}
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Smart Library Management</title>
<style>
*{box-sizing:border-box}body{margin:0;background:#f2f5fa;color:#253247;font-family:Arial,sans-serif}
header{background:#213d65;color:white;padding:22px 5%}header h1{margin:0 0 6px}
main{max-width:1180px;margin:24px auto;padding:0 18px}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:14px;margin-bottom:20px}
.stat,.panel{background:white;border-radius:10px;padding:18px;box-shadow:0 2px 9px #1d355710}
.stat strong{display:block;font-size:26px;color:#244b7c;margin-top:7px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:16px}
.panel{margin-bottom:16px}.panel h2,.panel h3{margin-top:0;color:#244b7c}
input{width:100%;padding:10px;margin:6px 0 10px;border:1px solid #ccd5e2;border-radius:6px}
button{background:#2c5688;color:white;border:0;border-radius:6px;padding:10px 14px;cursor:pointer}
button:hover{background:#1e3e66}.danger{background:#9b3b3b}
table{width:100%;border-collapse:collapse;font-size:14px}th,td{text-align:left;padding:10px;border-bottom:1px solid #e4e9f0}
th{background:#edf2f8}.table-wrap{overflow-x:auto}.msg{background:#e8f5ed;padding:12px;border-radius:7px;color:#17613a}
.hint{font-size:13px;color:#68778b}
@media(max-width:600px){header{padding:18px}main{padding:0 10px}}
</style></head><body>
<header><h1>Smart Library Management System</h1><div>NetBeans | Java Servlet | JSP | JDBC | Oracle PL/SQL</div></header>
<main>
<%if(message!=null&&!message.isEmpty()){%><p class="msg"><%=esc(message)%></p><%}%>
<div class="stats">
<div class="stat">Total Books<strong><%=books%></strong></div>
<div class="stat">Students<strong><%=students%></strong></div>
<div class="stat">Active Issues<strong><%=active%></strong></div>
<div class="stat">Unpaid Fines (₹)<strong><%=unpaid%></strong></div>
</div>
<div class="grid">
<section class="panel"><h3>Add Book</h3><form action="library" method="post">
<input type="hidden" name="action" value="addBook"><input name="title" placeholder="Book title" maxlength="100" required>
<input name="author" placeholder="Author" maxlength="100" required><input name="category" placeholder="Category" maxlength="50">
<input name="quantity" type="number" min="0" placeholder="Quantity" required><button>Add Book</button></form></section>
<section class="panel"><h3>Delete Book</h3><form action="library" method="post">
<input type="hidden" name="action" value="deleteBook"><input name="bookId" type="number" min="1" placeholder="Book ID" required><button class="danger">Delete Book</button></form><p class="hint">Books with issue history cannot be deleted.</p></section>
<section class="panel"><h3>Register Student</h3><form action="library" method="post">
<input type="hidden" name="action" value="addStudent"><input name="studentName" placeholder="Student name" maxlength="100" required>
<input name="email" type="email" placeholder="Email" maxlength="120"><input name="phone" placeholder="Phone" maxlength="15"><button>Add Student</button></form></section>
<section class="panel"><h3>Delete Student</h3><form action="library" method="post">
<input type="hidden" name="action" value="deleteStudent"><input name="studentId" type="number" min="1" placeholder="Student ID" required><button class="danger">Delete Student</button></form><p class="hint">Students with issue history cannot be deleted.</p></section>
<section class="panel"><h3>Issue Book</h3><form action="library" method="post">
<input type="hidden" name="action" value="issue"><input name="bookId" type="number" min="1" placeholder="Book ID" required>
<input name="studentId" type="number" min="1" placeholder="Student ID" required><button>Issue Book</button></form><p class="hint">14-day loan; maximum 3 active books per student.</p></section>
<section class="panel"><h3>Return Book</h3><form action="library" method="post">
<input type="hidden" name="action" value="return"><input name="issueId" type="number" min="1" placeholder="Issue ID" required><button>Return Book</button></form><p class="hint">Late fine: ₹5 per day after due date.</p></section>
</div>

<section class="panel"><h2>Book Records</h2><div class="table-wrap"><table><tr><th>ID</th><th>Title</th><th>Author</th><th>Category</th><th>Available</th></tr>
<%try(Connection c=DB.getConnection();Statement s=c.createStatement();ResultSet r=s.executeQuery("SELECT BOOK_ID,TITLE,AUTHOR,CATEGORY,QUANTITY FROM BOOKS ORDER BY BOOK_ID")){while(r.next()){%>
<tr><td><%=r.getInt(1)%></td><td><%=esc(r.getString(2))%></td><td><%=esc(r.getString(3))%></td><td><%=esc(r.getString(4))%></td><td><%=r.getInt(5)%></td></tr>
<%}}catch(SQLException e){%><tr><td colspan="5">Could not load books: <%=esc(e.getMessage())%></td></tr><%}%>
</table></div></section>

<section class="panel"><h2>Student Records</h2><div class="table-wrap"><table><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th></tr>
<%try(Connection c=DB.getConnection();Statement s=c.createStatement();ResultSet r=s.executeQuery("SELECT STUDENT_ID,STUDENT_NAME,EMAIL,PHONE FROM STUDENTS ORDER BY STUDENT_ID")){while(r.next()){%>
<tr><td><%=r.getInt(1)%></td><td><%=esc(r.getString(2))%></td><td><%=esc(r.getString(3))%></td><td><%=esc(r.getString(4))%></td></tr>
<%}}catch(SQLException e){%><tr><td colspan="4">Could not load students: <%=esc(e.getMessage())%></td></tr><%}%>
</table></div></section>

<section class="panel"><h2>Issue and Return History</h2><div class="table-wrap"><table>
<tr><th>Issue ID</th><th>Book</th><th>Student</th><th>Issue Date</th><th>Due Date</th><th>Return Date</th><th>Fine</th><th>Status</th></tr>
<%String q="SELECT I.ISSUE_ID,B.TITLE,S.STUDENT_NAME,I.ISSUE_DATE,I.DUE_DATE,I.RETURN_DATE,I.FINE,I.FINE_PAID FROM ISSUES I JOIN BOOKS B ON I.BOOK_ID=B.BOOK_ID JOIN STUDENTS S ON I.STUDENT_ID=S.STUDENT_ID ORDER BY I.ISSUE_ID DESC";
try(Connection c=DB.getConnection();Statement s=c.createStatement();ResultSet r=s.executeQuery(q)){while(r.next()){Date returned=r.getDate(6);int fine=r.getInt(7);String paid=r.getString(8);%>
<tr><td><%=r.getInt(1)%></td><td><%=esc(r.getString(2))%></td><td><%=esc(r.getString(3))%></td><td><%=r.getDate(4)%></td><td><%=r.getDate(5)%></td><td><%=returned==null?"Not returned":returned%></td><td>₹<%=fine%></td><td><%=fine==0?"—":("Y".equals(paid)?"Paid":"Unpaid")%></td></tr>
<%}}catch(SQLException e){%><tr><td colspan="8">Could not load issue records: <%=esc(e.getMessage())%></td></tr><%}%>
</table></div></section>
<section class="panel"><h3>Mark Fine as Paid</h3><form action="library" method="post">
<input type="hidden" name="action" value="payFine"><input name="issueId" type="number" min="1" placeholder="Issue ID" required><button>Mark Fine Paid</button></form></section>
</main></body></html>
