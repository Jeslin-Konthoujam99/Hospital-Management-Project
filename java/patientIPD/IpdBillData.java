package patientIPD;

import java.io.Serializable;
import java.sql.Timestamp;

public class IpdBillData implements Serializable {
    private static final long serialVersionUID = 1L;

    private int amount;
    private String reason;
    private Timestamp date;

    // Constructors, getters, and setters

    public IpdBillData() {
    }

    public IpdBillData( int amount, String reason, Timestamp date) {
       
        this.amount = amount;
        this.reason = reason;
        this.date = date;
    }

 

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
}

