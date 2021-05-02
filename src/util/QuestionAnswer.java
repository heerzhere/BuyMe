package util;

public class QuestionAnswer {
    int questionId;
    String dateAsked;
    String dateAnswered;
    String topic;
    String question;
    String answer;
    int askedBy;
    int answeredBy;

    public QuestionAnswer() {
    }

    public String getDateAsked() {
        return dateAsked;
    }

    public void setDateAsked(String dateAsked) {
        this.dateAsked = dateAsked;
    }

    public String getDateAnswered() {
        return dateAnswered;
    }

    public void setDateAnswered(String dateAnswered) {
        this.dateAnswered = dateAnswered;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getAskedBy() {
        return askedBy;
    }

    public void setAskedBy(int askedBy) {
        this.askedBy = askedBy;
    }

    public int getAnsweredBy() {
        return answeredBy;
    }

    public void setAnsweredBy(int answeredBy) {
        this.answeredBy = answeredBy;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

}
