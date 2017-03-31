package models;


import javax.persistence.*;

@Entity
public class PrescriptionReminderJoin {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="PRESCRIPTION_ID")
    public Long prescriptionID;

    @Column(name ="DOSAGE")
    public String dosage;

    @Column(name = "MEDICATION_NAME")
    public String medicationName;

    @Column(name = "FREQUENCY")
    public Long frequency;
}

