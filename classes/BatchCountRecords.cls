global class BatchCountRecords implements Database.Batchable<sObject>, Database.Stateful {
    public String recordname= '';
    public String idd2 = '';
    public Integer count = -1;
    public string objectName = '';
    public Map<String,Integer> FieldMap{get;set;}
    public Field_Tracking__c TheRecord;
    global BatchCountRecords(String newObjectName,String name,String idd){
        FieldMap = new Map<String,Integer>();
        objectName = newObjectName;
        count = 0;
        recordname = name;
        idd2 = idd;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = '';
        String fieldss = '';
        if(Schema.sObjectType.Field_Analyse__c.fields.Field_API_Name__c.isAccessible() && Schema.sObjectType.Field_Tracking__c.fields.name.isAccessible()){
            TheRecord = DataBase.Query('select id,name,(select id,Field_API_Name__c from Field_Analysies__r) from Field_Tracking__c where id=\''+idd2+'\'');
            for(Field_Analyse__c fa : TheRecord.Field_Analysies__r){
                fieldss = fieldss+fa.Field_API_Name__c+',';
                FieldMap.put(fa.Field_API_Name__c , 0);
            }
            fieldss = fieldss.substring(0,fieldss.length()-1);
            query = 'SELECT '+fieldss+' FROM ' + objectName+' Where id !=null ';            
            return Database.getQueryLocator(query);
        }else{return null;}
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {   
        List<Field_Analyse__c> fan = new List<Field_Analyse__c>();
        for(Sobject ss : scope){      
            for(String str : FieldMap.keySet()){
                if(ss.get(str) != null){
                    FieldMap.put(str,FieldMap.get(str)+1);
                }
            }
        } 
        for(Field_Analyse__c fa : TheRecord.Field_Analysies__r){
            fa.Populated_On__c = FieldMap.get(fa.Field_API_Name__c);
            fan.add(fa);
        }
        if(Schema.SObjectType.Field_Analyse__c.isUpdateable() && fan.size() >0){
        	update fan; 
        }
        Field_Tracking__c obj = new Field_Tracking__c(); 
        obj.id = idd2;
        obj.Batch_Processed__c = true;
        if(Schema.SObjectType.Field_Tracking__c.isUpdateable() && String.isNotEmpty(obj.id)){
        	update obj; 
        }
    }
    global void finish(Database.BatchableContext BC) {
    }

}