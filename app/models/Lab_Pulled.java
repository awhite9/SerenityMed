package models;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
public class Lab_Pulled
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name ="LAB_PULLED_ID")
    public Long labPulledID;

    @Column (name ="DATE_TAKEN")
    public LocalDate dateTaken;

    @Column (name ="PATIENT_ID")
    public String patientID;

    @Column (name ="LAB_ID")
    public Long labID;

    @Column (name ="DOCTOR_ID")
    public Long doctorID;

    @Column(name = "VALUE")
    public String value;

}
