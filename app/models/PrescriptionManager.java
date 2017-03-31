package models;


import javax.persistence.*;
import java.sql.Date;

@Entity
public class PrescriptionManager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PRESCRIPTION_ID")
    public Long prescriptionID;

    @Column(name = "DATE")
    public Date date;

    @Column(name = "DOSAGE")
    public String dosage;

    @Column(name = "MEDICATION_ID")
    public Long medicationID;

    @Column(name = "PATIENT_ID")
    public String patientID;

    @Column(name = "PHARMACY_ID")
    public Long pharmacyID;

    @Column(name = "DOCTOR_ID")
    public Long doctorID;

    @Column(name = "FREQUENCY_ID")
    public Long frequencyID;

    @Column(name = "MEDICATION_NAME")
    public String medicationName;

    @Column(name = "FREQUENCY")
    public Long frequency;

    @Column(name = "DOC_NAME")
    public String docName;

    @Column(name = "PHARM_NAME")
    public String pharmName;

    @Column(name = "FIRST_NAME")
    public String firstName;

}