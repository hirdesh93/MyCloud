public class GoogleAuthenticationWithSalesforce{
    //Fetched from URL
    private String code ;
    private string key = '450409091198-a0gh0fnr1p6hd6c188tbmiga74mokb42.apps.googleusercontent.com' ;
    private string secret = 'PuuQ9Gg3gjyHDylAo-YxOM1K' ;
    private string redirect_uri = 'https://myorgtestdomain-dev-ed--hirdesh93org.ap4.visual.force.com/apex/GoogleDrive' ;
    private string access_Token ;
    private list<string> fileList;
    public map<string , string> fileIdAndNameMapforAccount {get;set;}
    public list<string> bodyList ;
    public GoogleAuthenticationWithSalesforce()
    {
        bodyList = new List<String>();
        fileList = new List<string>();
        fileIdAndNameMapforAccount = new map<string , string>();
        code = ApexPages.currentPage().getParameters().get('code') ;
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken();
        }
    }
    
    public PageReference DriveAuth()
    {
        //Authenticating
        PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;
        return pg ;
    }
    
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri)
    {
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope=https://www.googleapis.com/auth/drive'+
            '&redirect_uri='+uri+
            '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+
            '&login_hint=engineergangil@gmail.com&'+
            'access_type=offline';
        return authuri;
    }
    
    
    public void AccessToken()
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        JSONParser parse = JSON.createParser(res.getBody());
        while(parse.nextToken() != null){
            if((parse.getCurrentToken() == JSONToken.FIELD_NAME) && parse.getText() == 'access_Token'){
                parse.nextToken();
                access_Token = parse.getText();
                system.debug('JsonToken'+access_Token);
                break;
            }
        }
        
        if(access_Token != null && access_Token != ''){
            ListFiles();
        } 
    } 
    
    public Map<string,string> fileProperties(){
        map<string , string> filePropertiesDetails = new  map<string ,string>();
        HttpRequest req2 = new HttpRequest();
        req2.setMethod('GET');
        req2.setEndPoint('https://www.googleapis.com/drive/v3/files');
        req2.setHeader('content-type','application/x-www-form-urlencoded');
        req2.setHeader('Content-length','0');
        req2.setHeader('Authorization','Bearer'+' '+access_token);
        req2.setTimeOut(60*1000);
        
        http h3 = new http();
        httpResponse res3 = h3.send(req2);
        system.debug('res3'+res3);
        JSONParser parse2 = JSON.createParser(res3.getBody());
        while(parse2.nextToken() != null){
            string fileName = '';
            string fileId = '';
            if(( parse2.getCurrentToken() == JSONToken.FIELD_NAME) ){
                if( parse2.getText() == 'id'){
                    parse2.nextToken();
                    fileId = parse2.getText();
                }
                
                if( parse2.getText() == 'name'){
                    parse2.nextToken();
                    fileName = parse2.getText();
                }
                filePropertiesDetails.put(fileId, fileName);
            }
        }
        return filePropertiesDetails;
    }
    
    public Pagereference ListFiles(){
        Hirdesh93Org__Google_Drive_Folder__c google = new Hirdesh93Org__Google_Drive_Folder__c();
        google = [select id , Hirdesh93Org__Folder_Id__c from Hirdesh93Org__Google_Drive_Folder__c where Name = 'Hirdesh Folder'];
        string folderId= google.Hirdesh93Org__Folder_Id__c ;
        
        HttpRequest req1 = new HttpRequest();
        req1.setMethod('GET');
        req1.setEndPoint('https://www.googleapis.com/drive/v2/files/'+folderId+'/children');
        req1.setHeader('content-type','application/x-www-form-urlencoded');
        req1.setHeader('Content-length','0');
        req1.setHeader('Authorization','Bearer'+' '+access_token);
        req1.setTimeOut(60*1000);
        
        http h2 = new http();
        httpResponse res2 = h2.send(req1);
        System.debug(' You can parse the response to get the access tokenNew ::: ' + res2.getBody());
        JSONParser parse1 = JSON.createParser(res2.getBody());
        
        system.debug('Json'+parse1);
        while(parse1.nextToken() != null){
            if(( parse1.getCurrentToken() == JSONToken.FIELD_NAME) && parse1.getText() == 'Id'){
                parse1.nextToken();
                fileList.add(parse1.getText());
            }
        }
        Map<string , string> fileIdAndNameMap = fileProperties();
        
        for(string s : fileList){
            fileIdAndNameMapforAccount.put(s,fileIdAndNameMap.get(s));
          }
       
        return null;   
    } 
    public void insertData(){
        Hirdesh93Org__Google_Drive_Folder__c google = new Hirdesh93Org__Google_Drive_Folder__c();
        google = [select id , Hirdesh93Org__Folder_Id__c from Hirdesh93Org__Google_Drive_Folder__c where Name = 'Hirdesh Folder'];
        string folderId= google.Hirdesh93Org__Folder_Id__c ;
        integer i = 1;
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://www.googleapis.com/drive/v2/files/'+ folderId +'/export?mimeType=vnd.google-apps.file');
        req.setHeader('content-type', 'text/plain');
        req.setHeader('Authorization','Bearer '+access_Token);
        req.setTimeout(60*1000);
        HttpResponse resp = http.send(req);
        bodyList.add(resp.getBody());
        List<attachment> attList = new List<attachment>();
        for(string s :bodyList){
            
			attachment att = new attachment();
            att.parentId = google.id;
            att.Body = blob.valueOf(s);
            att.Name = 'TestFile' + i;
     		
            attList.add(att);
            i++;
        }  
         if(attList.size() >0){
            insert attList;
        }
    }
}