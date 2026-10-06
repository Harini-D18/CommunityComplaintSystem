<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>

<head>

<title>Citizen Login</title>

<link rel="stylesheet"
      href="css/style.css">

</head>

<body>

<nav>

<h2>🏘️ CivicConnect</h2>

<a href="index.html">Home</a>

</nav>

<div class="form-container">

<h2>Citizen Login</h2>

<form method="post">

<input type="email"
       name="email"
       placeholder="Email"
       required>

<input type="password"
       name="password"
       placeholder="Password"
       required>

<button type="submit">
Login
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String email =
request.getParameter("email");

String password =
request.getParameter("password");

try {

Class.forName(
"com.mysql.cj.jdbc.Driver"
);

Connection con =
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/community_complaints",
"root",
"welcome"
);

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM users WHERE email=? AND password=? AND role='citizen'"
);

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs =
ps.executeQuery();

if(rs.next()) {

session.setAttribute(
"user_id",
rs.getInt("id")
);

session.setAttribute(
"user_name",
rs.getString("name")
);

response.sendRedirect(
"citizen-dashboard.jsp"
);

}
else {

out.println(
"<p style='color:red'>Invalid login details</p>"
);

}

con.close();

}
catch(Exception e) {

out.println(
"<p style='color:red'>"
+e.getMessage()+
"</p>"
);

}

}

%>

<p>
New user?
<a href="register.jsp">Register</a>
</p>

</div>

</body>
</html>