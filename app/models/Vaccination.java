package models;


import javax.persistence.*;

@Entity
public class Vaccination {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="VACCINE_ID")
    public Long vaccineID;

    @Column(name = "VACCINE_NAME")
    public String vaccineName;

    @Column(name ="BOOSTER_REQUIRED")
    public String boosterRequired;

    @Column(name = "VACCINE_DESCRIPTION")
    public String vaccineDescription;
}
