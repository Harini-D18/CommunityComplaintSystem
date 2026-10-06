<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>

<head>

<title>Feedback</title>

<link rel="stylesheet"
href="css/style.css">

</head>

<body>

<nav>

<h2>🏘️ CivicConnect</h2>

<a href="citizen-dashboard.jsp">
Dashboard
</a>

</nav>

<div class="form-container">

<h2>Complaint Feedback</h2>

<form method="post">

<input type="text"
name="complaint_id"
placeholder="Complaint ID"
required>

<select name="rating">

<option value="5">⭐⭐⭐⭐⭐ Excellent</option>

<option value="4">⭐⭐⭐⭐ Good</option>

<option value="3">⭐⭐⭐ Average</option>

<option value="2">⭐⭐ Poor</option>

<option value="1">⭐ Very Poor</option>

</select>

<textarea name="comments"
placeholder="Your comments"
rows="5"></textarea>

<button type="submit">
Submit Feedback
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String cid =
request.getParameter("complaint_id");

int rating =
Integer.parseInt(
request.getParameter("rating")
);

String comments =
request.getParameter("comments");

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
"INSERT INTO feedback " +
"(complaint_id,rating,comments) " +
"VALUES(?,?,?)"
);

ps.setString(1,cid);

ps.setInt(2,rating);

ps.setString(3,comments);

ps.executeUpdate();

out.println(
"<p style='color:green'>" +
"Thank you for your feedback! ⭐" +
"</p>"
);

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

</div>

</body>

</html>