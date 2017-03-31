package models;


import javax.persistence.*;

@Entity
public class AllergyManager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="PATIENT_ALLERGY_ID")
    public Long patientAllergyID;

    @Column(name ="PATIENT_ID")
    public String patientID;

    @Column (name ="ALLERGY_ID")
    public Long allergyID;

    @Column(name = "ALLERGY_NAME")
    public String allergyName;

    @Column(name = "FIRST_NAME")
    public String firstName;
}
