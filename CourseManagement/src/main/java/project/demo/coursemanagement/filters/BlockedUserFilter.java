package project.demo.coursemanagement.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.entities.User;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class BlockedUserFilter implements Filter {
    // Các URL cho phép truy cập kể cả khi chưa đăng nhập
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/login", "/logout", "/", "/home", "/register", "/course",
            "/assets/", "/css/", "/js/", "/images/", "/img/",
            "/WEB-INF/views/home.jsp",
            "/WEB-INF/views/login_register/",
            "/WEB-INF/layout/header.jsp"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[FILTER INIT] BlockedUserFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Cho phép truy cập URL public
        for (String allowed : PUBLIC_PATHS) {
            if (path.startsWith(allowed)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Kiểm tra user trong session
        HttpSession session = req.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Nếu chưa đăng nhập, redirect về login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Nếu user bị blocked, redirect về login với thông báo
        if (user.isBlocked()) {
            resp.sendRedirect(req.getContextPath() + "/login?blocked=true");
            return;
        }

        // Cho phép truy cập
        chain.doFilter(request, response);
    }
}
