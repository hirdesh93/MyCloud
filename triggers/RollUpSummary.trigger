trigger RollUpSummary on Contact (after insert,after update, after delete, after undelete) {
    /*
    set<Id> setIds = new set<Id>();
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && Trigger.isAfter ){
        for(Contact con: trigger.new){
            if(con.AccountId != null){
                setIds.add(con.AccountId);
            }
        }
    }
    if((trigger.isDelete || trigger.isUpdate) && Trigger.isAfter){
        for(Contact con: trigger.old){
            if(con.AccountId != null){
                setIds.add(con.AccountId);
            }
        }
    }
    
    List<Double> intList = new List<Double>();   
    List<Account> accList1 = [select id, name ,Rollup_Amount_X__c,(select id ,AccountId, LastName,Amount_X__c from Contacts) from Account where ID in : setIds ];
    for(Account acc : accList1){
        intList.clear();
        Double amount = 0;
        For(Contact con1 :acc.Contacts){
            intList.add(con1.Amount_X__c);
            
            system.debug('inlist1'+intList);
            if(amount == 0){
                amount =  con1.Amount_X__c;
            }
            else if(acc.Rollup_Amount_X__c != null && con1.AccountId == acc.Id){
                amount +=con1.Amount_X__c;
            }
            
        }
        acc.Rollup_Amount_X__c  = amount;
        if(acc.contacts.size() >= 2){
            intList.sort();
            system.debug('inlist'+intList);
            Double firstContact = intList[0];
            system.debug('FirstContact'+firstContact);
            Double lastContact  = intList[intList.size() - 2];
            system.debug('FirstContact'+lastContact);
            if( acc.Rollup_Amount_X__c != null){
                acc.Highest_Percent__c = (lastContact/acc.Rollup_Amount_X__c )*100;
            }
        }
    }
    
    if(acclist1.size() > 0){
        update accList1;
    }
*/
    
   Map<Id,Decimal> conMap = new Map<Id,Decimal>();
   if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && Trigger.isAfter ){
        for(Contact con: trigger.new){
            if(con.AccountId != null){
                conMap.put(con.AccountId, con.Amount_X__c);
            }
        }
    }
    if((trigger.isDelete || trigger.isUpdate) && Trigger.isAfter){
        for(Contact con: trigger.old){
            if(con.AccountId != null){
                conMap.put(con.AccountId , con.Amount_X__c);
            }
        }
    }
}