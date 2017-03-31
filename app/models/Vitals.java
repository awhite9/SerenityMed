package models;

import javax.persistence.*;

@Entity
public class Vitals
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name="VITAL_ID")
    public Long vitalID;

    @Column (name="VITAL_NAME")
    public String vitalName;

    @Column (name="VITAL_DESCRIPTION")
    public String vitalDescription;
}
