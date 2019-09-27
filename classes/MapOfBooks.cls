public class MapOfBooks {
	public list<Author__c> lst=[select id from Author__c];
	
	public static Map<String,List<Book__c>>  mydata(){
		 List<Book__c> lstbook= [select id, name,Author__c from Book__c];
		
		Map<String,List<Book__c>> mymap=new Map<String,List<Book__c>>();		
		for(Book__c b : lstbook){
            if(!mymap.containsKey(b.Author__c)){
                mymap.put(b.Author__c, new List<Book__c>());
            }
            mymap.get(b.Author__c).add(b);
		}
		system.debug('========'+mymap);
		return mymap;	
	
	}
    
}