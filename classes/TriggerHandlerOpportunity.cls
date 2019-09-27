public class TriggerHandlerOpportunity {
    public void updateAccountActivityHistory(list<Opportunity> oppList){
        set<Id> setoppids = new set<Id>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null){
                setoppids.add(opp.AccountId);
            }
        }
        list<Account> accList = [select Id, Name , (select AccountId from Opportunities ) from Account where Id IN : setoppids];
        if(setoppids.size() > 0){
            List<Task> tasks = new List<Task>();
            for(Account acc : accList){
                if(acc.opportunities.size() > 0){
                    tasks.add(new Task(
                        ActivityDate = system.today(),
                        Subject='A New Opportunity Added To you',
                        WhatId = acc.Id,
                        OwnerId = UserInfo.getUserId(),
                        Status='Completed'));
                    
                }
            }
            
                    insert tasks;
        }
        if(accList.size() >0){
            update accList;
        }
    }
}