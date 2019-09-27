@RestResource(urlMapping='/hirdeshgangil/v1/*')
global with sharing class hirdeshAccRestAPI{
    @HttpPost
    global static String attachGirdesh(){
        List<Account> accList = new List<Account>();
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
     //   String fName = req.params.get('FileName');
      //  String parId = req.params.get('parId');
        String data = req.requestBody.toString(); 
       	List<AccountClass> newList = (List<AccountClass>)System.JSON.deSerialize(data,List<AccountClass>.class);
        for(AccountClass acl : newList){
            Account acc = new account();
            acc.name = acl.name;
            acc.phone=acl.phone;
            acc.industry = acl.industry;
            accList.add(acc);
        }
        DataBase.SaveResult[] ds;
           // Database.insert(accList,false);
            ds = Database.insert(accList,false);
            JsonErrorResponse__c je = new JsonErrorResponse__c();
            je.Result__c = String.valueOf(ds);
            insert je;
        
        /*catch(Exception e){
            JsonErrorResponse__c je = new JsonErrorResponse__c();
            je.Error__c =e.getMessage();
            system.debug('testerror' + je.Error__c);
            je.Result__c = String.valueOf(ds);
            insert je;
        } */
        return null;
   }
    public class AccountClass2{
        List<AccountClass> newlist{get;set;}
   }
   public class AccountClass{
       String name{get;set;}
       String phone{get;set;}
       String industry{get;set;}
   }
}