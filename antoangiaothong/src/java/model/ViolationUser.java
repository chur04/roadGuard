
package model;

import java.util.Date;

/**
 *
 * @author im_chur
 */
public class ViolationUser {
    private int violationID ; 
    private int violatorID ; 
    private String violationType;
    private String description;
    private String imageURL;
    private String videoURL;
    private String location;
    private Date reportDate;
    private double fineAmount;
    private Date fineDate;
    private boolean paidStatus;
    private String plateNumber ; 
    
    
    public ViolationUser() {
    }

    public ViolationUser(int violationID, int violatorID, String violationType, String description, String imageURL, String videoURL, String location, Date reportDate, double fineAmount, Date fineDate, boolean paidStatus, String plateNumber) {
        this.violationID = violationID;
        this.violatorID = violatorID;
        this.violationType = violationType;
        this.description = description;
        this.imageURL = imageURL;
        this.videoURL = videoURL;
        this.location = location;
        this.reportDate = reportDate;
        this.fineAmount = fineAmount;
        this.fineDate = fineDate;
        this.paidStatus = paidStatus;
        this.plateNumber = plateNumber;
    }

    

    public int getViolatorID() {
        return violatorID;
    }

    public String getViolationType() {
        return violationType;
    }

    public String getDescription() {
        return description;
    }

    public String getImageURL() {
        return imageURL;
    }

    public String getVideoURL() {
        return videoURL;
    }

    public String getLocation() {
        return location;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public double getFineAmount() {
        return fineAmount;
    }

    public Date getFineDate() {
        return fineDate;
    }

    public boolean isPaidStatus() {
        return paidStatus;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public int getViolationID() {
        return violationID;
    }
    
    

     
    
    
}
