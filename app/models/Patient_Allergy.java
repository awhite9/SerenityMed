package models;

import javax.persistence.*;

@Entity
public class Patient_Allergy
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name ="PATIENT_ALLERGY_ID")
    public Long patientAllergyID;

    @Column (name ="PATIENT_ID")
    public String patientID;

    @Column (name ="ALLERGY_ID")
    public Long allergyID;
}
