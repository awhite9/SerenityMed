package models;


import java.time.LocalDate;

public class VitalList {

    private String vitalName;
    private String value1;
    private LocalDate Date1;
    private Long id1;
    private String value2;
    private LocalDate Date2;
    private Long id2;
    private String value3;
    private LocalDate Date3;
    private Long id3;
    private Long vitalID;

    public void setVitalName(String vitalName)
    {
        this.vitalName = vitalName;
    }
    public String getVitalName()
    {
        return vitalName;
    }

    public Long getVitalID()
    {
        return vitalID;
    }
    public void setVitalID(Long vitalID)
    {
        this.vitalID = vitalID;
    }


    public String getValue1() {
        return value1;
    }

    public LocalDate getDate1() {
        return Date1;
    }

    public Long getId1() {
        return id1;
    }

    public String getValue2() {
        return value2;
    }

    public LocalDate getDate2() {
        return Date2;
    }

    public Long getId2() {
        return id2;
    }

    public String getValue3() {
        return value3;
    }

    public LocalDate getDate3() {
        return Date3;
    }

    public Long getId3() {
        return id3;
    }

    public void setValue1(String value1) {
        this.value1 = value1;
    }

    public void setDate1(LocalDate date1) {
        Date1 = date1;
    }

    public void setId1(Long id1) {
        this.id1 = id1;
    }

    public void setValue2(String value2) {
        this.value2 = value2;
    }

    public void setDate2(LocalDate date2) {
        Date2 = date2;
    }

    public void setId2(Long id2) {
        this.id2 = id2;
    }

    public void setValue3(String value3) {
        this.value3 = value3;
    }

    public void setDate3(LocalDate date3) {
        Date3 = date3;
    }

    public void setId3(Long id3) {
        this.id3 = id3;
    }
}
