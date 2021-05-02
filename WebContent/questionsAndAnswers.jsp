<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.QuestionAnswer" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<div class="marginLeft-Right">
    <% if ((session.getAttribute("user") == null)) { %>
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
    <%} else { %>
    <h2>Question and Answers</h2>
    <a href="question.jsp">
        <button class="loginbtn">Ask a New Question</button>
    </a>
    <input type="text" id="myInput" onkeyup="search()" placeholder="Search for a question">
    <ul id="myUL">
        <%
            Database db = new Database();
            ArrayList<QuestionAnswer> qAList = new ArrayList<>();
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                // Open DB Connection and get parameters
                conn = db.getConnection();
                st = conn.createStatement();

                // Create query for login validation
                rs = st.executeQuery("SELECT * FROM question;");
                if (!rs.next()) {
                    out.print("<h2>No questions asked yet</h2>");
                } else {
                    do {
                        QuestionAnswer qA = new QuestionAnswer();
                        int questionId = rs.getInt("question_id");
                        String topic = rs.getString("topic");
                        String question = rs.getString("question");
                        int askedBy = rs.getInt("asked_by");
                        String askDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("ask_date"));
                        String answer = rs.getString("answer");
                        int answeredBy = rs.getInt("answered_by");


                        qA.setQuestionId(questionId);
                        qA.setTopic(topic);
                        qA.setQuestion(question);
                        qA.setAskedBy(askedBy);
                        qA.setDateAsked(askDate);
                        qA.setAnswer(answer);
                        qA.setAnsweredBy(answeredBy);

                        if (answer == null) {
                            out.println("<li><a href=\"questionDetails.jsp?qid=" + questionId + "\">" + "Topic: " + topic + "<br>" + "Question: " + question + "<br>" + "Date Asked: " + askDate + "</a></li>");
                        } else {
                            String answerDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("answer_date"));
                            qA.setDateAnswered(answerDate);
                            out.println("<li><a href=\"questionDetails.jsp?qid=" + questionId + "\">" + "Topic: " + topic + "<br>" + "Question: " + question + "<br>" + "Date Asked: " + askDate + "<br> Question answered by customer representative on: " + answerDate + "</a></li>");
                        }
                        qAList.add(qA);
                    } while (rs.next());
                }
                session.setAttribute("questionAnswers", qAList);
            } catch (SQLException se) {
                out.print("<p>Error connecting to MYSQL server.</p>");
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close
                try {
                    if (rs != null) rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (st != null) st.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (conn != null) db.closeConnection(conn);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </ul>
    <% } %>
</div>

</body>

</html>