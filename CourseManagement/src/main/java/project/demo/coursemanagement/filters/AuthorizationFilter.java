package project.demo.coursemanagement.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;

@WebFilter(urlPatterns = {
    "/admin/*",
    "/teacher/*"
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
        
        // Prevent browser caching for dynamic admin pages
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
        httpResponse.setDateHeader("Expires", 0); // Proxies

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        if (!SessionUtil.isUserLoggedIn(httpRequest)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        // Check authorization based on URL pattern
        if (requestURI.startsWith(contextPath + "/admin")) { // Check for /admin as well
            boolean isAdmin = SessionUtil.isAdmin(httpRequest);
            boolean isUserManager = SessionUtil.isUserManager(httpRequest);

            if (!isAdmin && !isUserManager) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Admin or User Manager role required.");
                return;
            }
        } else if (requestURI.startsWith(contextPath + "/teacher/")) {
            if (!SessionUtil.isTeacher(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Teacher role required.");
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