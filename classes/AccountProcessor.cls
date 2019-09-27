public class AccountProcessor {
    @future
    public static void countContacts(string aId){
        List<Account> accList = [select id,Name ,Number_of_Contacts__c,(select id, LastName from Contacts) from account where Id =:aId];
        For(Account acc: accList){
            acc.Number_of_Contacts__c = acc.contacts.Size();
        }
        if(accList.size() > 0){
            update accList;
        }
    }

}