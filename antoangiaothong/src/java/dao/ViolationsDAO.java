package dao;

/**
 *
 * @author im_chur
 */
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Violations;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ViolationUser;


public class ViolationsDAO {

    public static boolean sendViolation(Violations violation) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         insert into Violations (ReportID , PlateNumber , ViolatorID, FineAmount , FineDate , PaidStatus)
                         values (?,?,?,?,?,?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, violation.getReportID());
            statement.setString(2, violation.getPlateNumber());
            statement.setInt(3, violation.getViolatorID());
            statement.setDouble(4, violation.getFineAmount());
            statement.setDate(5, new java.sql.Date(violation.getFineDate().getTime())); // Chuyển từ java.util.Date sang java.sql.Date
            statement.setBoolean(6, violation.isPaidStatus()); // Nếu PaidStatus là boolean
            rs = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        }
        if (rs > 0) {
            return true;
        } else {
            return false;
        }
    }

    public static ArrayList<ViolationUser> getAllViolationByUserIDIfItPaid(int userID) {
        DBContext db = DBContext.getInstance();
        ArrayList<ViolationUser> violationusers = new ArrayList<ViolationUser>();
        try {
            String sql = """
                            WITH CTE AS (
                                SELECT 
                                    V.ViolationID , 
                                    V.ViolatorID ,
                                    R.ViolationType,  

                                    CAST(R.Description AS NVARCHAR(MAX)) AS ReportDescription , 
                                    CAST(R.ImageURL AS VARCHAR(MAX)) AS ImageURL,  
                                    CAST(R.VideoURL AS VARCHAR(MAX)) AS VideoURL,  
                                    R.Location,  
                                    R.ReportDate,  
                                    V.FineAmount,  
                                    V.FineDate,  
                                    V.PaidStatus,
                                    R.PlateNumber,
                                    ROW_NUMBER() OVER (PARTITION BY V.ViolationID ORDER BY R.ReportDate DESC) AS RowNum
                                FROM Reports R  
                                JOIN Violations V  
                                ON R.ReportID = V.ReportID
                                WHERE V.ViolatorID = ?  and V.PaidStatus = 1 

                            )
                            SELECT * FROM CTE WHERE RowNum = 1;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ViolationUser violationuser = new ViolationUser(
                        rs.getInt("ViolationID"),
                        rs.getInt("ViolatorID"),
                        rs.getString("ViolationType"),
                        rs.getString("ReportDescription"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        rs.getDate("ReportDate"),
                        rs.getDouble("FineAmount"),
                        rs.getDate("FineDate"),
                        rs.getBoolean("PaidStatus"),
                        rs.getString("PlateNumber")
                );
                violationusers.add(violationuser);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (violationusers == null) {
            return null;
        } else {
            return violationusers;
        }
    }

    public static ArrayList<ViolationUser> getAllViolationByUserIDIfItNOTPAID(int userID) {
        DBContext db = DBContext.getInstance();
        ArrayList<ViolationUser> violationusers = new ArrayList<ViolationUser>();
        try {
            String sql = """
                            WITH CTE AS (
                                SELECT 
                                    V.ViolationID , 
                                    V.ViolatorID ,
                                    R.ViolationType,  

                                    CAST(R.Description AS NVARCHAR(MAX)) AS ReportDescription ,  
                                    CAST(R.ImageURL AS VARCHAR(MAX)) AS ImageURL,  
                                    CAST(R.VideoURL AS VARCHAR(MAX)) AS VideoURL,  
                                    R.Location,  
                                    R.ReportDate,  
                                    V.FineAmount,  
                                    V.FineDate,  
                                    V.PaidStatus,
                                    R.PlateNumber,
                                    ROW_NUMBER() OVER (PARTITION BY V.ViolationID ORDER BY R.ReportDate DESC) AS RowNum
                                FROM Reports R  
                                JOIN Violations V  
                                ON R.ReportID = V.ReportID
                                WHERE V.ViolatorID = ?  and V.PaidStatus = 0 

                            )
                            SELECT * FROM CTE WHERE RowNum = 1;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ViolationUser violationuser = new ViolationUser(
                        rs.getInt("ViolationID"),
                        rs.getInt("ViolatorID"),
                        rs.getString("ViolationType"),
                        rs.getString("ReportDescription"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        rs.getDate("ReportDate"),
                        rs.getDouble("FineAmount"),
                        rs.getDate("FineDate"),
                        rs.getBoolean("PaidStatus"),
                        rs.getString("PlateNumber")
                );
                violationusers.add(violationuser);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (violationusers == null) {
            return null;
        } else {
            return violationusers;
        }
    }

    public static ArrayList<ViolationUser> getViolationHaveAppealByViolationsID(int violationID) {
        DBContext db = DBContext.getInstance();
        ArrayList<ViolationUser> violationusers = new ArrayList<ViolationUser>();
        try {
            String sql = """
                            WITH CTE AS (
                                SELECT 
                                    V.ViolationID , 
                                    V.ViolatorID ,
                                    R.ViolationType,  

                                    CAST(R.Description AS NVARCHAR(MAX)) AS ReportDescription ,  
                                    CAST(R.ImageURL AS VARCHAR(MAX)) AS ImageURL,  
                                    CAST(R.VideoURL AS VARCHAR(MAX)) AS VideoURL,  
                                    R.Location,  
                                    R.ReportDate,  
                                    V.FineAmount,  
                                    V.FineDate,  
                                    V.PaidStatus,
                                    R.PlateNumber,
                                    ROW_NUMBER() OVER (PARTITION BY V.ViolationID ORDER BY R.ReportDate DESC) AS RowNum
                                FROM Reports R  
                                JOIN Violations V  
                                ON R.ReportID = V.ReportID
                                WHERE V.ViolationID = ? 

                            )
                            SELECT * FROM CTE WHERE RowNum = 1;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, violationID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ViolationUser violationuser = new ViolationUser(
                        rs.getInt("ViolationID"),
                        rs.getInt("ViolatorID"),
                        rs.getString("ViolationType"),
                        rs.getString("ReportDescription"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        rs.getDate("ReportDate"),
                        rs.getDouble("FineAmount"),
                        rs.getDate("FineDate"),
                        rs.getBoolean("PaidStatus"),
                        rs.getString("PlateNumber")
                );
                violationusers.add(violationuser);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (violationusers == null) {
            return null;
        } else {
            return violationusers;
        }
    }

    public static boolean processPayment(int violationID) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = "UPDATE Violations SET PaidStatus = 1 WHERE ViolationID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            statement.setInt(1, violationID);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs > 0;
    }

    public static boolean setStatusfor_1(int violationID) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Violations SET PaidStatus = -1 WHERE ViolationID = ?";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, violationID);
            int rs = statement.executeUpdate();
            return rs > 0; 
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật trạng thái vi phạm: " + e.getMessage());
            return false;
        }
    }
    
    public static ArrayList<ViolationUser> AdmingetAllViolationByUserIDIfItNOTPAID() {
        DBContext db = DBContext.getInstance();
        ArrayList<ViolationUser> violationusers = new ArrayList<ViolationUser>();
        try {
            String sql = """
                            WITH CTE AS (
                                SELECT 
                                    V.ViolationID , 
                                    V.ViolatorID ,
                                    R.ViolationType,  

                                    CAST(R.Description AS NVARCHAR(MAX)) AS ReportDescription ,  
                                    CAST(R.ImageURL AS VARCHAR(MAX)) AS ImageURL,  
                                    CAST(R.VideoURL AS VARCHAR(MAX)) AS VideoURL,  
                                    R.Location,  
                                    R.ReportDate,  
                                    V.FineAmount,  
                                    V.FineDate,  
                                    V.PaidStatus,
                                    R.PlateNumber,
                                    ROW_NUMBER() OVER (PARTITION BY V.ViolationID ORDER BY R.ReportDate DESC) AS RowNum
                                FROM Reports R  
                                JOIN Violations V  
                                ON R.ReportID = V.ReportID
                                WHERE  V.PaidStatus = 0 

                            )
                            SELECT * FROM CTE WHERE RowNum = 1;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ViolationUser violationuser = new ViolationUser(
                        rs.getInt("ViolationID"),
                        rs.getInt("ViolatorID"),
                        rs.getString("ViolationType"),
                        rs.getString("ReportDescription"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        rs.getDate("ReportDate"),
                        rs.getDouble("FineAmount"),
                        rs.getDate("FineDate"),
                        rs.getBoolean("PaidStatus"),
                        rs.getString("PlateNumber")
                );
                violationusers.add(violationuser);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (violationusers == null) {
            return null;
        } else {
            return violationusers;
        }
    }
    
    
    public static ArrayList<ViolationUser> AdmingetAllViolationByUserIDIfItPAID() {
        DBContext db = DBContext.getInstance();
        ArrayList<ViolationUser> violationusers = new ArrayList<ViolationUser>();
        try {
            String sql = """
                            WITH CTE AS (
                                SELECT 
                                    V.ViolationID , 
                                    V.ViolatorID ,
                                    R.ViolationType,  

                                    CAST(R.Description AS NVARCHAR(MAX)) AS ReportDescription ,  
                                    CAST(R.ImageURL AS VARCHAR(MAX)) AS ImageURL,  
                                    CAST(R.VideoURL AS VARCHAR(MAX)) AS VideoURL,  
                                    R.Location,  
                                    R.ReportDate,  
                                    V.FineAmount,  
                                    V.FineDate,  
                                    V.PaidStatus,
                                    R.PlateNumber,
                                    ROW_NUMBER() OVER (PARTITION BY V.ViolationID ORDER BY R.ReportDate DESC) AS RowNum
                                FROM Reports R  
                                JOIN Violations V  
                                ON R.ReportID = V.ReportID
                                WHERE  V.PaidStatus = 1 

                            )
                            SELECT * FROM CTE WHERE RowNum = 1;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ViolationUser violationuser = new ViolationUser(
                        rs.getInt("ViolationID"),
                        rs.getInt("ViolatorID"),
                        rs.getString("ViolationType"),
                        rs.getString("ReportDescription"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        rs.getDate("ReportDate"),
                        rs.getDouble("FineAmount"),
                        rs.getDate("FineDate"),
                        rs.getBoolean("PaidStatus"),
                        rs.getString("PlateNumber")
                );
                violationusers.add(violationuser);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (violationusers == null) {
            return null;
        } else {
            return violationusers;
        }
    }
    
    public static int getFineAmoutFromViolations(int violationID) {
        DBContext db = DBContext.getInstance() ; 
        int FineAmount = -1 ;
        try {
            String sql = """
                         select FineAmount from Violations 
                         where ViolationID = ? ; 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, violationID);
            ResultSet rs  = statement.executeQuery() ; 
            while(rs.next()){
                FineAmount = rs.getInt("FineAmount") ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace();
            
        }
        return FineAmount ; 
        
    }

}
