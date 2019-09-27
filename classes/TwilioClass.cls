public class TwilioClass {
@future(callout= true)
    public static void processSms(string phNumber , string smsBody){  
        
        HttpRequest req = new HttpRequest();
        String VERSION  = '3.2.0';
        
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/ACe21366d60fbc85b051184e1a9b8a2325/Messages.json');
        req.setMethod('POST');
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(system.label.accountSid+':' +system.label.messageToken)));
        req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode('+18133640585','UTF-8')+'&Body='+smsBody);
        
        Http http = new Http();    
        HTTPResponse res = new HTTPResponse(); 
        res = http.send(req);
        res.getBody();
    }
}