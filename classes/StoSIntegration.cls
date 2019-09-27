public class StoSIntegration {
    public string jsonstring    {set;get;}
    public string url           {set;get;}
    public string clientId      {set;get;}
    public string clientSecret  {set;get;}
    public string userName      {set;get;}
    public string password      {set;get;}
    public string accesstoken   {set;get;}
    public List<String> names    {set;get;}
    Public StoSIntegration(){
        url='https://login.salesforce.com/services/oauth2/token';
    }
    public void submit(){
        Http p= new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        string body='grant_type=password ';
        body=body+'&client_id='+clientID;
        body=body+'&client_secret='+clientSecret;
        body=body+'&username='+userName;
        body=body+'&password='+password;
        request.setbody(body);
        HttpResponse response=p.send(request);
        jsonstring=response.getBody();
        System.JSONParser jp=JSON.createParser(jsonString);
        while(jp.nextToken()!=null){
            if(jp.getText()=='access_token'){
                jp.nextToken();
                accessToken=jp.getText();
            }
            
        }
    }
    public void getTabs(){
        names=new List<String>();
        Http p=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://ap2.salesforce.com/services/data/v43.0/tabs');
        request.setMethod('GET');
        request.setHeader('Authorization','OAuth '+accessToken);
        HttpResponse response=p.send(request);
        String result=response.getBody();
        System.JSONParser jp=JSON.createParser(result);
        while(jp.nextToken()!=null){
            if(jp.getText()=='sobjectName'){
                jp.nextToken();
                names.add(jp.getText());
            } 
        }
    }
}