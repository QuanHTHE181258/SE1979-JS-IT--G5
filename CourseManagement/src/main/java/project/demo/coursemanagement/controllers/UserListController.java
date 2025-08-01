package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.annotations.RequireRole;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserListController", urlPatterns = {"/admin/user-management/list"})
@RequireRole({"ADMIN", "USER_MANAGER"})
public class UserListController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String roleId = SessionUtil.getUserRole(request);

        if ("4".equals(roleId) || "5".equals(roleId)) {
            List<User> students = userService.getUsers(null, "STUDENT", 1);
            List<User> teachers = userService.getUsers(null, "TEACHER", 1);
            List<User> courseManagers = userService.getUsers(null, "Course Manager", 1);
            List<User> userManagers = userService.getUsers(null, "USER_MANAGER", 1);

            long blockedStudents = students.stream().filter(User::isBlocked).count();
            long blockedTeachers = teachers.stream().filter(User::isBlocked).count();
            long blockedManagers = courseManagers.stream().filter(User::isBlocked).count();
            long blockedUserManagers = userManagers.stream().filter(User::isBlocked).count();

            System.out.println("[USER LIST] Students: total=" + students.size() + ", blocked=" + blockedStudents);
            System.out.println("[USER LIST] Teachers: total=" + teachers.size() + ", blocked=" + blockedTeachers);
            System.out.println("[USER LIST] CourseManagers: total=" + courseManagers.size() + ", blocked=" + blockedManagers);
            System.out.println("[USER LIST] UserManagers: total=" + userManagers.size() + ", blocked=" + blockedUserManagers);

            request.setAttribute("students", students);
            request.setAttribute("teachers", teachers);
            request.setAttribute("courseManagers", courseManagers);
            request.setAttribute("userManagers", userManagers);

            // Set isAdmin flag for UI control
            request.setAttribute("isAdmin", "5".equals(roleId));

            request.getRequestDispatcher("/WEB-INF/views/user_list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userId = request.getParameter("id");

        if (userId != null && (action != null && (action.equals("block") || action.equals("unblock")))) {
            try {
                int id = Integer.parseInt(userId);
                boolean success;

                if ("block".equals(action)) {
                    success = userService.blockUser(id);
                } else {
                    success = userService.unblockUser(id);
                }

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/user-management/list?message=User " + action + "ed successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/user-management/list?error=" + action + " user failed");
                }
            } catch (Exception e) {
                System.err.println("Error in " + action + " user: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin/user-management/list?error=" + action + " user error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/user-management/list?error=Invalid request");
        }
    }
}
