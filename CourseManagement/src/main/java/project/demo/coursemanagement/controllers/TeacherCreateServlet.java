package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "TeacherCreateServlet", urlPatterns = {"/admin/teachers/create"})
public class TeacherCreateServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Trả về form tạo giáo viên
        request.getRequestDispatcher("/WEB-INF/views/create_teacher.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // TODO: mã hóa
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String dateOfBirth = request.getParameter("dateOfBirth");

            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPasswordHash(password); // TODO: mã hóa bằng BCrypt hoặc tương tự
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setPhoneNumber(phone);
            user.setDateOfBirth(LocalDate.parse(dateOfBirth)); // yyyy-MM-dd
            user.setAvatarUrl(null); // hoặc ảnh mặc định

            boolean created = userDAO.createTeacher(user);

            if (created) {
                request.setAttribute("message", "Tạo giáo viên thành công!");
            } else {
                request.setAttribute("error", "Tạo giáo viên thất bại!");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/create_teacher.jsp").forward(request, response);
    }
}
