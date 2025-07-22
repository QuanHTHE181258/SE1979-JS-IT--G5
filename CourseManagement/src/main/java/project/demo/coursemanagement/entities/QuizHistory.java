/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package project.demo.coursemanagement.entities;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Builder
@Getter
@Setter
public class QuizHistory {
    private int attemptId;
    private int userId;
    private int quizId;
    private String quizTitle;
    private int lessonId;
    private String lessonTitle;
    private String  attemptDate;
    private double score;
    private int completionTimeMinutes;

    public QuizHistory() {
    }

    public QuizHistory(int attemptId, int userId, int quizId, String quizTitle, int lessonId, String lessonTitle, String attemptDate, double score, int completionTimeMinutes) {
        this.attemptId = attemptId;
        this.userId = userId;
        this.quizId = quizId;
        this.quizTitle = quizTitle;
        this.lessonId = lessonId;
        this.lessonTitle = lessonTitle;
        this.attemptDate = attemptDate;
        this.score = score;
        this.completionTimeMinutes = completionTimeMinutes;
    }

    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getLessonTitle() {
        return lessonTitle;
    }

    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }

    public String getAttemptDate() {
        return attemptDate;
    }

    public void setAttemptDate(String attemptDate) {
        this.attemptDate = attemptDate;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public int getCompletionTimeMinutes() {
        return completionTimeMinutes;
    }

    public void setCompletionTimeMinutes(int completionTimeMinutes) {
        this.completionTimeMinutes = completionTimeMinutes;
    }

    @Override
    public String toString() {
        return "QuizHistory{" + "attemptId=" + attemptId + ", userId=" + userId + ", quizId=" + quizId + ", quizTitle=" + quizTitle + ", lessonId=" + lessonId + ", lessonTitle=" + lessonTitle + ", attemptDate=" + attemptDate + ", score=" + score + ", completionTimeMinutes=" + completionTimeMinutes + '}';
    }

    
}

