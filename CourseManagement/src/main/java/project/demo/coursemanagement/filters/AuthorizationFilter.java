package project.demo.coursemanagement.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;

@WebFilter(urlPatterns = {
    "/admin/*",
    "/teacher/*", 
    "/course-manager/*",
    "/user-manager/*"
})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        if (!SessionUtil.isUserLoggedIn(httpRequest)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        // Check authorization based on URL pattern
        if (requestURI.startsWith(contextPath + "/admin/")) {
            if (!SessionUtil.isAdmin(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Admin role required.");
                return;
            }
        } else if (requestURI.startsWith(contextPath + "/teacher/")) {
            if (!SessionUtil.isTeacher(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Teacher role required.");
                return;
            }
        } else if (requestURI.startsWith(contextPath + "/course-manager/")) {
            if (!SessionUtil.isCourseManager(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Course Manager role required.");
                return;
            }
        } else if (requestURI.startsWith(contextPath + "/user-manager/")) {
            if (!SessionUtil.isUserManager(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. User Manager role required.");
                return;
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
} 