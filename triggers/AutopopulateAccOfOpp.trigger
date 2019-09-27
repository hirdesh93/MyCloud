trigger AutopopulateAccOfOpp on Project__c (before insert,before update) {
    
  /*  Map<Id, List<Project__c>> objsByOppId = new Map<Id, List<Project__c>>();
    for (Project__c obj : trigger.new){
        if (Trigger.isInsert || Trigger.isUpdate){
            List<Project__c> objList ;
            if (objList == null){
                objList=new List<Project__c>();
                objsByOppId.put(obj.Opportunity__c, objList);
            }
            objList.add(obj);
        }
        
        List<Opportunity> opps=[select id, AccountId from Opportunity where id IN :objsByOppId.keySet()];
        for (Opportunity opp : opps){
            List<Project__c> objList=objsByOppId.get(opp.id);
            for (Project__c obj1 : objList){
                obj1.Account__c=opp.AccountId;
            }
        }
    }
*/
    Set<Id> setIds = new Set<Id>();
    if(trigger.isinsert || trigger.isupdate){
        for(project__c pro : trigger.new){
            if(pro.Opportunity__c != null){
            setIds.add(pro.Opportunity__c);
            }
        }
    }
    for(Opportunity opp :[select id, name , AccountId from Opportunity where ( Id In:setIds ) ]){
        for(Project__c pro : trigger.new){
            pro.Account__c = opp.AccountId;
        }
    }
}