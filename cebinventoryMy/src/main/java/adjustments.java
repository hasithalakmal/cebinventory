/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class adjustments implements java.io.Serializable{

    private String adjustment_no;
    private String user_name;
    private String item_code;
    private String remarks;
    private String status;
    private String approved;
    private String actual_quantity;
    private String available_quantity;

    /**
     * @return the verification_no
     */
    

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

    /**
     * @return the adjustment_no
     */
    public String getAdjustment_no() {
        return adjustment_no;
    }

    /**
     * @param adjustment_no the adjustment_no to set
     */
    public void setAdjustment_no(String adjustment_no) {
        this.adjustment_no = adjustment_no;
    }

}
