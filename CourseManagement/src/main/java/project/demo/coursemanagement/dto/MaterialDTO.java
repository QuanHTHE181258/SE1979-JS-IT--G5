package project.demo.coursemanagement.dto;

public class MaterialDTO {
    private Integer id;
    private Integer lessonId;
    private String title;
    private String fileURL;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getLessonId() { return lessonId; }
    public void setLessonId(Integer lessonId) { this.lessonId = lessonId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getFileURL() { return fileURL; }
    public void setFileURL(String fileURL) { this.fileURL = fileURL; }
} 