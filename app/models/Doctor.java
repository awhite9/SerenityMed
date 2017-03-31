package models;

import javax.persistence.*;

@Entity
public class Doctor
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column (name="DOCTOR_ID")
    public Long doctorID;

    public String getDocName()
    {
        return docName;
    }

    @Column (name="DOC_NAME")
    public String docName;

    @Column (name="DOC_SPECIALTY")
    public String docSpecialty;

    @Column (name="DOC_PHONE_NUMBER")
    public String docPhoneNumber;

    public String getDocAddress()
    {
        return docAddress;
    }

    @Column (name="DOC_ADDRESS")
    public String docAddress;

    @Column (name="DOC_CITY")
    public String docCity;

    @Column (name="DOC_STATE")
    public String docState;

    @Column (name="DOC_ZIP")
    public String docZip;

}
