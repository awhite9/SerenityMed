package models;


public class SuggestionGroup {

    private String name;

    private SuggestionList suggestionList;

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public SuggestionList getSuggestionList ()
    {
        return suggestionList;
    }

    public void setSuggestionList (SuggestionList suggestionList)
    {
        this.suggestionList = suggestionList;
    }
}
