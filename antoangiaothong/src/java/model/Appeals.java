/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author im_chur
 */
public class Appeals {

    private int appealID;
    private int violationID;
    private int violatorID;
    private String appealText;
    private Date appealDate;
    private String status;  // "Pending", "Approved", "Rejected"
    private String adminResponse;
    private Date responseDate;
    private String imageURL;
    private String videoURL;

    public Appeals() {
    }

    public Appeals(int appealID, int violationID, int violatorID, String appealText, Date appealDate,
            String status, String adminResponse, Date responseDate, String imageURL, String videoURL) {
        this.appealID = appealID;
        this.violationID = violationID;
        this.violatorID = violatorID;
        this.appealText = appealText;
        this.appealDate = (appealDate != null) ? appealDate : new Date(); // Nếu null, lấy ngày hiện tại
        this.status = (status != null) ? status : "Pending";  // Giá trị mặc định
        this.adminResponse = (adminResponse != null) ? adminResponse : "";
        this.responseDate = responseDate;
        this.imageURL = (imageURL != null) ? imageURL : "";
        this.videoURL = (videoURL != null) ? videoURL : "";
    }

    public int getAppealID() {
        return appealID;
    }

    public int getViolationID() {
        return violationID;
    }

    public int getViolatorID() {
        return violatorID;
    }

    public String getAppealText() {
        return appealText;
    }

    public Date getAppealDate() {
        return appealDate;
    }

    public String getStatus() {
        return status;
    }

    public String getAdminResponse() {
        return adminResponse;
    }

    public Date getResponseDate() {
        return responseDate;
    }

    public String getImageURL() {
        return imageURL;
    }

    public String getVideoURL() {
        return videoURL;
    }

}
