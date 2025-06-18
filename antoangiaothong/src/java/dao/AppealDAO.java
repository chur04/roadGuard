package dao;

/**
 *
 * @author im_chur
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Appeals;
import java.sql.ResultSet ; 

public class AppealDAO {

    public static boolean sendAppeal(Appeals appeal) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                     INSERT INTO Appeals (violationID, violatorID, appealText, appealDate, status, ImageURL, VideoURL) 
                     VALUES (?, ?, ?, GETDATE(), 'Pending', ?, ?)
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, appeal.getViolationID());
            statement.setInt(2, appeal.getViolatorID());
            statement.setString(3, appeal.getAppealText() != null ? appeal.getAppealText() : "");
            statement.setString(4, appeal.getImageURL() != null ? appeal.getImageURL() : "");
            statement.setString(5, appeal.getVideoURL() != null ? appeal.getVideoURL() : "");
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs > 0;
    }
    
    public static ArrayList<Appeals> getAllAppealIfItIsPending(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<Appeals> appeals = new ArrayList<Appeals>() ; 
        
        try {
            String sql = """
                         SELECT * FROM Appeals WHERE status = 'Pending'
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                Appeals appeal = new Appeals(
                        rs.getInt("AppealID"),
                rs.getInt("ViolationID"),
                rs.getInt("ViolatorID"),
                rs.getString("AppealText"),
                rs.getTimestamp("AppealDate"),
                rs.getString("Status"),
                rs.getString("AdminResponse"),
                rs.getTimestamp("ResponseDate"),
                rs.getString("ImageURL"),
                rs.getString("VideoURL")
                
                
                ) ; 
                appeals.add(appeal) ;
            }
        } catch(SQLException e ){
            e.printStackTrace();
            return null ; 
        }
        if (appeals == null ){
            return null; 
        } else {
            return appeals ; 
        }
    }
    
     public static boolean updateAppeal(int appealID, String status, String adminResponse, Date responseDate) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE Appeals SET Status = ?, AdminResponse = ?, ResponseDate = ? WHERE AppealID = ?
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, status);
            statement.setString(2, adminResponse);
            statement.setTimestamp(3, new java.sql.Timestamp(responseDate.getTime()));
            statement.setInt(4, appealID);
            rs = statement.executeUpdate() ;
        } catch (SQLException e ){
             e.printStackTrace();
        }
        
        if (rs == 0 ) {
            return false ; 
        } else {
            return true ; 
        }
    }
     
    public static ArrayList<Appeals> getAllAppealByUserID(int userID) {
    DBContext db = DBContext.getInstance(); 
    ArrayList<Appeals> appeals = new ArrayList<>(); 

    try {
        String sql = "SELECT * FROM Appeals WHERE ViolatorID = ?";
        PreparedStatement statement = db.getConnection().prepareStatement(sql);
        statement.setInt(1, userID);
        ResultSet rs = statement.executeQuery(); 

        while (rs.next()) {
            Appeals appeal = new Appeals(
                rs.getInt("AppealID"),
                rs.getInt("ViolationID"),
                rs.getInt("ViolatorID"),
                rs.getString("AppealText"),
                rs.getTimestamp("AppealDate"),
                rs.getString("Status"),
                rs.getString("AdminResponse"),
                rs.getTimestamp("ResponseDate"),
                rs.getString("ImageURL"),
                rs.getString("VideoURL")
            ); 
            appeals.add(appeal);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return appeals; 
}


}
