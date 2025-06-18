package dao;

/**
 *
 * @author im_chur
 */
import java.util.ArrayList;
import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dao.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UsersDAO {

    public static Users loginByEmailAndPassword(String email, String password) {
        DBContext db = DBContext.getInstance();
        ArrayList<Users> users = new ArrayList<Users>();

        try {
            String sql = """
                         select * from Users 
                         where Email = ? and  Password = ? ; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Users user = new Users(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getString("Phone"),
                        rs.getString("Address")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (users.isEmpty()) {
            return null;
        } else {
            return users.get(0);
        }
    }

    public static Users signupUser(Users user) {
        int rs = 0;
        DBContext db = DBContext.getInstance();

        if (db.getConnection() == null) {
            System.out.println("Lỗi: Không thể kết nối database!");
            return null;
        }

        String sql = """
                 INSERT INTO Users (FullName, Email, Password, Role, Phone, Address)
                 VALUES (?, ?, ?, ?, ?, ?)
                 """;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
               statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getPhone());
            statement.setString(6, user.getAddress());

            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            return null;
        }

        return rs > 0 ? user : null;
    }

    public static boolean forGotPassWord(String password, String email, String number) {
        int rs = 0;
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         update Users 
                         set Password = ? 
                         where Email = ? AND Phone = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, password);
            statement.setString(2, email);
            statement.setString(3, number);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isEmailExist(String email) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                             select UserID from Users 
                             where Email = ? 
                             """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public static boolean updateUserInfo(int userID, String newPhone, String newAddress) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                     UPDATE Users 
                     SET Phone = ?, Address = ? 
                     WHERE UserID = ?
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, newPhone);
            statement.setString(2, newAddress);
            statement.setInt(3, userID);

            rs = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public static ArrayList<Users> AdminGetAllUser() {
        ArrayList<Users> users = new ArrayList<Users>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         SELECT * FROM Users
                         where Role != 'TrafficPolice'
                         """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Users user = new Users(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getString("Phone"),
                        rs.getString("Address")
                );
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return users;
    }

    public static boolean deleteUserByUserID(int userID) {
        DBContext db = DBContext.getInstance();
        String[] sqls = {
            "DELETE FROM Notifications WHERE PlateNumber IN (SELECT PlateNumber FROM Vehicles WHERE OwnerID = ?);",
            "DELETE FROM Notifications WHERE UserID = ?;",
            "DELETE FROM Appeals WHERE ViolationID IN (SELECT ViolationID FROM Violations WHERE ViolatorID = ?);",
            "DELETE FROM Violations WHERE ReportID IN (SELECT ReportID FROM Reports WHERE ReporterID = ? OR ProcessedBy = ?);",
            "DELETE FROM Violations WHERE ViolatorID = ?;",
            "DELETE FROM Reports WHERE PlateNumber IN (SELECT PlateNumber FROM Vehicles WHERE OwnerID = ?);",
            "DELETE FROM Reports WHERE ReporterID = ? OR ProcessedBy = ?;",
            "DELETE FROM Vehicles WHERE OwnerID = ?;",
            "DELETE FROM Users WHERE UserID = ?;"
        };

        try (Connection conn = db.getConnection()) {
            conn.setAutoCommit(false);  

            for (String sql : sqls) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userID);
                    if (sql.contains("ProcessedBy = ?")) {
                        stmt.setInt(2, userID);
                    }
                    stmt.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection conn = db.getConnection()) {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;   
    }

    
    
    public static  boolean deleteUser(int userID) {
        String[] queries = {
            // 1. Xóa Notifications
            "DELETE FROM Notifications WHERE PlateNumber IN (SELECT PlateNumber FROM Vehicles WHERE OwnerID = ?)",
            "DELETE FROM Notifications WHERE UserID = ?",

            // 2. Xóa Appeals
            "DELETE FROM Appeals WHERE ViolationID IN (SELECT ViolationID FROM Violations WHERE ReportID IN " +
            "(SELECT ReportID FROM Reports WHERE ReporterID = ? OR ProcessedBy = ?))",
            "DELETE FROM Appeals WHERE ViolationID IN (SELECT ViolationID FROM Violations WHERE ViolatorID = ?)",

            // 3. Xóa Violations liên quan đến Reports
            "DELETE FROM Violations WHERE ReportID IN (SELECT ReportID FROM Reports WHERE ReporterID = ? OR ProcessedBy = ?)",

            // 4. Xóa Violations liên quan đến User
            "DELETE FROM Violations WHERE ViolatorID = ?",

            // 5. Xóa Reports trước Vehicles
            "DELETE FROM Reports WHERE PlateNumber IN (SELECT PlateNumber FROM Vehicles WHERE OwnerID = ?)",
            "DELETE FROM Reports WHERE ReporterID = ? OR ProcessedBy = ?",

            // 6. Xóa Vehicles sau khi xóa Reports
            "DELETE FROM Vehicles WHERE OwnerID = ?",

            // 7. Xóa User cuối cùng
            "DELETE FROM Users WHERE UserID = ?"
        };

        Connection conn = DBContext.getInstance().getConnection();
        if (conn == null) {
            System.out.println("Connection failed!");
            return false;
        }

        try {
            conn.setAutoCommit(false); // Bắt đầu transaction

            for (String query : queries) {
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, userID);
                    if (query.contains("? OR ProcessedBy = ?")) {
                        stmt.setInt(2, userID);
                    }
                    stmt.executeUpdate();
                }
            }

            conn.commit(); // Nếu mọi thứ đều ổn, commit transaction
            System.out.println("User and related data deleted successfully.");
            return true;
        } catch (SQLException e) {
            try {
                conn.rollback(); // Nếu có lỗi, rollback lại transaction
                System.err.println("Transaction rolled back due to an error: " + e.getMessage());
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                conn.setAutoCommit(true); // Đặt lại trạng thái auto-commit
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    
    public static Users getUserIfDontHaveVehicle(int userID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Users> users = new ArrayList<Users>();

        try {
            String sql = """
                         select * from Users 
                         where UserID = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Users user = new Users(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getString("Phone"),
                        rs.getString("Address")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (users.isEmpty()) {
            return null;
        } else {
            return users.get(0);
        }
    }
   

}
