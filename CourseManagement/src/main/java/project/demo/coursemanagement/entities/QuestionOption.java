/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package project.demo.coursemanagement.entities;

/**
 * Class nay de view quiz result for student
 * @author ASUS
 */
public class QuestionOption {
    private int questionID;
    private String questionText;
    private int optionID;
    private String optionText;
    private boolean isCorrect;
    private Integer userSelectedOptionID;

    public QuestionOption(int questionID, String questionText, int optionID, String optionText, boolean isCorrect, Integer userSelectedOptionID) {
        this.questionID = questionID;
        this.questionText = questionText;
        this.optionID = optionID;
        this.optionText = optionText;
        this.isCorrect = isCorrect;
        this.userSelectedOptionID = userSelectedOptionID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public int getOptionID() {
        return optionID;
    }

    public void setOptionID(int optionID) {
        this.optionID = optionID;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Integer getUserSelectedOptionID() {
        return userSelectedOptionID;
    }

    public void setUserSelectedOptionID(Integer userSelectedOptionID) {
        this.userSelectedOptionID = userSelectedOptionID;
    }

    @Override
    public String toString() {
        return "QuestionOption{" + "questionID=" + questionID + ", questionText=" + questionText + ", optionID=" + optionID + ", optionText=" + optionText + ", isCorrect=" + isCorrect + ", userSelectedOptionID=" + userSelectedOptionID + '}';
    }

    
}

