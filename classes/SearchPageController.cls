public with sharing class SearchPageController
{
    public final Account anAccount { get; set; }
    public List<String> searchFields { get; private set; }


    public SearchPageController()
    {
        anAccount = new Account();
        searchFields = new List<String>(Account.getSObjectType().getDescribe().fields.getMap().keySet());
    }
}