package dao;

import java.sql.Date;
import java.util.Calendar;
import model.Users;
import model.Reports;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

/**
 *
 * @author im_chur
 */
public class ReportsDAO {

    public static Reports sendReport(Reports report) {

        int rs = 0;
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                             insert into Reports (
                                    ReporterID,
                                    ViolationType,
                                    Description,
                                    PlateNumber,
                                    ImageURL,
                                    VideoURL,
                                    Location,
                                    ReportDate,
                                    Status
                                    )
                             values (?,?,?,?,?,?,?,?,?)
                             """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, report.getReporterID());
            statement.setString(2, report.getViolationType());
            statement.setString(3, report.getDescription());
            statement.setString(4, report.getPlateNumber());
            statement.setString(5, report.getImageURL());
            statement.setString(6, report.getVideoURL());
            statement.setString(7, report.getLocation());
            statement.setDate(8, new java.sql.Date(report.getReportDate().getTime()));
            statement.setString(9, report.getStatus());

            rs = statement.executeUpdate();
            System.out.println("Inserted Rows: " + rs);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return report;
        }
    }

    public static ArrayList<Reports> getAllReportsIfItIsPending() {
        DBContext db = DBContext.getInstance();
        ArrayList<Reports> reports = new ArrayList<Reports>();
        try {
            String sql = """
                         select * from Reports 
                         WHERE Status = 'Pending'
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Integer processedBy = rs.getObject("ProcessedBy") != null ? rs.getInt("ProcessedBy") : null;
                Date reportDate = (rs.getTimestamp("ReportDate") != null)
                        ? new Date(rs.getTimestamp("ReportDate").getTime())
                        : null;

                Reports report = new Reports(
                        rs.getInt("ReportID"),
                        rs.getInt("ReporterID"),
                        rs.getString("ViolationType"),
                        rs.getString("Description"),
                        rs.getString("PlateNumber"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        reportDate,
                        rs.getString("Status"),
                        processedBy
                );
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (reports == null) {
            return null;
        } else {
            return reports;
        }
    }

    public static Reports getReportByPlateNumberAndreportID(String plateNumber, String reportID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select * from Reports 
                         where PlateNumber = ? 
                         and ReportID = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            statement.setString(1, plateNumber);
            statement.setString(2, reportID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) { // Kiểm tra nếu có dữ liệu
                Integer processedBy = rs.getObject("ProcessedBy") != null ? rs.getInt("ProcessedBy") : null;
                Date reportDate = (rs.getTimestamp("ReportDate") != null)
                        ? new Date(rs.getTimestamp("ReportDate").getTime())
                        : null;

                return new Reports(
                        rs.getInt("ReportID"),
                        rs.getInt("ReporterID"),
                        rs.getString("ViolationType"),
                        rs.getString("Description"),
                        rs.getString("PlateNumber"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        reportDate,
                        rs.getString("Status"),
                        processedBy
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return null;

    }
    
    
    public static boolean updateAfterApprovedOrRejectReport( String status , int  reportID , int processBy ) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE Reports 
                         SET Status = ?  , ProcessedBy = ? 
                         WHERE ReportID = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, processBy); 
            statement.setInt(3, reportID);  
            rs = statement.executeUpdate() ; 
            
        } catch (SQLException e ) {
            e.printStackTrace();
            
        }
        
        if (rs == 0 ) {
            return false ; 
        } else {
            return true ; 
        }
        
    }
    
    public static ArrayList<Reports> getHistoryReports(int  userID) {
        DBContext db = DBContext.getInstance() ; 
        ArrayList<Reports> reports = new ArrayList<Reports>() ; 
        try {
            String sql = """
                         select * from Reports 
                         where ReporterID = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                Integer processedBy = rs.getObject("ProcessedBy") != null ? rs.getInt("ProcessedBy") : null;
                Date reportDate = (rs.getTimestamp("ReportDate") != null)
                        ? new Date(rs.getTimestamp("ReportDate").getTime())
                        : null;
                Reports report = new Reports(
                      rs.getInt("ReportID"),
                        rs.getInt("ReporterID"),
                        rs.getString("ViolationType"),
                        rs.getString("Description"),
                        rs.getString("PlateNumber"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        reportDate,
                        rs.getString("Status"),
                        processedBy
                
                
                ) ;
                reports.add(report) ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        
        if (reports == null){
            return null ; 
        } else {
            return reports ; 
        }
    }
    
    public static ArrayList<Reports> AdmingetAllReportsIfItNotPending() {
        DBContext db = DBContext.getInstance();
        ArrayList<Reports> reports = new ArrayList<Reports>();
        try {
            String sql = """
                         select * from Reports 
                         WHERE Status != 'Pending'
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Integer processedBy = rs.getObject("ProcessedBy") != null ? rs.getInt("ProcessedBy") : null;
                Date reportDate = (rs.getTimestamp("ReportDate") != null)
                        ? new Date(rs.getTimestamp("ReportDate").getTime())
                        : null;

                Reports report = new Reports(
                        rs.getInt("ReportID"),
                        rs.getInt("ReporterID"),
                        rs.getString("ViolationType"),
                        rs.getString("Description"),
                        rs.getString("PlateNumber"),
                        rs.getString("ImageURL"),
                        rs.getString("VideoURL"),
                        rs.getString("Location"),
                        reportDate,
                        rs.getString("Status"),
                        processedBy
                );
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (reports == null) {
            return null;
        } else {
            return reports;
        }
    }

}
