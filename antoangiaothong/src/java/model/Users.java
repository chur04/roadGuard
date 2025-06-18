/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author im_chur
 */
public class Users {
    private int UserID;
    private String FullName;
    private String Email;
    private String Password;
    private String Role;
    private String Phone;
    private String Address;

    public Users() {
    }

    public Users(int UserID, String FullName, String Email, String Password, String Role, String Phone, String Address) {
        this.UserID = UserID;
        this.FullName = FullName;
        this.Email = Email;
        this.Password = Password;
        this.Role = Role;
        this.Phone = Phone;
        this.Address = Address;
    }

    public int getUserID() {
        return UserID;
    }

    public String getFullName() {
        return FullName;
    }

    public String getEmail() {
        return Email;
    }

    public String getPassword() {
        return Password;
    }

    public String getRole() {
        return Role;
    }

    public String getPhone() {
        return Phone;
    }

    public String getAddress() {
        return Address;
    }

    @Override
    public String toString() {
        return "Users{" + "UserID=" + UserID + ", FullName=" + FullName + ", Email=" + Email + ", Password=" + Password + ", Role=" + Role + ", Phone=" + Phone + ", Address=" + Address + '}';
    }
}
