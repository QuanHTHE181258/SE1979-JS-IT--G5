package project.demo.coursemanagement.dto;

import project.demo.coursemanagement.entities.Lesson;

public class LessonStats {
    private Lesson lesson;
    private int order;
    private int totalQuizzes;
    private int totalMaterials;

    public LessonStats() {}
    public LessonStats(Lesson lesson, int order, int totalQuizzes, int totalMaterials) {
        this.lesson = lesson;
        this.order = order;
        this.totalQuizzes = totalQuizzes;
        this.totalMaterials = totalMaterials;
    }
    public Lesson getLesson() { return lesson; }
    public void setLesson(Lesson lesson) { this.lesson = lesson; }
    public int getOrder() { return order; }
    public void setOrder(int order) { this.order = order; }
    public int getTotalQuizzes() { return totalQuizzes; }
    public void setTotalQuizzes(int totalQuizzes) { this.totalQuizzes = totalQuizzes; }
    public int getTotalMaterials() { return totalMaterials; }
    public void setTotalMaterials(int totalMaterials) { this.totalMaterials = totalMaterials; }
}

