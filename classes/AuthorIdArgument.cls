public class AuthorIdArgument {
	
	public static list<Book__c> AuthorIdArgumenta(String authorId){
		list<Book__c> data=[select id,name, Author__c from book__c where Author__c=: authorId];
       
        system.debug('test ' + data);
         return data;
	}	
}