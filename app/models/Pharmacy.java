package models;

import javax.persistence.*;

@Entity
public class Pharmacy
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name ="PHARMACY_ID")
    public Long pharmacyID;

    @Column (name ="PHARM_NAME")
    public String pharmName;

    @Column (name ="PHARM_ADDRESS")
    public String pharmAddress;

    @Column (name ="PHARM_STATE")
    public String pharmState;

    @Column (name ="PHARM_CITY")
    public String pharmCity;

    @Column (name ="PHARM_ZIP")
    public String pharmZip;

}
