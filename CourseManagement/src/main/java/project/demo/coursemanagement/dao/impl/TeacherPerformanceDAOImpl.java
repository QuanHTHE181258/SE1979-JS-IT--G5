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
        String sql = "SELECT u.UserID, u.Username, u.Email, e.enrollment_date, e.progress_percentage, e.status, e.grade, e.completion_date, e.certificate_issued " +
                     "FROM enrollments e JOIN users u ON e.student_id = u.UserID WHERE e.course_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentPerformanceDTO dto = new StudentPerformanceDTO();
                dto.setUserId(rs.getInt("UserID"));
                dto.setUsername(rs.getString("Username"));
                dto.setEmail(rs.getString("Email"));
                dto.setEnrollmentDate(rs.getTimestamp("enrollment_date"));
                dto.setProgressPercentage(rs.getDouble("progress_percentage"));
                dto.setStatus(rs.getString("status"));
                dto.setGrade(rs.getObject("grade") != null ? rs.getDouble("grade") : null);
                dto.setCompletionDate(rs.getTimestamp("completion_date"));
                dto.setCertificateIssued(rs.getBoolean("certificate_issued"));
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
        try (Connection conn = DatabaseConnection.getConnection();
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