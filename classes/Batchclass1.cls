public class Batchclass1 implements Database.Batchable<sobject>{
    public final String Query;
    public final Map<String, String> fieldValues;
    public Batchclass1(String q, Map<String, String> fieldValues){
        Query = q;
        this.fieldValues = fieldValues;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Account> scope){  
        for(sobject s : scope){
            for(String Industry : fieldValues.keySet()) {
                s.put(Industry, fieldValues.get(Industry));
            }
        }
        
        update scope;
    }
    public void finish(Database.BatchableContext BC){
        
    }
}