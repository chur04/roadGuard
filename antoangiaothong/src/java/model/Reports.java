
package model;

import java.util.Date;

/**
 *
 * @author im_chur
 */
public class Reports {
    private int ReportID;
    private int ReporterID;
    private String ViolationType;
    private String Description;
    private String PlateNumber;
    private String ImageURL;
    private String VideoURL;
    private String Location;
    private Date ReportDate;
    private String Status;
    private Integer ProcessedBy;
    
    public Reports() {
    }

    public Reports(int ReportID, int ReporterID, String ViolationType, String Description, String PlateNumber, String ImageURL, String VideoURL, String Location, Date ReportDate, String Status, Integer ProcessedBy) {
        this.ReportID = ReportID;
        this.ReporterID = ReporterID;
        this.ViolationType = ViolationType;
        this.Description = Description;
        this.PlateNumber = PlateNumber;
        this.ImageURL = ImageURL;
        this.VideoURL = VideoURL;
        this.Location = Location;
        this.ReportDate = ReportDate;
        this.Status = Status;
        this.ProcessedBy = ProcessedBy;
    }

    public int getReportID() {
        return ReportID;
    }

    public int getReporterID() {
        return ReporterID;
    }

    public String getViolationType() {
        return ViolationType;
    }

    public String getDescription() {
        return Description;
    }

    public String getPlateNumber() {
        return PlateNumber;
    }

    public String getImageURL() {
        return ImageURL;
    }

    public String getVideoURL() {
        return VideoURL;
    }

    public String getLocation() {
        return Location;
    }

    public Date getReportDate() {
        return ReportDate;
    }

    public String getStatus() {
        return Status;
    }

    public Integer getProcessedBy() {
        return ProcessedBy;
    }

    @Override
    public String toString() {
        return "Reports{" + "ReportID=" + ReportID + ", ReporterID=" + ReporterID + ", ViolationType=" + ViolationType + ", Description=" + Description + ", PlateNumber=" + PlateNumber + ", ImageURL=" + ImageURL + ", VideoURL=" + VideoURL + ", Location=" + Location + ", ReportDate=" + ReportDate + ", Status=" + Status + ", ProcessedBy=" + ProcessedBy + '}';
    }
    
}
