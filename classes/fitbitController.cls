global class fitbitController {
    Public static string responseBody ;
    Public static list<string> lists;
    Public static string p ;
    
    webservice static void updateFieldOnAccount(Id aId){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        req.setEndpoint('callout:Fitbit/1/user/-/profile.json');
        HttpResponse res ;
        if(req != null){
           res = http.send(req);
        
        }
        system.debug('testResp' + res);
        responseBody = res.getbody();
        System.debug('response:' + res);
        System.debug('response:' + res.getbody());
     
        string s = responseBody; //string.valueOf(JSON.serialize(jsonData));
        lists = s.split(',');
        system.debug('lists**'+lists);
        for(string l : lists){
            if(l.contains('height')){
                p=l;
            }
            
        }
        system.debug('serielize**'+s);
        system.debug('actualP **'+p);
        
        double CurrentP = double.valueof(p.remove('"CAD":'));
        system.debug('test**'+ CurrentP);
    /*    Account acc =  [SELECT Id,Name ,CurrentPrice__c , CurrentDate__c FROM Account where Id =: aId];
        
        acc.CurrentPrice__c = CurrentP;
        acc.CurrentDate__c = system.today();
        update acc;  
*/
        
    }
}