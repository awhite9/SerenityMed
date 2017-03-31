package models;


import java.util.List;

public class IdGroup {

    private List<String> rxnormId;

    private String name;

    public List<String> getRxnormId ()
    {
        return rxnormId;
    }

    public void setRxnormId (List<String> rxnormId)
    {
        this.rxnormId = rxnormId;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }
}
