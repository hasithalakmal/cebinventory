public class StatusConverter {

    public static String convertDigitsToString(String status){
        String tmp = null;
        if(status.charAt(0)=='0'){
            tmp = "New->";
        }
        else if(status.charAt(0)=='1'){
            tmp = "Damaged->";
        }
        else if(status.charAt(0)=='2'){
            tmp = "Defective->";
        }
        else if(status.charAt(0)=='3'){
            tmp = "Obsolete->";
        }
        if(status.charAt(1)=='0'){
            tmp = tmp + "Available->";
        }
        else if(status.charAt(1)=='1'){
            tmp = tmp + "Lost->";
        }
        if(status.charAt(2)=='0'){
            tmp = tmp + "Wanted->";
        }
        else if(status.charAt(2)=='1'){
            tmp = tmp + "Unwanted->";
        }
        if(status.charAt(3)=='0'){
            tmp = tmp + "Non-Auctioning";
        }
        else if(status.charAt(3)=='1'){
            tmp = tmp + "Auctioning";
        }
        return tmp;
    }

    public static String convertStringToDigits(String status){
        String tmp = null;
        if(status.contains("New")){
            tmp = "0";
        }
        else if(status.contains("Damaged")){
            tmp = "1";
        }
        else if(status.contains("Defective")){
            tmp = "2";
        }
        else if(status.contains("Obsolete")){
            tmp = "3";
        }
        if(status.contains("Available")){
            tmp = tmp + "0";
        }
        else if(status.contains("Lost")){
            tmp = tmp + "1";
        }
        if(status.contains("Wanted")){
            tmp = tmp + "0";
        }
        else if(status.contains("Unwanted")){
            tmp = tmp + "1";
        }
        if(status.contains("Non-Auctioning")){
            tmp = tmp + "0";
        }
        else if(status.contains("Auctioning")){
            tmp = tmp + "1";
        }
        return tmp;
    }

}
