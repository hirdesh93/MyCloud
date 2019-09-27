trigger CountContactonAccount on Contact (after insert ,after update) {
  List<Contact> VLstContact;
    set<String> vAccId = new set<String>();
    
    if(trigger.isInsert || trigger.isUndelete || trigger.isdelete)
    {
        // Check if this is trigger is fired by inser/undelete/update
        if(!trigger.isdelete)
        {
            VLstContact = trigger.new;
        }
        else
        {
            VLstContact = trigger.old;
        }
        
        
        for(Contact vContact : VLstContact)
        {
            if(vContact.AccountId != null)
            {
                vAccId.add(vContact.AccountId);
            }
        }
        
    } else {
        if(trigger.isUpdate)
        {
            VLstContact = trigger.new;
            
            for(Contact vNewContact : VLstContact){
                Contact oldContact = trigger.oldMap.get(vNewContact.Id);
                if(vNewContact.AccountId != oldContact.AccountId){
                    if(vNewContact.AccountId != null) {
                        vAccId.add(vNewContact.AccountId);
                    }
    
                }
        
                if(oldContact.AccountId != null){
                    vAccId.add(oldContact.AccountId);
                }
            }
        }
    }
    
    List<AggregateResult> vLstAggr = [SELECT sum(Amount_x__c) NoOfContacts,AccountId FROM Contact
    WHERE AccountId In :vAccId GROUP BY AccountId];


    Account vAcccount;
    list<Account> vLstAccounts = new list<Account>();

    for(AggregateResult vAggr : vLstAggr) {
        System.debug('Account Id'+vAggr.get('AccountId'));
        System.debug('AggregateResult valuesare'+vAggr.get('NoOfContacts'));

        string accId = (string) vAggr.get('AccountId');
        decimal countOfChild = (decimal) vAggr.get('NoOfContacts');

        vAcccount = new Account(Id = accId , Rollup_Amount_X__c= countOfChild);
        vLstAccounts.add(vAcccount);
    }

    update vLstAccounts;
}