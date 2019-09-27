public class AccountCreateLightening {
    @AuraEnabled
    public static  Contact getContact(ID conId){
        return [select id, LastName , Account.Name , Account.Industry , Account.Phone, Account.Website from contact where Id =: conId];
    } 
    @Auraenabled
    public static Id creatLeadRecord(Account acc){
        upsert acc;
        return acc.id;
    }
    @AuraEnabled
    public static void createRecord (Account acc){
        
        try{
            System.debug('CreateRecordAccount::createRecord::acc'+acc);
            if(acc != null){
                insert acc;
            }
        } catch (Exception ex){
        }
    }
}