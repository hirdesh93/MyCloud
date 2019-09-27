trigger OpportunityProductPreventToDelete on OpportunityLineItem (before delete) {
  set<Id> setIds = new set<Id>();
    for(OpportunityLineItem oli : Trigger.old){
        setIds.add(oli.OpportunityId);
    }
    Map<Id, Integer> mapCount = new Map<Id , Integer>();
    for(Opportunity Opp: [select id, name,(select id , name from OpportunityLineItems) from opportunity where Id In: setIds]){
        mapCount.put(Opp.Id, Opp.OpportunityLineItems.size());
        if(mapCount.get(Opp.id) >0){
          mapCount.put(Opp.Id, Opp.OpportunityLineItems.size() -1);
        }
    }
    for(OpportunityLineItem oli : Trigger.old){
        if(mapCount.get(oli.OpportunityId) == 1 ){
            oli.addError('Prevent To Delete');
        }
    }
}