public with sharing class SendMessageTwilio {
    @future
    public static void processSms(string phNumber , string smsBody){  
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+system.label.accountSid+'/Messages.json');
        req.setMethod('POST');
        String VERSION  = '3.2.0';
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(system.label.accountSid+':' +system.label.messageToken)));
        req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(system.label.fromPhNumber,'UTF-8')+'&Body='+smsBody);
        
        Http http = new Http();    
        HTTPResponse res = new HTTPResponse(); 
            res = http.send(req);
            //responseinapex =  JSON2Apex.parse(res.getBody());
        res.getBody();
      //  return null;
    }
}