public class NetSuiteIntegration {
  /*  Public Static void UpsertCustomer(List<Account> AccList){
        List<Account> ReturnedAccounts=new List<Account>();
        List<NetSuit_Logs__c> Logs=new List<NetSuit_Logs__c>();
        for(Account Acc : AccList){
            
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            String endpoint = 'https://608259.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=507&deploy=1';
            req.setEndpoint(endpoint);
            //Set Method and Endpoint and Body
            req.setMethod('POST');
            req.setTimeout(119990);
            Http http = new Http();
            String responseBody;
            req.setHeader('Content-Type','application/json');
            
            string NetSuiteProductionAccount = '608259';
            string NetSuiteProductionUserName = 'ashleyp@solvingit.com';
            string NetSuiteProductionPassword = 'Solvingit1';
            String authorizationheader = 'NLAuth nlauth_account='+NetSuiteProductionAccount+',nlauth_email='+NetSuiteProductionUserName+',nlauth_signature='+NetSuiteProductionPassword;
            
            //Construct Authorization and Content header
            req.setHeader('Authorization', authorizationHeader);
            
            // string recordType = 'customer';
            String Body='{"recordtype":"customer"';
            if(String.isNotBlank(Acc.billingCountryCode)){
                Body+=',"BillingCountry":"'+Acc.billingCountryCode+'"';
            }
            
            if(String.isNotBlank(Acc.BillingStreet)){
                Body+=',"BillingStreet":"'+Acc.BillingStreet+'"';
            }
            
            if(String.isNotBlank(Acc.BillingCity)){
                Body+=',"BillingCity":"'+Acc.BillingCity+'"';
            }
            
            if(String.isNotBlank(Acc.BillingStateCode)){
                Body+=',"BillingState":"'+Acc.BillingStateCode+'"';
            }
            
            if(String.isNotBlank(Acc.BillingPostalCode)){
                Body+=',"Billingzip":"'+Acc.BillingPostalCode+'"';
            }
            
            if(String.isNotBlank(Acc.ShippingCountryCode)){
                Body+=',"ShippingCountry":"'+Acc.ShippingCountryCode+'"';
            }
            
            if(String.isNotBlank(Acc.ShippingStreet)){
                Body+=',"ShippingStreet":"'+Acc.ShippingStreet+'"';
            }
            
            if(String.isNotBlank(Acc.ShippingStateCode)){
                Body+=',"ShippingState":"'+Acc.ShippingStateCode+'"';
            }
            
            if(String.isNotBlank(Acc.ShippingCity)){
                Body+=',"ShippingCity":"'+Acc.ShippingCity+'"';
            }
            
            if(String.isNotBlank(Acc.ShippingPostalCode)){
                Body+=',"ShippingPostalCode":"'+Acc.ShippingPostalCode+'"';
            }
            
            if(String.isNotBlank(Acc.Fax)){
                Body+=',"fax":"'+Acc.fax+'"';
            }
            
            if(String.isNotBlank(Acc.Phone)){
                Body+=',"phone":"'+Acc.Phone+'"';
            }
            
            if(String.isNotBlank(Acc.Name)){
                Body+=',"companyname":"'+Acc.Name+'"';
            }
            
            if(String.isNotBlank(Acc.NetSuite_Id__c)){
                Body+=',"id":"'+Acc.NetSuite_Id__c+'"';
            }
            
            if(String.isNotBlank(Acc.Website)){
                Body+=',"url":"'+Acc.Website+'"';
            }
            
            if(String.isNotBlank(Acc.Email__c)){
                Body+=',"email":"'+Acc.Email__c+'"';
            }
            
            if(String.isNotBlank(Acc.Alt_Phone__c)){
                Body+=',"altphone":"'+Acc.Alt_Phone__c+'"';
            }
            
            Body+='}';
            System.debug(Body);
            //you need the minimum field pattern for whatever entity you are posting, refer to their API guide
            req.setBody(Body);
            system.debug('setBody'+req);
            
            try {
                res = http.send(req);
                System.debug(res);
                responseBody = res.getBody();
                system.debug('responseBody'+responseBody);
                if(res.getStatusCode()==200 && res.getStatus()=='OK' && String.isNotBlank(responseBody) && responseBody.contains('id')){
                    JSON2Apex result = NetSuiteIntegration.parse(responseBody);
                    if(String.isNotBlank(result.id)){
                        Account returnedAccount=new Account();
                        returnedAccount.id=acc.Id;
                        returnedAccount.NetSuite_Id__c=result.id;
                        returnedAccount.Customer_Id__c=result.entityid;
                        ReturnedAccounts.add(returnedAccount);
                        
                    }
                    
                    NetSuit_Logs__c log=new NetSuit_Logs__c();
                    log.Status__c='Success';
                    log.Response_Code__c=String.ValueOf(res.getStatusCode());
                    log.Response_Body__c=responseBody;
                    log.Parent_Account__c=Acc.Id;
                    Logs.add(log);
                    
                }else if(res.getStatusCode()!=200){
                    JSON2ApexErrors result = NetSuiteIntegration.parseError(responseBody);
                    
                    NetSuit_Logs__c log=new NetSuit_Logs__c();
                    log.Status__c='Falied';
                    log.Response_Code__c=String.ValueOf(res.getStatusCode());
                    log.Response_Body__c=responseBody;
                    log.Parent_Account__c=Acc.Id;
                    log.Error_Code__c=result.error.code;
                    log.Error_Message__c=result.error.message;
                    Logs.add(log);
                }
            } catch(System.CalloutException e) {
                System.debug(res.toString());
            }
        }
        
        if(ReturnedAccounts.size()>0){
            try{
                update ReturnedAccounts;
            }Catch(exception e){
                System.debug('Update Failed');
            }
        }
        
        if(Logs.size()>0){
            try{
                insert Logs;
            }Catch(exception e){
                System.debug('Insert log Failed');
            }
        }
        
    }
    
    Public Static void DeleteRecord(){
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        String endpoint = 'https://608259.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=508&deploy=1&recordtype=customer&id=18353';
        req.setEndpoint(endpoint);
        //Set Method and Endpoint and Body
        req.setMethod('DELETE');
        req.setTimeout(119990);
        Http http = new Http();
        String responseBody;
        req.setHeader('Content-Type','application/json');
        
        string NetSuiteProductionAccount = '608259';
        string NetSuiteProductionUserName = 'ashleyp@solvingit.com';
        string NetSuiteProductionPassword = 'Solvingit1';
        String authorizationheader = 'NLAuth nlauth_account='+NetSuiteProductionAccount+',nlauth_email='+NetSuiteProductionUserName+',nlauth_signature='+NetSuiteProductionPassword;
        
        //Construct Authorization and Content header
        req.setHeader('Authorization', authorizationHeader);
        
        // string recordType = 'customer';
        
        //you need the minimum field pattern for whatever entity you are posting, refer to their API guide
        //req.setBody('{"recordtype":"customer","phone":"9555065911","companyname":"TestRestletAccount2","isperson":false,"id":"18351"}');
        system.debug('setBody'+req);
        
        try {
            res = http.send(req);
            responseBody = res.getBody();
            system.debug('responseBody'+responseBody);
        } catch(System.CalloutException e) {System.debug(res.toString());}
    }
    
    
    public class JSON2Apex {
        public Boolean custentity_2663_direct_debit {get;set;} 
        public String defaultaddress {get;set;} 
        public String weblead {get;set;} 
        public Boolean emailtransactions {get;set;} 
        public String entityid {get;set;} 
        public Boolean custentity_2663_customer_refund {get;set;} 
        public Boolean isbudgetapproved {get;set;} 
        public Boolean isperson {get;set;} 
        public String recordtype {get;set;} 
        public String id {get;set;} 
        public Boolean taxable {get;set;} 
        public String lastmodifieddate {get;set;} 
        public Boolean faxtransactions {get;set;} 
        public String datecreated {get;set;} 
        public Boolean printtransactions {get;set;} 
        public String custentity_esc_last_modified_date {get;set;} 
        
        public Boolean taxexempt {get;set;} 
        public String url {get;set;} 
        
        public String phone {get;set;} 
        public String companyname {get;set;} 
        public Boolean custentity_naw_trans_need_approval {get;set;} 
        public Boolean shipcomplete {get;set;} 
        
        
    }
    
    public static JSON2Apex parse(String json) {
        return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
    }
    
    public class JSON2ApexErrors {
        public Error error;
    }
    
    public class Error {
    public String code;
    public String message;
  }
    
    public static JSON2ApexErrors parseError(String json) {
    return (JSON2ApexErrors) System.JSON.deserialize(json, JSON2ApexErrors.class);
  }
    
}




==================

trigger countProductsonAccount on OpportunityLineItem (after insert,after update, after delete) {
    set<Id> oppId= new set<Id>();
    set<Id> accId= new set<Id>();
    List<Account> accList= new List<Account>();
    Set<String> ProductSet = new Set<String>();
    Map<Id,List<OpportunityLineItem>> OppOLIMap = new Map<Id,List<OpportunityLineItem>>();
    if(Trigger.isInsert){
        for(OpportunityLineItem OLI: Trigger.new)
            oppId.add(OLI.OpportunityId);
    }  
    if(Trigger.IsDelete ||Trigger.IsUpdate){
        for(OpportunityLineItem OLI: Trigger.Old)
			oppId.add(OLI.OpportunityId);
    }      
    for(Opportunity Opp: [select id,AccountId from Opportunity where Id in:oppId])
       accId.add(Opp.AccountId);  
    for(Opportunity Opp: [select id,Name,AccountId,Account.Product_Count__c,(select id,Name,Product2Id from OpportunityLineItems) from Opportunity where AccountId in:accId]){
       accId.add(Opp.AccountId);
       if(opp.OpportunityLineItems.size()>0)
	       OppOLIMap.put(opp.id,opp.OpportunityLineItems);
    }    
    for(Account acc:[select id,Product_Count__c,(select id from Opportunities) from Account where id in:accId]){    
		ProductSet = new Set<String>();
		for(Opportunity opp : acc.Opportunities){                                        
			if(OppOLIMap.containskey(Opp.id)){
				for(OpportunityLineItem OLI:OppOLIMap.get(Opp.id))
					ProductSet.add(OLI.Product2Id); 
			}
		}
		acc.Product_Count__c = ProductSet.size();   
		Acclist.add(acc);       
    }
    if(Acclist.size()>0)
        update Acclist;


======================
*/
    }