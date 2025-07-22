package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.TeacherPerformanceDAO;
import project.demo.coursemanagement.dto.StudentPerformanceDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class TeacherPerformanceDAOImpl implements TeacherPerformanceDAO {
    @Override
    public List<StudentPerformanceDTO> getStudentPerformanceByCourse(int courseId) {
        List<StudentPerformanceDTO> list = new ArrayList<>();
        String sql = "SELECT u.UserID, u.Username, u.Email, cp.LastAccessed, cp.ProgressPercent, " +
                     "cp.CompletedLessons, cp.TotalLessons " +
                     "FROM course_progress cp JOIN users u ON cp.UserID = u.UserID " +
                     "WHERE cp.CourseID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentPerformanceDTO dto = new StudentPerformanceDTO();
                dto.setUserId(rs.getInt("UserID"));
                dto.setUsername(rs.getString("Username"));
                dto.setEmail(rs.getString("Email"));
                dto.setEnrollmentDate(rs.getTimestamp("LastAccessed"));
                dto.setProgressPercentage(rs.getDouble("ProgressPercent"));
                dto.setStatus(rs.getInt("CompletedLessons") + "/" + rs.getInt("TotalLessons"));
                dto.setGrade(null); // No grade field in course_progress
                dto.setCompletionDate(null); // No completion date field
                dto.setCertificateIssued(false); // No certificate field
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Integer> getCoursesByTeacher(int teacherId) {
        List<Integer> courseIds = new ArrayList<>();
        String sql = "SELECT CourseID FROM courses WHERE InstructorID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courseIds.add(rs.getInt("CourseID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courseIds;
    }
} 