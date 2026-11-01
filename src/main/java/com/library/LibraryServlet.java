package com.library;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/library")
public class LibraryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException {
        String action=request.getParameter("action");
        String message;
        try(Connection con=DB.getConnection()) {
            con.setAutoCommit(false);
            try {
                if("addBook".equals(action)) {
                    try(CallableStatement cs=con.prepareCall("{call ADD_BOOK(?,?,?,?)}")) {
                        cs.setString(1,request.getParameter("title"));
                        cs.setString(2,request.getParameter("author"));
                        cs.setString(3,request.getParameter("category"));
                        cs.setInt(4,Integer.parseInt(request.getParameter("quantity")));
                        cs.execute();
                    }
                    message="Book added successfully.";
                } else if("deleteBook".equals(action)) {
                    try(PreparedStatement ps=con.prepareStatement(
                        "DELETE FROM BOOKS WHERE BOOK_ID=? AND NOT EXISTS (SELECT 1 FROM ISSUES WHERE ISSUES.BOOK_ID=BOOKS.BOOK_ID)")) {
                        ps.setInt(1,Integer.parseInt(request.getParameter("bookId")));
                        message=ps.executeUpdate()>0?"Book deleted.":"Book not found or has issue history.";
                    }
                } else if("addStudent".equals(action)) {
                    try(PreparedStatement ps=con.prepareStatement(
                        "INSERT INTO STUDENTS(STUDENT_NAME,EMAIL,PHONE) VALUES(?,?,?)")) {
                        ps.setString(1,request.getParameter("studentName"));
                        ps.setString(2,request.getParameter("email"));
                        ps.setString(3,request.getParameter("phone"));
                        ps.executeUpdate();
                    }
                    message="Student added successfully.";
                } else if("deleteStudent".equals(action)) {
                    try(PreparedStatement ps=con.prepareStatement(
                        "DELETE FROM STUDENTS WHERE STUDENT_ID=? AND NOT EXISTS (SELECT 1 FROM ISSUES WHERE ISSUES.STUDENT_ID=STUDENTS.STUDENT_ID)")) {
                        ps.setInt(1,Integer.parseInt(request.getParameter("studentId")));
                        message=ps.executeUpdate()>0?"Student deleted.":"Student not found or has issue history.";
                    }
                } else if("issue".equals(action)) {
                    try(CallableStatement cs=con.prepareCall("{call ISSUE_BOOK(?,?)}")) {
                        cs.setInt(1,Integer.parseInt(request.getParameter("bookId")));
                        cs.setInt(2,Integer.parseInt(request.getParameter("studentId")));
                        cs.execute();
                    }
                    message="Book issued. Due date is 14 days after issue.";
                } else if("return".equals(action)) {
                    try(CallableStatement cs=con.prepareCall("{call RETURN_BOOK(?)}")) {
                        cs.setInt(1,Integer.parseInt(request.getParameter("issueId")));
                        cs.execute();
                    }
                    message="Book returned. Late fee calculated if applicable.";
                } else if("payFine".equals(action)) {
                    try(CallableStatement cs=con.prepareCall("{call PAY_FINE(?)}")) {
                        cs.setInt(1,Integer.parseInt(request.getParameter("issueId")));
                        cs.execute();
                    }
                    message="Fine marked as paid.";
                } else message="Unknown action.";
                con.commit();
            } catch(Exception e) {
                con.rollback();
                throw e;
            }
        } catch(NumberFormatException e) {
            message="Please enter valid numeric IDs and quantities.";
        } catch(SQLException e) {
            message="Database error: "+e.getMessage();
        } catch(Exception e) {
            message="Error: "+e.getMessage();
        }
        response.sendRedirect(request.getContextPath()+"/?message="+URLEncoder.encode(message,"UTF-8"));
    }
}
