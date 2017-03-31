package models;


import javax.persistence.*;

@Entity
public class Interaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DRUG_INTERACTION_ID")
    public Long drugInterationID;

    @Column(name = "Drug1Name")
    public String drug1Name;

    @Column(name = "RXCUI")
    public Long rxcui;

    @Column(name = "inter_rxcui")
    public Long interRXCUI;

    @Column(name = "drug2Name")
    public String drug2Name;

    @Column(name = "INTER_DESCRIPTION")
    public String interDescription;
}