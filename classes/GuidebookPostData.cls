public class GuidebookPostData {
    public string apiKey 			{get;set;}
    public string QueryObject 		{get;set;}
    public string resp 				{get;set;}
    public boolean showData 		{get;set;}
    public string guidebody 		{get;set;}
    public string ObjectId 			{get;set;}
    public GuideResultClass wrapper	{get;set;}
    public string authorizationCode 		;
    
    public GuidebookPostData(){
        showData = false;
        apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlfa2V5Ijo2MzIsInN1YiI6NTI3NDY1NCwiYXVkIjoib3Blbl9hcGkifQ.UoY19EbajYD6XuSksWTRAbpU4aAyVz3nArcGxPJx0FA';
    }
    
    public void GuideBookData(){
        
        
        showData = true;
        authorizationCode = 'JWT '+apiKey;
        http ht = new http();
        
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Authorization', authorizationCode);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://builder.guidebook.com/open-api/v1/'+QueryObject+'/');
        req.setMethod('POST');
        req.setBody(guidebody);
     /*   Hirdesh93Org__Schedule_Item__c schList = [Select Hirdesh93Org__Description__c,Name,Hirdesh93Org__End_Date_Time__c,Hirdesh93Org__Guide__r.guide_Id__c from Hirdesh93Org__Schedule_Item__c  limit 1] ; 
        if(QueryObject == 'sessions' && QueryObject == null){
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeNumberField('guide',integer.valueOf(schList.Hirdesh93Org__Guide__r.guide_Id__c));
            gen.writeObjectField('description_html',schList.Hirdesh93Org__Description__c);
            gen.writeObjectField('name',schList.name);
            gen.writeEndObject();
            System.debug('jsonSessions'+gen.getAsString());
            req.setBody(gen.getAsString());
        }
        */
        httpResponse res = ht.send(req);
        resp = res.getBody(); 
    }
    
    public void GuideBookDataUpdate(){
        JSONParser parser = JSON.createParser(guidebody);   
        string s1 =guidebody.substringBetween(':',',');
        ObjectId = s1.trim();
        showData = true;
        authorizationCode = 'JWT '+apiKey;
        http ht = new http();
        
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Authorization', authorizationCode);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://builder.guidebook.com/open-api/v1/'+QueryObject+'/'+ObjectId+'/?api_Key='+apiKey);
        req.setMethod('PUT');
        req.setBody(guidebody);
        
        httpResponse res = ht.send(req);
        resp = res.getBody();
    }
    
    public class GuideResultClass{
        public list<results> results ;
    }
    public class results {
        public string id ;
        public string name ;
        public string description_html;
    }
}