
import java.io.Serializable;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Ranil
 */
public class auctioning_list implements Serializable {

    private String auction_no;
    private String user_name;
    private String item_code;
    private String status;
    private String quantity;
    private String remarks;
    private String price;
    private String value;
    private String selling_price;
    private String cause_for_auction;
    private String approved;

    /**
     * @return the auction_no
     */
    public String getAuction_no() {
        return auction_no;
    }

    /**
     * @param auction_no the auction_no to set
     */
    public void setAuction_no(String auction_no) {
        this.auction_no = auction_no;
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
     * @return the price
     */
    public String getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(String price) {
        this.price = price;
    }

    /**
     * @return the value
     */
    public String getValue() {
        return value;
    }

    /**
     * @param value the value to set
     */
    public void setValue(String value) {
        this.value = value;
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
     * @return the selling_price
     */
    public String getSelling_price() {
        return selling_price;
    }

    /**
     * @param selling_price the selling_price to set
     */
    public void setSelling_price(String selling_price) {
        this.selling_price = selling_price;
    }

    /**
     * @return the cause_for_auction
     */
    public String getCause_for_auction() {
        return cause_for_auction;
    }

    /**
     * @param cause_for_auction the cause_for_auction to set
     */
    public void setCause_for_auction(String cause_for_auction) {
        this.cause_for_auction = cause_for_auction;
    }
    
}
