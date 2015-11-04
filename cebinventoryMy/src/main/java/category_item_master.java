public class category_item_master implements java.io.Serializable{


private String category;
private int category_code;
private String item;
private int item_code;


public String getCategory() {
return category;
}
public void setCategory(String cat) {
this.category =cat;
}
public int getCategory_code() {
return category_code;
}
public void setCategory_code(int catc) {
this.category_code = catc;
}


public String getItem() {
return item;
}
public void setItem(String itm) {
this.item =itm;
}
public int getItem_code() {
return item_code;
}
public void setItem_code(int itmc) {
this.item_code = itmc;
}



}