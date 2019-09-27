public class DiplayRelatedContacts {
   public List<Account> accList{get;set;}
   public list<Contact> conList{get;set;}
   public String accId{get;set;}
   public DiplayRelatedContacts(){
       accList=[SELECT Id,Name,AccountNumber FROM Account];
   
   }
    public PageReference dispalyContact() {
       if(accId != null)
       conList=[SELECT id,FirstName,LastName FROM COntact WHERE AccountId=:accId];
        return null;
    }
}