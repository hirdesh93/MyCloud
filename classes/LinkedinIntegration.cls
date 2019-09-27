public class LinkedinIntegration {
    public string uri           {set;get;}
    public String clientId      {set;get;}
    public String clientSecret  {set;get;}
    public String code          {set;get;}
    public String accessToken   {set;get;}
    public String jsonString    {set;get;}
    public String state         {set;get;}
    public LinkedinIntegration(){
        uri='https://myorgtestdomain-dev-ed.my.salesforce.com/apex/LinkedinIntegration';
    }
    public PageReference getCodeData(){
        String url='https://www.linkedin.com/oauth/v2/authorization?';
        url=url+'response_type=code';
        url=url+'&client_id='+clientId;
        url=url+'&client_secret='+clientSecret;
        url=url+'&redirect_uri='+uri;
        url=url+'&state='+state;
        system.debug('response'+code);
        PageReference p=new PageReference(url);
        return p;

    }
     public void readCode(){
        code=ApexPages.currentPage().getParameters().get('code');
    }
    public void  getToken(){
        Http p=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://www.linkedin.com/oauth/v2/accessToken');
        request.setMethod('POST');
        String body='grant_type=authorization_code';
        body=body+'&client_id='+clientId;
        body=body+'&client_secret='+clientSecret;
        body=body+'&redirect_uri='+uri;
        body=body+'&code='+code;
        request.setBody(body);
        HttpResponse response=p.send(request);
        jsonString=response.getBody();
        System.JSONParser jp=JSON.createParser(jsonString);
        while(jp.nextToken()!=null){
            if(jp.getText()=='access_token'){
                jp.nextToken();
                accessToken=jp.getText();
            }
        }
    }
        }