public class sendDataToGoogleDrive {
	private String code ;
    private string key = '450409091198-a0gh0fnr1p6hd6c188tbmiga74mokb42.apps.googleusercontent.com' ;
    private string secret = 'PuuQ9Gg3gjyHDylAo-YxOM1K' ;
    private string redirect_uri = 'https://myorgtestdomain-dev-ed--hirdesh93org.ap4.visual.force.com/apex/GoogleDrive' ;
    private string access_Token ;
    
    public sendDataToGoogleDrive()
    {
       // fileList = new List<string>();
       // fileIdAndNameMapforAccount = new map<string , string>();
        code = ApexPages.currentPage().getParameters().get('code') ;
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken();
        }
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
            UploadFiles();
        } 
    } 
    public void UploadFiles(){
       String boundary = '----------9889464542212';
       String delimiter = '\r\n--' + boundary +'\r\n';
       String close_delim = '\r\n--' + boundary + '--';
       ApexPages.PageReference report = new ApexPages.PageReference('https://myorgtestdomain-dev-ed.my.salesforce.com/0016F00002M02iA?export=0&enc=UTF-8&xf=csv');
       
       String before='';      
       //Get the folder ID having file
       Hirdesh93Org__Google_Drive_Folder__c g=new Hirdesh93Org__Google_Drive_Folder__c();
       g=[SELECT Folder_Id__c FROM Hirdesh93Org__Google_Drive_Folder__c WHERE Name=:'Hirdesh Folder'];
       String FolderId=g.Folder_Id__c; 
       
       // create a blob from our parameter value before we send it as part of the url
       Blob beforeblob = Blob.valueOf(before);
       String bodyEncoded = EncodingUtil.base64Encode(beforeblob);
       String filename='Sample_fileNameWithoutExtension';
       String filetype='text/csv';
       String body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+ ' "mimeType" : "'+ filetype+ '",' + '"parents":[{"id":"'+ FolderId +'"}] }'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
       Http http = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart&convert=true');
       req.setHeader('Authorization', 'Bearer ' +access_token);
       req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"');
       req.setHeader('Content-length', String.valueOf(body.length()));
       req.setBody(body);
       req.setMethod('POST');
       req.setTimeout(60*1000);
       HttpResponse resp = http.send(req);
       filetype='';
       filename='';
    }
}