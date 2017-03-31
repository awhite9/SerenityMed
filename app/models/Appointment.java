package models;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
public class Appointment
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name="Appointment_ID")
    public Long appointmentID;

    @Column (name="Patient_ID")
    public String patientID;

    @Column (name="Doctor_ID")
    public Long doctorID;

    @Column (name="Appointment_Date")
    public LocalDate date;

    @Column (name="Appointment_Time")
    public LocalTime time;


}
