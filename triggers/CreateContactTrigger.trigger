trigger CreateContactTrigger on User (after insert) {
    
    for (User u: trigger.new){
           createUserContact.createNewContact(Trigger.newMap.keySet());  
        }
}