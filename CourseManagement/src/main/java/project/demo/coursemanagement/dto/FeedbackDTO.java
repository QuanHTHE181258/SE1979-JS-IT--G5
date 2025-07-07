package project.demo.coursemanagement.dto;

import lombok.Data;

import java.time.Instant;

@Data
public class FeedbackDTO {
    private Integer feedbackID;
    private Integer rating;
    private String comment;
    private Instant createdAt;
    private String userName; // Giả sử lấy tên người dùng từ bảng User

    public FeedbackDTO() {
    }

    public Integer getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(Integer feedbackID) {
        this.feedbackID = feedbackID;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}