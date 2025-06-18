
package model;

import java.util.Date;

/**
 *
 * @author im_chur
 */
public class Violations {
    private int ViolationID;
    private int ReportID;
    private String PlateNumber;
    private Integer ViolatorID; 
    private double FineAmount;
    private Date FineDate;
    private boolean PaidStatus;

    public Violations() {
    }

    public Violations(int ViolationID, int ReportID, String PlateNumber, Integer ViolatorID, double FineAmount, Date FineDate, boolean PaidStatus) {
        this.ViolationID = ViolationID;
        this.ReportID = ReportID;
        this.PlateNumber = PlateNumber;
        this.ViolatorID = ViolatorID;
        this.FineAmount = FineAmount;
        this.FineDate = FineDate;
        this.PaidStatus = PaidStatus;
    }

    public int getViolationID() {
        return ViolationID;
    }

    public int getReportID() {
        return ReportID;
    }

    public String getPlateNumber() {
        return PlateNumber;
    }

    public Integer getViolatorID() {
        return ViolatorID;
    }

    public double getFineAmount() {
        return FineAmount;
    }

    public Date getFineDate() {
        return FineDate;
    }

    public boolean isPaidStatus() {
        return PaidStatus;
    }
}
