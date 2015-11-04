/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class owner_item_master implements java.io.Serializable{
    private String user_name;
    private String item_code;
    private String cost_id;
    private String section_id;
    private String quantity;
    private String unit_of_measure;
    private String status;
    private String freeze;
    private String lended;
    private String lost_found;
    private String conflict_flag;

    public String getLost_found() {
        return lost_found;
    }

    public void setLost_found(String lost_found) {
        this.lost_found = lost_found;
    }

    public String getLended() {
        return lended;
    }

    public void setLended(String lended) {
        this.lended = lended;
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
     * @return the cost_id
     */
    public String getCost_id() {
        return cost_id;
    }

    /**
     * @param cost_id the cost_id to set
     */
    public void setCost_id(String cost_id) {
        this.cost_id = cost_id;
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
     * @return the unit_of_measure
     */
    public String getUnit_of_measure() {
        return unit_of_measure;
    }

    /**
     * @param unit_of_measure the unit_of_measure to set
     */
    public void setUnit_of_measure(String unit_of_measure) {
        this.unit_of_measure = unit_of_measure;
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
     * @return the lost_found
     */
    
    /**
     * @return the section_id
     */
    public String getSection_id() {
        return section_id;
    }

    /**
     * @param section_id the section_id to set
     */
    public void setSection_id(String section_id) {
        this.section_id = section_id;
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
     * @return the unwanted
     */
    
    /**
     * @return the freeze
     */
    public String getFreeze() {
        return freeze;
    }

    /**
     * @param freeze the freeze to set
     */
    public void setFreeze(String freeze) {
        this.freeze = freeze;
    }

    /**
     * @return the conflict_flag
     */
    public String getConflict_flag() {
        return conflict_flag;
    }

    /**
     * @param conflict_flag the conflict_flag to set
     */
    public void setConflict_flag(String conflict_flag) {
        this.conflict_flag = conflict_flag;
    }


}
