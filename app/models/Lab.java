package models;

import javax.persistence.*;

@Entity
public class Lab
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name="LAB_ID")
    public Long labID;

    @Column (name="LAB_NAME")
    public String labName;

    @Column (name="LAB_DESCRIPTION")
    public String labDescription;

}
