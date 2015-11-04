/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
import java.util.Date;

public class item_master {

    private String item_code;
    private String item_name;
    private String composite;
    private String status;
    private String is_inventory;
    private String is_capital;
    private String price;
    private String value;
    private String depreciation_rate;
    private String serial_number;
    private String critical;
    private String composite_code;
    private String unit_of_measure;
    private byte[] image;
    private String remarks;
    private String safety_stock;
    private String reorder_level;
    private String maximum_stock;
    private String abc;
    private Date warranty_expiry_date;
    private String service_start_date;
    private Date service_end_date;
    private String lead_time;
    private String location;
    private String vendor;
    

    /**
     * @return the itemcode
     */
    public String getItem_code() {
        return item_code;
    }

    /**
     * @param itemcode the itemcode to set
     */
    public void setItem_code(String itemcode) {
        this.item_code = itemcode;
    }

    /**
     * @return the itemname
     */
    public String getItem_name() {
        return item_name;
    }

    /**
     * @param itemname the itemname to set
     */
    

    /**
     * @return the part_of_composite
     */
    public String getComposite() {
        return composite;
    }

    /**
     * @param part_of_composite the part_of_composite to set
     */
    public void setComposite(String composite) {
        this.composite =composite;
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
     * @return the is_inventory
     */
    public String getIs_inventory() {
        return is_inventory;
    }

    /**
     * @param is_inventory the is_inventory to set
     */
    public void setIs_inventory(String is_inventory) {
        this.is_inventory = is_inventory;
    }

    /**
     * @return the is_capital
     */
    public String getIs_capital() {
        return is_capital;
    }

    /**
     * @param is_capital the is_capital to set
     */
    public void setIs_capital(String is_capital) {
        this.is_capital = is_capital;
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
     * @return the depreciation_rate
     */
    public String getDepreciation_rate() {
        return depreciation_rate;
    }

    /**
     * @param depreciation_rate the depreciation_rate to set
     */
    public void setDepreciation_rate(String depreciation_rate) {
        this.depreciation_rate = depreciation_rate;
    }

    /**
     * @return the serial_number
     */
    public String getSerial_number() {
        return serial_number;
    }

    /**
     * @param serial_number the serial_number to set
     */
    public void setSerial_number(String serial_number) {
        this.serial_number = serial_number;
    }

    /**
     * @return the critical
     */
    public String getCritical() {
        return critical;
    }

    /**
     * @param critical the critical to set
     */
    public void setCritical(String critical) {
        this.critical = critical;
    }

    public String getComposite_code(){
        return composite_code;
    }

    public void setComposite_code(String composite){
        this.composite_code=composite;
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
     * @return the image
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
     * @param image the image to set
     */
    
    /**
     * @return the safety_stock
     */
    public String getSafety_stock() {
        return safety_stock;
    }

    /**
     * @param safety_stock the safety_stock to set
     */
    public void setSafety_stock(String safety_stock) {
        this.safety_stock = safety_stock;
    }

    /**
     * @return the reorder_level
     */
    public String getReorder_level() {
        return reorder_level;
    }

    /**
     * @param reorder_level the reorder_level to set
     */
    public void setReorder_level(String reorder_level) {
        this.reorder_level = reorder_level;
    }

    /**
     * @return the maximum_stock
     */
    public String getMaximum_stock() {
        return maximum_stock;
    }

    /**
     * @param maximum_stock the maximum_stock to set
     */
    public void setMaximum_stock(String maximum_stock) {
        this.maximum_stock = maximum_stock;
    }

    /**
     * @return the abc
     */
    public String getAbc() {
        return abc;
    }

    /**
     * @param abc the abc to set
     */
    public void setAbc(String abc) {
        this.abc = abc;
    }

    /**
     * @return the image
     */
   

    /**
     * @param image the image to set
     */
   
    /**
     * @param image the image to set
     */
    
    /**
     * @return the warranty_expiry_date
     */
    public Date getWarranty_expiry_date() {
        return warranty_expiry_date;
    }

    /**
     * @param warranty_expiry_date the warranty_expiry_date to set
     */
    public void setWarranty_expiry_date(Date warranty_expiry_date) {
        this.warranty_expiry_date = warranty_expiry_date;
    }

    /**
     * @return the service_start_date
     */
    public String getService_start_date() {
        return service_start_date;
    }

    /**
     * @param service_start_date the service_start_date to set
     */
    public void setService_start_date(String service_start_date) {
        this.service_start_date = service_start_date;
    }

    /**
     * @return the service_end_date
     */
    public Date getService_end_date() {
        return service_end_date;
    }

    /**
     * @param service_end_date the service_end_date to set
     */
    public void setService_end_date(Date service_end_date) {
        this.service_end_date = service_end_date;
    }

    /**
     * @return the lead_time
     */
    public String getLead_time() {
        return lead_time;
    }

    /**
     * @param lead_time the lead_time to set
     */
    public void setLead_time(String lead_time) {
        this.lead_time = lead_time;
    }

    /**
     * @param item_name the item_name to set
     */
    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    /**
     * @return the image
     */
    public byte[] getImage() {
        return image;
    }

    /**
     * @param image the image to set
     */
    public void setImage(byte[] image) {
        this.image = image;
    }


    public String getVendor() {
        return vendor;
    }

    /**
     * @param lead_time the lead_time to set
     */
    public void setVendor(String vendor) {
        this.vendor=vendor;
    }

    public String getLocation() {
        return location;
    }

    /**
     * @param lead_time the lead_time to set
     */
    public void setLocation(String location) {
        this.location=location;
    }

}
