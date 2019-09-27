public class UserLoginController {
    Public UserLoginController(){}
    @AuraEnabled
    public static void login(String username, String password) {
        system.debug(username);
        system.debug(password);
        try{
            Contact con = [select id , FirstName, LastName , Hirdesh93Org__UserName__c , Hirdesh93Org__Pass__c from Contact where Hirdesh93Org__UserName__c =: username AND Hirdesh93Org__Pass__c =: password limit 1];
            if(con != null){
                ApexPages.PageReference lgn = new PageReference('https://myorgtestdomain-dev-ed.my.salesforce.com/'+con.id);
                Aura.Redirect(lgn);
            }
        }
        catch (Exception ex) {
            //return ex.getMessage();            
        }
    }
}