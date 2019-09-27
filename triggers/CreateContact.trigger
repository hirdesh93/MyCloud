trigger CreateContact on Case (before insert) {
 List<String> emailAddresses = new List<String>();
 Set<String> takenEmails = new Set<String>();
 Map<String,Contact> emailToContactMap = new Map<String,Contact>();
 List<Case> casesToUpdate = new List<Case>();
 List<Contact> listContacts=new List<Contact>();
 List<Contact> newContacts=new List<Contact>(); 
 
     for (Case caseObj:Trigger.new) {
        if (caseObj.ContactId==null && caseObj.SuppliedEmail !=''){
            emailAddresses.add(caseObj.SuppliedEmail);
            casesToUpdate.add(caseObj);
        }
     }
     
     for(Contact con:[Select Id,Email From Contact Where Email in :emailAddresses]){
         emailToContactMap.put(con.Email,con);
     }
     
     for (Case caseObj:Trigger.new){
        if (caseObj.ContactId==null && String.isNotBlank(caseObj.SuppliedName) && String.isNotBlank(caseObj.SuppliedEmail) && !emailToContactMap.containskey(caseObj.SuppliedEmail)){   
            String[] nameParts = caseObj.SuppliedName.split(' ',2);
            Contact cont = new Contact();
            cont.Email=caseObj.SuppliedEmail;
            if (nameParts.size() == 1){
                cont.LastName=nameParts[0];
            }
            else if (nameParts.size() == 2){
                cont.FirstName=nameParts[0];
                cont.LastName=nameParts[1];
            }
            
                newContacts.add(cont);
                emailToContactMap.put(caseObj.SuppliedEmail,cont);
                casesToUpdate.add(caseObj);
        }
    }
        if(newContacts.size()>0){
        try{
            insert newContacts;
            }catch(DmlException e){
             Contact Con =new Contact();
             Con.LastName='testCase';
             Con.Description= e.getMessage();
                insert Con;
            }
        }
     for (Case caseObj:casesToUpdate) {
        Contact newContact = emailToContactMap.get(caseObj.SuppliedEmail);
        caseObj.ContactId = newContact.Id;
     }
}