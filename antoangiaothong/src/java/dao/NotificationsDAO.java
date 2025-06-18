package dao;

import model.Notifications;

/**
 *
 * @author im_chur
 */
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class NotificationsDAO {

    public static boolean sendNotifications(Notifications notification) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
                        insert into  Notifications( UserID , Message , PlateNumber , SentDate  ,  IsRead  )
                        values (? , ? , ? , ? , ?  )
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            statement.setInt(1, notification.getUserID());
            statement.setString(2, notification.getMessage());
            statement.setString(3, notification.getPlateNumber());
            statement.setDate(4, new java.sql.Date(notification.getSentDate().getTime()));
            statement.setBoolean(5, notification.isIsRead());
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

    public static ArrayList<Notifications> receiveNotifications(int UserID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Notifications> notifications = new ArrayList<Notifications>();
        try {
            String sql = """
                        select* from Notifications 
                        where UserID = ? 
                        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, UserID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Notifications notification = new Notifications(
                        rs.getInt("NotificationID"),
                        rs.getInt("UserID"),
                        rs.getString("Message"),
                        rs.getString("PlateNumber"),
                        rs.getDate("SentDate"),
                        rs.getBoolean("IsRead")
                );
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (notifications == null) {
            return null;
        } else {
            return notifications;
        }
    }

    public static boolean markAsRead(int notificationID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Notifications SET IsRead = 1 WHERE NotificationID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, notificationID);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    

}
