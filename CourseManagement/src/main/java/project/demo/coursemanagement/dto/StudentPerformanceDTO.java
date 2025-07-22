package project.demo.coursemanagement.dto;

import java.util.Date;

public class StudentPerformanceDTO {
    private int userId;
    private String username;
    private String email;
    private Date enrollmentDate;
    private double progressPercentage;
    private String status;
    private Double grade;
    private Date completionDate;
    private boolean certificateIssued;

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Date getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(Date enrollmentDate) { this.enrollmentDate = enrollmentDate; }
    public double getProgressPercentage() { return progressPercentage; }
    public void setProgressPercentage(double progressPercentage) { this.progressPercentage = progressPercentage; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Double getGrade() { return grade; }
    public void setGrade(Double grade) { this.grade = grade; }
    public Date getCompletionDate() { return completionDate; }
    public void setCompletionDate(Date completionDate) { this.completionDate = completionDate; }
    public boolean isCertificateIssued() { return certificateIssued; }
    public void setCertificateIssued(boolean certificateIssued) { this.certificateIssued = certificateIssued; }
} 