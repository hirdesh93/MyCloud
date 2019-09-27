trigger OppProductDeleteTrigger on OpportunityLineItem (before delete) {
    Map<String, Integer> oppProdCountMap=new Map<String, Integer>();
    Map<String, String> prodAndOppId = new Map<String, String>();
    Set<String> oppId=new Set<String>();
    for(OpportunityLineItem li:[select Id, Opportunity.Id from OpportunityLineItem where Id IN: Trigger.Old]) {
        oppId.add(li.Opportunity.Id);
        prodAndOppId.put(li.Id, li.Opportunity.Id);
    }
    for(Opportunity opp:[select Id, (select Id, Opportunity.Id from OpportunityLineItems) from Opportunity where Id IN: oppId]) {
        if(opp.OpportunityLineItems.size() > 0){
            oppProdCountMap.put(opp.id,opp.OpportunityLineItems.size());
        }
    }
    System.debug('oppProdCountMap: '+oppProdCountMap);
    Set<Id>error=new Set<Id>();
    for(OpportunityLineItem prod: Trigger.Old){
        String oppId=prodAndOppId.get(prod.Id);
        if(oppProdCountMap.get(oppId)>1){
            oppProdCountMap.put(oppId, oppProdCountMap.get(oppId)-1);
            System.debug('oppProdCountMap: '+oppProdCountMap);
        }else{
            error.add(prod.Id);
        }
    }
    
    for(OpportunityLineItem prod: Trigger.Old) {
        System.debug('prod: '+prod.Id);
        try {
            if(error.contains(prod.Id)) {
                prod.addError('You cannot delete this product');
            }
        }
        catch(Exception e) {
            System.debug(e);
        }
         
    }
}