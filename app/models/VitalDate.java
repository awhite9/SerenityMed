package models;

import javax.persistence.*;
import java.time.LocalDate;


@Entity
public class VitalDate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="DATE_TAKEN")
    public LocalDate dateTaken;

}