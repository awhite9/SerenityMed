package models;


import java.util.ArrayList;
import java.util.List;

public class SuggestionList {

    public List<String> suggestion = new ArrayList();

    public List<String> getSuggestion ()
    {
        return suggestion;
    }

    public void setSuggestion (List<String> suggestion)
    {
        this.suggestion = suggestion;
    }
}
