package models;


import javax.persistence.*;
import java.time.LocalDate;

@Entity
public class Prescription
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name ="PRESCRIPTION_ID")
    public Long prescriptionID;

    @Column (name ="DATE")
    public LocalDate date;

    @Column (name ="DOSAGE")
    public String dosage;

    @Column (name ="MEDICATION_ID")
    public Long medicationID;

    @Column (name ="PATIENT_ID")
    public String patientID;

    @Column (name ="PHARMACY_ID")
    public Long pharmacyID;

    @Column (name ="DOCTOR_ID")
    public Long doctorID;

    @Column (name ="FREQUENCY_ID")
    public Long frequencyID;
}
