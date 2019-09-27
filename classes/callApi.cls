public class callApi {

    public List<Data> data;// { get; set; }
    public String Response;
    public class Data {
        public String unique_id {get;set;}
        public String description {get;set;}
        public String title {get;set;}
    } 
    public void fetchmyData() {
        getAndParse('GET');
    }
    public void getAndParse(String GET) {//
        this.response = '{  "cache": true,  "data": [{"unique_id": "997991","description": "Scotland v United Arab Emirates 212/5 *","title": "Scotland v United Arab Emirates 212/5 *" }, {"unique_id": "1041859","description": "Amo Sharks v Speen Ghar Tigers","title": "Amo Sharks v Speen Ghar Tigers"    }], "provider": {"pubDate": "2016-08-12T20:58:21.776Z","source": "Various","url": "http://cricapi.com/" }}';
        callApi temp = parse(this.response);    
        this.data = temp.data; 
    }
    public List<Data> getData(){
        return this.data;
    }
    public static callApi parse(String json) {
        return (callApi) System.JSON.deserialize(json, callApi.class);
    }
}