public class testLightning {
	
    @AuraEnabled
    public static opportunity getAccList(String accId){
        opportunity acc = [select id,name,amount,account.name from opportunity where id=:accId];
        system.debug('acc:' + acc);
        return acc;
    }
}