/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package project.demo.coursemanagement.entities;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Lesson_Completion {
    private int completionId;
    private int userId;
    private int lessonId;
    private Date completedAt;

    public Lesson_Completion() {
    }

    public Lesson_Completion(int completionId, int userId, int lessonId, Date completedAt) {
        this.completionId = completionId;
        this.userId = userId;
        this.lessonId = lessonId;
        this.completedAt = completedAt;
    }

    public int getCompletionId() {
        return completionId;
    }

    public void setCompletionId(int completionId) {
        this.completionId = completionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public Date getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Date completedAt) {
        this.completedAt = completedAt;
    }

    @Override
    public String toString() {
        return "Lesson_Completion{" + "completionId=" + completionId + ", userId=" + userId + ", lessonId=" + lessonId + ", completedAt=" + completedAt + '}';
    }
    
    
}
