package models;

import javax.persistence.*;

@Entity
public class Drug_Interaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="DRUG_INTERACTION_ID")
    public Long drugInteractionID;

    @Column(name ="RXCUI")
    public Long rxcui;

    @Column(name ="INTER_RXCUI")
    public Long interRXCUI;

    @Column(name ="INTER_DESCRIPTION")
    public String interDescription;
}
