public class triggerHandlercontact{
    public void updateFieldOnAccount(List<Contact> ConList , Map<Id, Contact> oldMap){
        set<Id> setAccIds = new set<Id>();
        for(Contact con : ConList){
            if(con.AccountId != null){
                setAccIds.add(con.AccountId);
            }
            if(oldMap != null && con.AccountId != oldMap.get(con.Id).AccountId){
                setAccIds.add(oldMap.get(con.Id).AccountId);
            }
        }
        List<Account> accList = [Select Id, Name ,contacts__c,(Select AccountId from Contacts limit 1)
                                 from Account where Id In: setAccIds ];
        
        if(setAccIds.size() > 0){
            for(Account acc : accList){
                if(acc.contacts.size() > 0){
                    acc.Contacts__c = true;
                    
                }
                if(acc.Contacts.size() == 0){
                    acc.Contacts__c= false;
                }
            }
        }
        if(accList.size() > 0){
            update accList;
        }  
    }
    public void updateFieldOnAccountNew(List<Contact> ConlistNew ){
        List<Id> setAccIds = new List<Id>();
        for(Contact con : ConlistNew){
            if(con.AccountId != null){
                setAccIds.add(con.AccountId);
            }
        }
        List<Account> accList = [Select Id, Name ,contacts__c,(Select AccountId from Contacts)
                                 from Account where Id In: setAccIds ];
        if(setAccIds.size() > 0){
            for(Account acc : accList){
                if(acc.contacts.size() > 0){
                    acc.No_Of_Count__c = acc.Contacts.size();
                }
            }
            if(accList.size() > 0){
                update accList;
            } 
        }
    }
    public void duplicateContact(List<Contact> conList){
        //sets to store values to check for duplicates
        set<String> firstNameSet = new set<String>();
        set<String> lastNameSet = new set<String>();
        
        //Add the values to the set
        for(Contact con : conList){
            if(con.FirstName != null && con.FirstName != ''){
                firstNameSet.add(con.FirstName);
                lastNameSet.add(con.LastName );
            }
        }
        //Construct the query dynamically
        String queryString = 'select FirstName , LastName, AccountId , Email from Contact where LastName IN : lastNameSet' ;
        
        if(firstNameSet.size() > 0){
            queryString = queryString + ' AND FirstName IN : firstNameSet ';
        }
        //List to store records that matches the criteria
        List<Contact> existingContactList = database.query(queryString );
        //Check whether any duplicated are there
        //If present show error
        /**  if(existingContactList.size() > 0){
for(Contact newContact : Trigger.new){
for(Contact exisitingContact : existingContactList ){
if((newContact.FirstName == exisitingContact.FirstName)&&(newContact.LastName == exisitingContact.LastName)){
//    newContact.addError('Duplicate contact');
newContact.FirstName = exisitingContact.FirstName;
newContact.LastName = exisitingContact.LastName;
newContact.AccountId = exisitingContact.AccountId;
newContact.Email = exisitingContact.Email;
}
}
}
}
if(firstNameSet.size() > 0 && LastNameSet.size() > 0){
delete existingContactList;
} **/
        if(existingContactList.size() > 0){
            for(Contact newContact : conList){
                for(Contact exisitingContact : existingContactList ){
                    if((newContact.FirstName == exisitingContact.FirstName)&&(newContact.LastName == exisitingContact.LastName)){
                        newContact.addError('Duplicate contact Record Found');
                    }
                }
            }
        }
    }
    public void AccountCreateByContact(List<Contact> conList){
        List<Account> accList = new List<Account>();
        
        for(contact con: conList){
            account acc = new account();
            acc.Name = con.FirstName +' '+con.LastName + ' ' +'Household';
            accList.add(acc);
        }
        if(accList.size() > 0){
            insert accList;
        }
        List<Contact> conList1 = new List<Contact>();
        for(Account acc : accList){
            for(contact con : conList){
                con.AccountId = acc.Id;
            }
        }
    }
}