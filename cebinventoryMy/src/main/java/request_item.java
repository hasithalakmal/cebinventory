/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class request_item {
    private String user_name;
    private String item_description;
    private String quantity;
    private String remarks;
    private String date;
    private String request_id;
    private String approved;

    public String getApproved() {
        return approved;
    }

    public void setApproved(String approved) {
        this.approved = approved;
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
     * @return the item_description
     */
    public String getItem_description() {
        return item_description;
    }

    /**
     * @param item_description the item_description to set
     */
    public void setItem_description(String item_description) {
        this.item_description = item_description;
    }

    /**
     * @return the quantity
     */
    public String getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(String quantity) {
        this.quantity = quantity;
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
     * @return the request_id
     */
    public String getRequest_id() {
        return request_id;
    }

    /**
     * @param request_id the request_id to set
     */
    public void setRequest_id(String request_id) {
        this.request_id = request_id;
    }



}
