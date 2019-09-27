public class HirdeshGenerateJson {
    public HirdeshGenerateJson(){
        
        list<account> accList = [select id, name, phone , industry from account ];
        String jsonstring = Json.serialize(accList);   
        system.debug('testjson'+jsonstring);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String url = 'https://myorgtestdomain-dev-ed.my.salesforce.com/services/oauth2/token';
        String client_id = '3MVG9YDQS5WtC11raoKSdyiGu_9NWZPDihuqeP9gd9nmn3k7XkUMk5vI8vmgnySOyT7cmZ6KhYw==';
        String client_secret = '8900669299340807020';
        String username = 'hirdesh@mycloud.com';  
        String password = '@shanku123zu90MHmxmH5TR8DL0hud5tetq';
        String body = 'grant_type=password&client_id=' + client_id + '&client_secret=' + client_secret + '&username=' + username + '&password=' + password;
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setbody(body);
        HTTPResponse resp = http.send(req);
        system.debug('resp'+resp);
         
        
    }
    
}