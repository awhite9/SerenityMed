package models;


import javax.persistence.*;

@Entity
public class VitalStringName {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="VITAL_NAME")
    public String vitalName;
}
