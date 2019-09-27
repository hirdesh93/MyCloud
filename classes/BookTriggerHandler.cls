public class BookTriggerHandler {
    public void onAfterInsert(list<Book__c> lstbook){
        List<String> auth = new List<String>();
        Set<String> restricted = new Set<String>();
        for(Book__c bk:lstbook) {
            auth.add(bk.Author__c); 
            
        }
        AggregateResult[] groupedResults = [SELECT COUNT(Id),Author__c FROM Book__c where Author__c IN :auth GROUP BY Author__c];
        
        for(AggregateResult ar:groupedResults) {
            if((INTEGER)ar.get('expr0') > 5) {
                restricted.add((STRING)ar.get('Author__c'));
            }
        }
        for(Book__c bk1:lstbook) {
            if(restricted.contains(bk1.Author__c))
                bk1.addError('Author cannot have more than 5 books');
        }
    }
    public void onBeforeInsertAndUpdate(list<Book__c> lstbook){
        
        for(Book__c b : lstbook){
            if(b.Category__c =='Unknown'){
                b.addError('Category is Unknown');
            }
        }
        
    }
    
    public void onAfterInsertnew(list<Book__c> lstbook){
        Set<ID> setBookIds = new Set<ID>();
        Set<ID> setAuthorIds = new Set<ID>();
        for(Book__c b : lstbook){
            setBookIds.add(b.Id);
        }
        if(setBookIds.size() > 0){
            for(Book__c b : [SELECT Id,Author__c FROM Book__c WHERE Id IN :setBookIds]){
                setAuthorIds.add(b.Author__c);
            }
        }
        System.debug('=======' + setAuthorIds);
        if(setAuthorIds.size() > 0){
            List<Author__c> accUpdateList = new List<Author__c>();
            for(Author__c acc : [SELECT Id,Name,No_of_Books__c,(SELECT Id FROM Books__r) FROM Author__c WHERE Id IN :setAuthorIds]){
                acc.No_of_Books__c = acc.books__r.size();
                accUpdateList.add(acc);        
            }
            if(accUpdateList.size() > 0){
                update accUpdateList;
            } 
        } 
    }
    
    public static void OnAfterDelete(list<Book__c> oldbook){
        List<id> accIdList = new List<id>();
        For(Book__c con : oldbook){
            accIdList.add(con.Author__c);
        }
        
        List<Author__c> accUpdateList = new List<Author__c>();
        For(Author__c acc : [SELECT No_of_Books__c,(SELECT id FROM Books__r) FROM Author__c WHERE id IN: accIdList]){
            acc.No_of_Books__c = acc.Books__r.size();
            accUpdateList.add(acc);
        }
        update accUpdateList;
        
    }
    
    
}