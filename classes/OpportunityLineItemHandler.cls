public class OpportunityLineItemHandler {
    public void updateFieldOnOpportunity(List<OpportunityLineItem> oliList){
        set<Id> setOppIds = new set<Id>();
        for(OpportunityLineItem oli : oliList){
            setOppIds.add(oli.OpportunityId);
        }
        List<Opportunity> oppList = [SELECT Id, Name,(SELECT Quantity, UnitPrice, TotalPrice, PricebookEntry.Name,
                                                      PricebookEntry.Product2.Name FROM OpportunityLineItems limit 1)
                                     FROM Opportunity where Id In:setOppIds];
        List<OpportunityLineItem> olilst = [SELECT Quantity, UnitPrice, TotalPrice, PricebookEntry.Name,
                                                      PricebookEntry.Product2.Name FROM OpportunityLineItem where OpportunityId in:setOppIds];
        
        if(setOppIds.size() > 0){
            for(Opportunity opp : oppList){
                String str = '';
                for(OpportunityLineItem ol :olilst){
                    if(str == ''){
                        str = ol.PricebookEntry.Product2.Name;
                    }else{
                        str += ', ' + ol.PricebookEntry.Product2.Name;
                    }
                }
                opp.Product_Name__c = str + ' .';
                opp.Total_Product__c = olilst.size();
            }
            if(oppList.size() > 0){
                update oppList;
            } 
        }
    }   
}