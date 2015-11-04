
import java.io.Serializable;

/**
 *
 * @author Ranil
 */
public class status_change_requests implements Serializable {

    private String item_code;
    private String user_name;
    private String current_status;
    private String requested_status;
    private String description;
    private String cause;
    private String unwanted;
    private String quantity;
    private String available_quantity;
    private String date;
    private String approved;

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
     * @return the current_status
     */
    public String getCurrent_status() {
        return current_status;
    }

    /**
     * @param current_status the current_status to set
     */
    public void setCurrent_status(String current_status) {
        this.current_status = current_status;
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
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the cause
     */
    public String getCause() {
        return cause;
    }

    /**
     * @param cause the cause to set
     */
    public void setCause(String cause) {
        this.cause = cause;
    }

    /**
     * @return the unwanted
     */
    public String getUnwanted() {
        return unwanted;
    }

    /**
     * @param unwanted the unwanted to set
     */
    public void setUnwanted(String unwanted) {
        this.unwanted = unwanted;
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
