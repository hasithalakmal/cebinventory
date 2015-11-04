/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class stock_category_item implements java.io.Serializable{

    private String category_code;
    private String category;
    private String item;
    private String item_code;

    /**
     * @return the category_code
     */
    public String getCategory_code() {
        return category_code;
    }

    /**
     * @param category_code the category_code to set
     */
    public void setCategory_code(String category_code) {
        this.category_code = category_code;
    }

    /**
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * @return the item
     */
    public String getItem() {
        return item;
    }

    /**
     * @param item the item to set
     */
    public void setItem(String item) {
        this.item = item;
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
    
}
