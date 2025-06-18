/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author im_chur
 */
public class VehicleUser {

    private String plateNumber;
    private String brand;
    private String model;
    private String fullName;

    private String email;
    private String phone;
    private int userID;

    public VehicleUser() {
    }

    public VehicleUser(String plateNumber, String brand, String model, String fullName, String email, String phone, int userID) {
        this.plateNumber = plateNumber;
        this.brand = brand;
        this.model = model;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public int getUserID() {
        return userID;
    }

}
