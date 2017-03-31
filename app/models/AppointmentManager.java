package models;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
public class AppointmentManager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name="APPOINTMENT_ID")
    public Long appointmentID;

    @Column(name = "PATIENT_ID")
    public String patientID;

    @Column(name = "DOCTOR_ID")
    public Long doctorID;

    @Column(name = "DOC_NAME")
    public String docName;

    @Column(name = "APPOINTMENT_DATE")
    public LocalDate date;

    @Column(name = "APPOINTMENT_TIME")
    public LocalTime time;

    @Column(name = "DOC_SPECIALTY")
    public String docSpecialty;

    @Column(name="FIRST_NAME")
    public String firstName;
}
