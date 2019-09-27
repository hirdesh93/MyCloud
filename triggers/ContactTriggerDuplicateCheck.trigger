trigger ContactTriggerDuplicateCheck on Contact (before insert ) {
    
    //sets to store values to check for duplicates
    set<String> firstNameSet = new set<String>();
    set<String> lastNameSet = new set<String>();
    
    //Add the values to the set
    for(Contact con : Trigger.new){
        
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
        for(Contact newContact : Trigger.new){
            for(Contact exisitingContact : existingContactList ){
                if((newContact.FirstName == exisitingContact.FirstName)&&(newContact.LastName == exisitingContact.LastName)){
                    newContact.addError('Duplicate contact Record Found');
                }
            }
        }
    }
}