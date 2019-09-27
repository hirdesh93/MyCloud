public class SearchPanelContact {

    String searchText;
    List<Contact> results;
    List<Lead> results1;

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<Contact> getResults() {
        return results;
    }
     public List<Lead> getResults1() {
        return results1;
    }

    public PageReference doSearch() {
        results = (List<Contact>)[FIND :searchText RETURNING Contact(Name, Email, Phone)][0];
        results1 = (List<Lead>)[FIND : searchText RETURNING lead(Name, Email, Phone)][0];
        
        return null;
    }
}