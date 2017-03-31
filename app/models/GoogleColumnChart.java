package models;

import java.time.LocalDate;


public class GoogleColumnChart {

    private LocalDate dateTaken;
    private float glucose;
    private float hemoglobin;

    public LocalDate getDateTaken() {
        return dateTaken;
    }

    public float getGlucose() {
        return glucose;
    }

    public float getHemoglobin() {
        return hemoglobin;
    }

    public void setDateTaken(LocalDate dateTaken) {
        this.dateTaken = dateTaken;
    }

    public void setGlucose(float glucose) {
        this.glucose = glucose;
    }

    public void setHemoglobin(float hemoglobin) {
        this.hemoglobin = hemoglobin;
    }
}


