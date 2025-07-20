package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.QuizDAO;
import project.demo.coursemanagement.dao.impl.QuizDAOImpl;
import project.demo.coursemanagement.entities.*;
import java.util.List;

public class QuizService {
    private QuizDAO quizDAO = new QuizDAOImpl();

    public List<Quiz> getQuizzesByLessonId(int lessonId) {
        return quizDAO.getQuizzesByLessonId(lessonId);
    }

    public boolean createQuiz(int lessonId, String title, List<QuizQuestionData> questions) {
        try {
            // Create Quiz
            Quiz quiz = new Quiz();
            quiz.setTitle(title);

            Lesson lesson = new Lesson();
            lesson.setId(lessonId);
            quiz.setLessonID(lesson);

            // Add quiz first to get the generated ID
            if (!quizDAO.addQuiz(quiz)) {
                return false;
            }

            // Create Questions and Answers
            for (QuizQuestionData questionData : questions) {
                Question question = new Question();
                question.setQuiz(quiz);
                question.setQuestionText(questionData.getQuestionText());

                // Add question first to get the generated ID
                if (!quizDAO.addQuestion(question)) {
                    return false;
                }

                // Create Answers
                for (QuizAnswerData answerData : questionData.getAnswers()) {
                    Answer answer = new Answer();
                    answer.setQuestion(question);
                    answer.setAnswerText(answerData.getAnswerText());
                    answer.setIsCorrect(answerData.getIsCorrect());

                    if (!quizDAO.addAnswer(answer)) {
                        return false;
                    }
                }
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Inner classes for data transfer
    public static class QuizQuestionData {
        private String questionText;
        private List<QuizAnswerData> answers;

        public QuizQuestionData() {}

        public QuizQuestionData(String questionText, List<QuizAnswerData> answers) {
            this.questionText = questionText;
            this.answers = answers;
        }

        public String getQuestionText() {
            return questionText;
        }

        public void setQuestionText(String questionText) {
            this.questionText = questionText;
        }

        public List<QuizAnswerData> getAnswers() {
            return answers;
        }

        public void setAnswers(List<QuizAnswerData> answers) {
            this.answers = answers;
        }
    }

    public static class QuizAnswerData {
        private String answerText;
        private Boolean isCorrect;

        public QuizAnswerData() {}

        public QuizAnswerData(String answerText, Boolean isCorrect) {
            this.answerText = answerText;
            this.isCorrect = isCorrect;
        }

        public String getAnswerText() {
            return answerText;
        }

        public void setAnswerText(String answerText) {
            this.answerText = answerText;
        }

        public Boolean getIsCorrect() {
            return isCorrect;
        }

        public void setIsCorrect(Boolean isCorrect) {
            this.isCorrect = isCorrect;
        }
    }
}