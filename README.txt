# 📚 Smart Library Management System

Smart Library Management System is a web-based application developed to simplify and manage library operations digitally. It provides a centralized platform for managing books, student records, book issuing, returns, and fine calculations using Oracle Database.

The application allows users to add and manage book records, register students, issue books, process returns, and calculate late fees. It provides an interactive dashboard to monitor library activities and maintain organized records using Java, JDBC, and Oracle PL/SQL.

## 🎯 Objectives

- Manage book records, including book titles, authors, categories, and quantities.
- Register and maintain student information.
- Issue books to registered students.
- Manage book returns and maintain issue history.
- Calculate late return fines automatically.
- Monitor available books and active issues.
- Maintain centralized library records using Oracle Database.
- Implement database operations using SQL and PL/SQL.

## ✨ Features

- **Dashboard:** Displays total books, registered students, active book issues, and unpaid fines.
- **Book Management:** Add, view, and delete book records, including title, author, category, and quantity.
- **Student Management:** Register students and manage their personal information, including name, email, and phone number.
- **Book Issue:** Issue books to registered students while checking book availability.
- **Book Return:** Process book returns and update book quantities automatically.
- **Late Fine Calculation:** Automatically calculates late fees at ₹5 per day after the due date.
- **Issue and Return History:** Maintains records of issued books, students, issue dates, due dates, return dates, and fines.
- **Fine Management:** View unpaid fines and mark eligible fines as paid.
- **Database Integration:** Uses Oracle Database to store and manage book, student, and issue records.
- **PL/SQL Operations:** Uses stored procedures and functions to perform important library operations directly in the database.

## 🛠️ Technologies Used

| Technology                   | Purpose                                          |
| ---------------------------- | ------------------------------------------------ |
| Java 11+                     | Backend programming and application logic        |
| Apache NetBeans              | Java development environment                     |
| Java Servlet                 | Handles HTTP requests and backend operations     |
| JSP (JavaServer Pages)       | Dynamic web page development                     |
| HTML                         | Web page structure                               |
| CSS                          | User interface design and styling                |
| JavaScript                   | Frontend interactions                            |
| JDBC                         | Connects Java application with Oracle Database   |
| Oracle Database              | Database storage and management                  |
| Oracle SQL                   | Table creation and database operations           |
| PL/SQL                       | Stored procedures, functions, and business logic |
| Apache Tomcat 10.1           | Web application server                           |
| Maven                        | Dependency management and project building       |
| Oracle JDBC Driver (ojdbc11) | Oracle database connectivity                     |

## 🏗️ System Architecture

The application follows a client-server architecture:

- **Presentation Layer:** HTML, CSS, and JSP provide the interactive library management interface.
- **Application Layer:** Java Servlets handle user requests and application logic.
- **Database Connectivity Layer:** JDBC establishes communication between Java and Oracle Database.
- **Database Layer:** Oracle Database stores books, student information, and issue records.
- **Business Logic Layer:** PL/SQL procedures and functions handle book operations, issue and return processing, and fine calculations.

## 🗄️ Database Design

The project uses Oracle Database as its database management system.

The database consists of three main tables:

**1. BOOKS**

- BOOK_ID
- TITLE
- AUTHOR
- CATEGORY
- QUANTITY

**2. STUDENTS**

- STUDENT_ID
- STUDENT_NAME
- EMAIL
- PHONE

**3. ISSUES**

- ISSUE_ID
- BOOK_ID
- STUDENT_ID
- ISSUE_DATE
- DUE_DATE
- RETURN_DATE
- FINE
- FINE_PAID

SQL operations are used to:

- INSERT new book and student records.
- SELECT and retrieve existing records.
- UPDATE book quantities and issue information.
- DELETE eligible book and student records.
- Maintain relationships using primary keys and foreign keys.

## ⚙️ PL/SQL Implementation

Oracle PL/SQL is used to implement important library operations.

The project includes:

- **ADD_BOOK:** Adds new book records to the database.
- **ISSUE_BOOK:** Issues books to students and checks availability and issue limits.
- **RETURN_BOOK:** Processes book returns, updates available quantities, and calculates late fees.
- **CALCULATE_FINE:** Calculates late return fines based on the number of overdue days.
- **PAY_FINE:** Updates the fine payment status after payment.

Business rules:

- Students can issue a maximum of 3 active books.
- The book issue period is 14 days.
- A late fine of ₹5 per day is applied after the due date.

## ⚙️ Prerequisites

Before running the project, install:

- Java JDK 11 or later
- Apache NetBeans IDE
- Apache Tomcat 10.1
- Oracle Database (Oracle Free, XE, or another compatible version)
- Oracle SQL Developer
- Maven support in NetBeans

## 🚀 Setup and Installation

1. Clone or download the project repository.
2. Extract the project folder.
3. Open Apache NetBeans.
4. Select **File → Open Project** and choose the project folder containing `pom.xml`.
5. Open Oracle SQL Developer and connect to your Oracle database.
6. Open `database/library.sql` and execute the script using F5 to create the required tables and PL/SQL objects. Run this script only once when setting up a fresh database schema.
7. Open `src/main/java/com/library/DB.java` and configure your Oracle database URL, username, and password.
8. Configure Apache Tomcat 10.1 in NetBeans.
9. Right-click the project and select **Clean and Build**.
10. Right-click the project and select **Run**.
11. Open the application using the local URL provided by NetBeans.

## 🔒 Security Notes

- Keep Oracle database credentials private.
- Do not upload database passwords or sensitive configuration details to public repositories.
- Use sample student information for demonstrations and testing.
- Avoid uploading personal or confidential database records.
- This project is developed for academic and educational purposes.

## 🔮 Future Scope

- Add an admin login system with user authentication.
- Implement book search and filtering by title, author, and category.
- Add book update and editing functionality.
- Introduce student login and individual borrowing history.
- Generate downloadable library reports.
- Add email notifications for upcoming due dates and overdue books.
- Improve dashboard analytics with graphical representations.
- Implement role-based access for administrators and library members.

---

**Smart Library Management System — Simplifying library operations through Java, Oracle Database, and PL/SQL.**
