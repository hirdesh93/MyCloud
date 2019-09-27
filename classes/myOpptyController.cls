public class myOpptyController {

    public List<Opportunity> opptyList;
    
    public myOpptyController() {

    opptyList = [SELECT Id,Name,Account.Name, 
                                  (SELECT Quantity, UnitPrice, TotalPrice,PricebookEntry.Name, PricebookEntry.Product2.Family FROM OpportunityLineItems) 
                        FROM Opportunity WHERE Id =: ApexPages.currentPage().getParameters().get('opptyID')];
    
        System.debug('opptyList ='+opptyList);

    }
    
    public List<Opportunity> getopptyList() {
        return opptyList;
    }
    
}