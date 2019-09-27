global class UpdateFieldsByFixer {
    Public static string responseBody ;
    Public static list<string> lists;
    Public static string p ;
    //  public static Id aId ;
    
    webservice static void updateFieldOnAccount(Id aId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint('http://data.fixer.io/api/latest?access_key=4acd418bc2d30b273e2ddb3388ad362a');
        request.setMethod('GET');
        request.setTimeout(120000);
        request.setHeader('Content-Type','application/json');
        request.setCompressed(False);
        System.Debug('testrequest : '+request);
        if(request != null)
            response= http.send(request);
        system.debug('testResp' + response);
        
        responseBody = response.getbody();
        System.debug('response:' + response);
        System.debug('response:' + response.getbody());
        
        string s = responseBody; //string.valueOf(JSON.serialize(jsonData));
        lists = s.split(',');
        system.debug('lists**'+lists);
        for(string l : lists){
            if(l.contains('CAD')){
                p=l;
            }
            
        }
        system.debug('serielize**'+s);
     //   system.debug('actualP **'+p);
        
        double CurrentP = double.valueof(p.remove('"CAD":'));
        system.debug('test**'+ CurrentP);
        Account acc =  [SELECT Id,Name ,CurrentPrice__c , CurrentDate__c FROM Account where Id =: aId];
        
        acc.CurrentPrice__c = CurrentP;
        acc.CurrentDate__c = system.today();
        update acc;  
        
    }
    
}