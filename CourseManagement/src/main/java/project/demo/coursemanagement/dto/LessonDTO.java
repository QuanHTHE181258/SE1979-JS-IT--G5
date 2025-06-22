package project.demo.coursemanagement.dto;

import lombok.Data;

import java.time.Instant;

@Data
public class LessonDTO {
    private Integer lessonID;
    private String title;
    private String content;
    private String status;
    private Boolean isFreePreview;
    private Instant createdAt;

    public LessonDTO() {
    }

    public Integer getLessonID() {
        return lessonID;
    }

    public void setLessonID(Integer lessonID) {
        this.lessonID = lessonID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getFreePreview() {
        return isFreePreview;
    }

    public void setFreePreview(Boolean freePreview) {
        isFreePreview = freePreview;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }
}
