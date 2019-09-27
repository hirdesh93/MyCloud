public class GuideBookGetData {
    public string apiKey 				{get;set;}
    public GuideResultClass wrapper		{get;set;}
    public SessionsResultClass sessionswrapper {get;set;}
    public string QueryObject 			{get;set;}
    public string resp 					{get;set;}
    public boolean showData 			{get;set;}
    public list<Guide__c> guideList				;
    public list<Hirdesh93Org__Schedule_Item__c> sessionList;
    public string JsonGuideResult 				;
    public string authorizationCode 			;
    
    public GuideBookGetData(){
        guideList = new List<Guide__c>();
        sessionList = new List<Hirdesh93Org__Schedule_Item__c>();
        showData = false;
    }
    
    public void GuideBookData(){
        showData = true;
        authorizationCode = 'JWT '+apiKey;
        http ht = new http();
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationCode);
        req.setEndpoint('https://builder.guidebook.com/open-api/v1/'+QueryObject+'/?api_Key='+apiKey);
        req.setMethod('GET');
        
        httpResponse res = ht.send(req);
        resp = res.getBody();
        system.debug(resp);
        
        if(QueryObject == 'guides'){
        wrapper = (GuideResultClass)JSON.deserialize(resp, GuideResultClass.class);
        if(wrapper.results.size() >0 && wrapper.results != null){
            for(results s1: wrapper.results){
                Guide__c guide = new Guide__c();
                guide.Guide_Id__c = s1.id;
                guide.Name = s1.name;
                guide.Description_html__c = s1.description_html;
                guideList.add(guide);
            }
        }
        if(guideList.size() >0)
            try{
                upsert guideList Guide_Id__c;
            }catch(exception e){}
        }
        
       if(QueryObject == 'sessions'){
        string guideid ;
        Map<String,guide__c> mapGuide = new Map<String,guide__c>();
        system.debug(mapGuide);
        sessionswrapper = (SessionsResultClass)JSON.deserialize(resp, SessionsResultClass.class);
            if(sessionswrapper.results.size() >0 && sessionswrapper.results != null){
                for(sessionsResults s1 : sessionswrapper.results){
                    Hirdesh93Org__Schedule_Item__c sch = new Hirdesh93Org__Schedule_Item__c();
                    sch.Hirdesh93Org__Session_Id__c = s1.id;
                    sch.Hirdesh93Org__Description__c = s1.description_html;
                    sch.Name = s1.name;
                    
                    guideid = s1.guide;
                    sessionList.add(sch);
                }
            }
           guide__c  guideObject= [select id , name from guide__c where guide_id__c =: guideId];
           if(sessionList.size() >0)
            try{
                upsert sessionList Hirdesh93Org__Session_Id__c;
            }catch(exception e){}
        }
        }
    public class GuideResultClass{
        public list<results> results ;
    }
    public class results {
        public string id ;
        public string name ;
        public string description_html;
    }
    
    public class SessionsResultClass{
        public list<sessionsResults> results ;
    }
    public class sessionsResults {
        public string id ;
        public string name ;
        public string guide ;
        public string description_html;
    }
}