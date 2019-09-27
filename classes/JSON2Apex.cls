public class JSON2Apex {
	public string id;
    public string name;
    public string website;
    public integer fan_count;
    public Posts posts;
    
    public class Paging {
        public Cursors cursors;
        public string next;
    }
    
    public class Posts{
        public list<Data> data;
        public Paging paging;
        
    }
    public class Cursors {
        public string before;
        public string afert;
    }
    public class Data {
		public string id;
        public string story;
        public string message;
        public string created_time;
    }
    
    public static JSON2Apex parseData(String json){
        return (JSON2Apex)system.JSON.deserialize(json,JSON2Apex.class);
    }
}