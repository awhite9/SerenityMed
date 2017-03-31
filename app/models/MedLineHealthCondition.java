package models;

import javax.persistence.*;

@Entity
public class MedLineHealthCondition
{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="MEDICAL_HISTORY_ID")
    public Long medicalHistoryID;

    @Column(name = "MC_NAME")
    public String name;

    @Column(name = "MC_DESCRIPTION")
    public String description;

    @Column(name = "MC_URL")
    public String url;
}
