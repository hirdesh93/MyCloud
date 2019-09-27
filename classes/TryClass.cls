public class TryClass {
    public List<Book_Category__c> bcc=[select id from Book_Category__c];
    Public static Map<string,List<Author__c>> show(){
        List<Author__c> acc=[select id,Name,Book_Category__c from Author__c];
        Map<string,List<Author__c>> accmap= new Map<string,List<Author__c>>();
        for(Author__c a: acc){
            if(!accmap.containsKey(a.Book_Category__c)){
               accmap.put(a.Book_Category__c, new List<Author__c>());
              }
                accmap.get(a.Book_Category__c).add(a);
        }
		system.debug('========'+accmap);
		return accmap;
        }
    }