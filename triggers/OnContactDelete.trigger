Trigger OnContactDelete on Contact (before delete) {
   Set<ID> accountIds = new Set<ID>(); //all accounts that contacts are being deleted from
   for (Contact contact : Trigger.old) {
       accountIds.add(contact.AccountId);
   }

   List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds]; //get all of the contacts for all of the affected accounts

   Map<ID, Set<ID>> deleteMap = new Map<ID, Set<ID>>(); //map an account ID to a set of contact IDs being deleted
   Map<ID, Set<ID>> foundMap = new Map<ID, Set<ID>>(); //map an account ID to a set of contact IDs that were found by the query

   for (Contact deleteContact : Trigger.old) {
     Set<ID> idSet = deleteMap.get(deleteContact.AccountId);
     if (idSet == null) {
       idSet = new Set<ID>();
     }

     idSet.add(deleteContact.Id);
     deleteMap.put(deleteContact.AccountId, idSet);
   }

   for (Contact foundContact : contacts) {
     Set<ID> idSet = foundMap.get(foundContact.AccountId);
     if (idSet == null) {
       idSet = new Set<ID>();
     }

     idSet.add(foundContact.Id);
     foundMap.put(foundContact.AccountId, idSet);
   }

   for (ID accountId : accountIds) { //go through each affected account
     Set<ID> deleteIds = deleteMap.get(accountId);
     Set<ID> foundIds = foundMap.get(accountId);

     if (deleteIds != null && foundIds != null && deleteIds.containsAll(foundIds)) {
       for (Contact contact : Trigger.old) {
         if (deleteIds.contains(contact.Id)) { //this is one of the contacts being deleted
           contact.addError('This contact is potentially the last contact for its account and cannot be deleted');
         }
       }
     }
   }
 }