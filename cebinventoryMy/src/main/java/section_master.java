
import java.io.Serializable;

/**
 *
 * @author Ranil
 */
public class section_master implements Serializable {

    private String section_id;
    private String centre_id;
    private String section_name;
    private String center_name;
    private String status;

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
     * @return the centre_id
     */
    public String getCentre_id() {
        return centre_id;
    }

    /**
     * @param centre_id the centre_id to set
     */
    public void setCentre_id(String centre_id) {
        this.centre_id = centre_id;
    }

    /**
     * @return the section_name
     */
    public String getSection_name() {
        return section_name;
    }

    /**
     * @param section_name the section_name to set
     */
    public void setSection_name(String section_name) {
        this.section_name = section_name;
    }

    /**
     * @return the center_name
     */
    public String getCenter_name() {
        return center_name;
    }

    /**
     * @param center_name the center_name to set
     */
    public void setCenter_name(String center_name) {
        this.center_name = center_name;
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
