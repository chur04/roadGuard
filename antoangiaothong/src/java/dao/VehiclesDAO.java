package dao;

import model.Vehicles;
import model.Users;
import model.VehicleUser;
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.sql.Connection;

/**
 *
 * @author im_chur
 */
public class VehiclesDAO {

    public static VehicleUser getVehiclesByPlateNumber(String plateNumber) {
        ArrayList<VehicleUser> vehicleusers = new ArrayList<VehicleUser>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                             SELECT * FROM Vehicles JOIN Users 
                             ON Vehicles.OwnerID = Users.UserID WHERE Vehicles.PlateNumber = ?
                             """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, plateNumber);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                VehicleUser vehicleuser = new VehicleUser(
                        rs.getString("PlateNumber"),
                        rs.getString("Brand"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("UserID")
                );
                vehicleusers.add(vehicleuser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (vehicleusers == null) {
            return null;
        } else {
            return vehicleusers.get(0);
        }

    }

    public static List<VehicleUser> getInformationByUserID(int userID) {
        List<VehicleUser> vehicleUsers = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                     SELECT * FROM Vehicles JOIN Users 
                     ON Vehicles.OwnerID = Users.UserID WHERE Users.UserID = ?
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                VehicleUser vehicleUser = new VehicleUser(
                        rs.getString("PlateNumber"),
                        rs.getString("Brand"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("UserID")
                );
                vehicleUsers.add(vehicleUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicleUsers;
    }

    public static boolean hasRegisteredVehicle(int userID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM Vehicles WHERE OwnerID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean registerVehicles(Vehicles vehicle) {
        DBContext db = DBContext.getInstance();

        int rs = 0;
        try {
            String sql = """
                         insert into Vehicles(  PlateNumber , OwnerID , Brand  , Model , ManufactureYear)
                         values (?,?,?,?,?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, vehicle.getPlateNumber());
            statement.setInt(2, vehicle.getOwnerID());
            statement.setString(3, vehicle.getBrand());
            statement.setString(4, vehicle.getModel());
            statement.setInt(5, vehicle.getManufactureYear());
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
    
    public static ArrayList<Vehicles> AdmingetVehiclesByUserID(int userID){
        DBContext db = DBContext.getInstance() ;
        ArrayList<Vehicles> vehicles = new ArrayList<Vehicles>() ; 
        try {
            String sql = """
                         select * from Vehicles
                         where OwnerID = ? 
                         """ ;
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                Vehicles vehicle = new Vehicles(
                        rs.getInt("VehicleID"),
                        rs.getString("PlateNumber"),
                        rs.getInt("OwnerID"),
                        rs.getString("Brand"),
                        rs.getString("Model"),
                        rs.getInt("ManufactureYear")
                
                ) ; 
                vehicles.add(vehicle); 
                
            }
        } catch(SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        return vehicles ; 
    }
    
    public static boolean deleteVehicleData(String plateNumber) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getInstance().getConnection();
            if (conn == null) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return false;
            }

            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Xóa Notifications liên quan đến biển số
            ps = conn.prepareStatement("DELETE FROM Notifications WHERE PlateNumber = ?");
            ps.setString(1, plateNumber);
            ps.executeUpdate();

            // 2. Xóa Appeals liên quan đến biển số xe thông qua ViolationID
            ps = conn.prepareStatement("DELETE FROM Appeals WHERE ViolationID IN " +
                    "(SELECT ViolationID FROM Violations WHERE PlateNumber = ?)");
            ps.setString(1, plateNumber);
            ps.executeUpdate();

            // 3. Xóa Violations liên quan đến biển số xe
            ps = conn.prepareStatement("DELETE FROM Violations WHERE PlateNumber = ?");
            ps.setString(1, plateNumber);
            ps.executeUpdate();

            // 4. Xóa Reports liên quan đến biển số xe
            ps = conn.prepareStatement("DELETE FROM Reports WHERE PlateNumber = ?");
            ps.setString(1, plateNumber);
            ps.executeUpdate();

            // 5. Xóa Vehicle sau khi đã xóa hết thông tin liên quan
            ps = conn.prepareStatement("DELETE FROM Vehicles WHERE PlateNumber = ?");
            ps.setString(1, plateNumber);
            int rowsAffected = ps.executeUpdate(); // Kiểm tra có xóa được xe không

            conn.commit(); // Xác nhận transaction

            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng bị xóa

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Hoàn tác nếu có lỗi
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
