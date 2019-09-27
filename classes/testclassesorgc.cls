public class testclassesorgc {
    /*
     trigger UpdateProjectStartDate on Opportunity (after update){
    List<Projects__c> projectList = new List<Projects__c>();
    Map<String,Date> oppStartDateMap = new Map<String,Date>();
    for(Opportunity op : Trigger.New){
        oppStartDateMap.put(op.id,op.Planned_Start_Date__c);
    }
    for(Projects__c pro : [Select id,Start_Date2__c,Opportunity__c from Projects__c where Opportunity__c IN : Trigger.New]){
        if(oppStartDateMap.containsKey(pro.Opportunity__c)){
            pro.Start_Date2__c = oppStartDateMap.get(pro.Opportunity__c );
            projectList.add(pro);
        }        
    }
    if(projectList.size() > 0){
        Database.update(projectList, false);
    }
}

============================
trigger UpdateStartDateFromOpportunity on Projects__c (before insert) {
    Set<String> OppIds= new Set<String>();
    Map<String,Date> oppStartDateMap = new Map<String,Date>();
    for(Projects__c pro : trigger.new){
        if(String.isNotBlank(pro.Opportunity__c)){
            OppIds.add(pro.Opportunity__c);
        }        
    }
    for(Opportunity opp : [Select id,Planned_Start_Date__c from opportunity where id IN : OppIds]){
        if(opp.Planned_Start_Date__c != null){
            oppStartDateMap.put(opp.id,opp.Planned_Start_Date__c);
        }
    }
    for(Projects__c pro : Trigger.new){
        if(oppStartDateMap.containsKey(pro.opportunity__c)){
            pro.Start_Date2__c = oppStartDateMap.get(pro.opportunity__c);
        }
    }    
}
	*/
}