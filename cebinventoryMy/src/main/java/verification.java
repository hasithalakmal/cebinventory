/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class verification implements java.io.Serializable{

    private String verification_no;
    private String user_name;
    private String item_code;
    private String date;
    private String remarks;
    private String status;
    private String approved;
    private String requested_status;
    private String actual_quantity;
    private String available_quantity;

    /**
     * @return the verification_no
     */
    public String getVerification_no() {
        return verification_no;
    }

    /**
     * @param verification_no the verification_no to set
     */
    public void setVerification_no(String verification_no) {
        this.verification_no = verification_no;
    }

    /**
     * @return the user_name
     */
    public String getUser_name() {
        return user_name;
    }

    /**
     * @param user_name the user_name to set
     */
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    /**
     * @return the item_code
     */
    public String getItem_code() {
        return item_code;
    }

    /**
     * @param item_code the item_code to set
     */
    public void setItem_code(String item_code) {
        this.item_code = item_code;
    }

    /**
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(String date) {
        this.date = date;
    }

    /**
     * @return the remarks
     */
    public String getRemarks() {
        return remarks;
    }

    /**
     * @param remarks the remarks to set
     */
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the approved
     */
    public String getApproved() {
        return approved;
    }

    /**
     * @param approved the approved to set
     */
    public void setApproved(String approved) {
        this.approved = approved;
    }

    /**
     * @return the requested_status
     */
    public String getRequested_status() {
        return requested_status;
    }

    /**
     * @param requested_status the requested_status to set
     */
    public void setRequested_status(String requested_status) {
        this.requested_status = requested_status;
    }

    /**
     * @return the actual_quantity
     */
    public String getActual_quantity() {
        return actual_quantity;
    }

    /**
     * @param actual_quantity the actual_quantity to set
     */
    public void setActual_quantity(String actual_quantity) {
        this.actual_quantity = actual_quantity;
    }

    /**
     * @return the available_quantity
     */
    public String getAvailable_quantity() {
        return available_quantity;
    }

    /**
     * @param available_quantity the available_quantity to set
     */
    public void setAvailable_quantity(String available_quantity) {
        this.available_quantity = available_quantity;
    }

}
