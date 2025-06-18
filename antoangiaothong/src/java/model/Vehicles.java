
package model;

/**
 *
 * @author im_chur
 */
public class Vehicles {
    private int VehicleID;
    private String PlateNumber;
    private int OwnerID;
    private String Brand;
    private String Model;
    private int ManufactureYear;

    public Vehicles() {
    }

    public Vehicles(int VehicleID, String PlateNumber, int OwnerID, String Brand, String Model, int ManufactureYear) {
        this.VehicleID = VehicleID;
        this.PlateNumber = PlateNumber;
        this.OwnerID = OwnerID;
        this.Brand = Brand;
        this.Model = Model;
        this.ManufactureYear = ManufactureYear;
    }

    public int getVehicleID() {
        return VehicleID;
    }

    public String getPlateNumber() {
        return PlateNumber;
    }

    public int getOwnerID() {
        return OwnerID;
    }

    public String getBrand() {
        return Brand;
    }

    public String getModel() {
        return Model;
    }

    public int getManufactureYear() {
        return ManufactureYear;
    }
}
