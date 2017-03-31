package models;



public class MedLine
{
    private String name;
    private String summary;
    private String uRL;


    public MedLine(String name, String summary, String uRL)
    {
        this.name = name;
        this.summary = summary;
        this.uRL = uRL;
    }
    public String getName()
    {
        return name;
    }
    public  String getSummary()
    {
        return summary;
    }
    public String getuRL()
    {
        return uRL;
    }
}