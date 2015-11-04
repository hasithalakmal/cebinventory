/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Isuru
 */
public class transaction_header {

    private String doc_number;
    private String doc_date;
    private String transaction_type;
    private String user_name;
    private String issue_to;
    private String request_no;
    private String remarks;
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
     * @return the doc_date
     */
    public String getDoc_date() {
        return doc_date;
    }

    /**
     * @param doc_date the doc_date to set
     */
    public void setDoc_date(String doc_date) {
        this.doc_date = doc_date;
    }

    /**
     * @return the transaction_type
     */
    public String getTransaction_type() {
        return transaction_type;
    }

    /**
     * @param transaction_type the transaction_type to set
     */
    public void setTransaction_type(String transaction_type) {
        this.transaction_type = transaction_type;
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
     * @return the issue_to
     */
    public String getIssue_to() {
        return issue_to;
    }

    /**
     * @param issue_to the issue_to to set
     */
    public void setIssue_to(String issue_to) {
        this.issue_to = issue_to;
    }

    /**
     * @return the request_no
     */
    public String getRequest_no() {
        return request_no;
    }

    /**
     * @param request_no the request_no to set
     */
    public void setRequest_no(String request_no) {
        this.request_no = request_no;
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

}
