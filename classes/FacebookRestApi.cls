public class FacebookRestApi {
    public string id1 {get;set;}
    public string name1 {get;set;}
    public string website1 {get;set;}
    public integer fancount1 {get;set;}
    public FacebookRestApi(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://graph.facebook.com/2073185842779655?fields=id,name&access_token=EAADzw3nJYUcBAOtYAAHkZB1jvy2oAhu2o8k2zwrjXk102dTTul0wIHGnybqQlSx9XI0aHWdm0BXPkKpELDiV69oZBDxp5rqROkGzlCLZBtZA5oJz9wkz1ekccsBgnT9YpzIrLb8oKV22VCfcATq6WkZAZARcNH90V1JnYAi0qEGQj7ZA8aXxu1dTivmzMwQbpfcYOGBcYuulAZDZD');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        string str = res.getBody();
        system.debug(str);
        JSON2Apex myClass=JSON2Apex.parseData(res.getBody());
        id1 = myClass.id;
        name1 = myClass.name;
        website1 = myClass.website;
        fancount1 = myClass.fan_count;
        
    }
}