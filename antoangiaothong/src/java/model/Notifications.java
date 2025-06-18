
package model;

import java.util.Date;

/**
 *
 * @author im_chur
 */
public class Notifications {
    private int NotificationID;
    private int UserID;
    private String Message;
    private String PlateNumber;
    private Date SentDate;
    private boolean IsRead;

    public Notifications() {
    }

    public Notifications(int NotificationID, int UserID, String Message, String PlateNumber, Date SentDate, boolean IsRead) {
        this.NotificationID = NotificationID;
        this.UserID = UserID;
        this.Message = Message;
        this.PlateNumber = PlateNumber;
        this.SentDate = SentDate;
        this.IsRead = IsRead;
    }

    public int getNotificationID() {
        return NotificationID;
    }

    public int getUserID() {
        return UserID;
    }

    public String getMessage() {
        return Message;
    }

    public String getPlateNumber() {
        return PlateNumber;
    }

    public Date getSentDate() {
        return SentDate;
    }

    public boolean isIsRead() {
        return IsRead;
    }
}
