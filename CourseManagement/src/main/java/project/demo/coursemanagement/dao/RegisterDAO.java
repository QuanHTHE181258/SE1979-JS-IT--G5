package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;

import java.util.List;

public interface RegisterDAO {

    boolean createUser(User user);

    boolean isUsernameExists(String username);

    boolean isEmailExists(String email);

    User findByUsername(String username);

    User findByEmail(String email);

    Role findRoleByName(String roleName);

    Role findRoleById(Integer roleId);

    List<Role> getAvailableRoles();

    boolean updateEmailVerificationStatus(Integer userId, boolean verified);

    boolean updateUserActiveStatus(Integer userId, boolean active);

    RegistrationStats getRegistrationStatistics();

    List<User> getRecentRegistrations(int limit);

    boolean isRegistrationEnabled();

    boolean logRegistrationAttempt(String username, String email, String ipAddress, boolean success, String message);

    boolean assignDefaultRoles(User user);

    boolean assignRole(User user, Integer roleId);

    // Inner class for registration statistics
    class RegistrationStats {
        private int totalUsers;
        private int todayRegistrations;
        private int weeklyRegistrations;
        private int monthlyRegistrations;
        private int activeUsers;
        private int pendingVerifications;

        public RegistrationStats() {}

        public RegistrationStats(int totalUsers, int todayRegistrations, int weeklyRegistrations,
                                 int monthlyRegistrations, int activeUsers, int pendingVerifications) {
            this.totalUsers = totalUsers;
            this.todayRegistrations = todayRegistrations;
            this.weeklyRegistrations = weeklyRegistrations;
            this.monthlyRegistrations = monthlyRegistrations;
            this.activeUsers = activeUsers;
            this.pendingVerifications = pendingVerifications;
        }

        // Getters and setters
        public int getTotalUsers() { return totalUsers; }
        public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }

        public int getTodayRegistrations() { return todayRegistrations; }
        public void setTodayRegistrations(int todayRegistrations) { this.todayRegistrations = todayRegistrations; }

        public int getWeeklyRegistrations() { return weeklyRegistrations; }
        public void setWeeklyRegistrations(int weeklyRegistrations) { this.weeklyRegistrations = weeklyRegistrations; }

        public int getMonthlyRegistrations() { return monthlyRegistrations; }
        public void setMonthlyRegistrations(int monthlyRegistrations) { this.monthlyRegistrations = monthlyRegistrations; }

        public int getActiveUsers() { return activeUsers; }
        public void setActiveUsers(int activeUsers) { this.activeUsers = activeUsers; }

        public int getPendingVerifications() { return pendingVerifications; }
        public void setPendingVerifications(int pendingVerifications) { this.pendingVerifications = pendingVerifications; }
    }
}
