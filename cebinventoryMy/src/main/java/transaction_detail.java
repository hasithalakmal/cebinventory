/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class transaction_detail implements java.io.Serializable{
    private String doc_number;
    private String item_code;
    private String unit_of_measure;
    private String quantity;
    private String wbno;
    private String status;

    /**
     * @return the doc_number
     */
    public String getDoc_number() {
        return doc_number;
    }

    /**
     * @param doc_number the doc_number to set
     */
    public void setDoc_number(String doc_number) {
        this.doc_number = doc_number;
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
     * @return the wbno
     */
    public String getWbno() {
        return wbno;
    }

    /**
     * @param wbno the wbno to set
     */
    public void setWbno(String wbno) {
        this.wbno = wbno;
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
    
}
