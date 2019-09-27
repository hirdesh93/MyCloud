global with sharing class DescibeDemoController{

    public DescibeDemoController(ApexPages.StandardController controller) {
        listField = new List<FieldWrapper>();
    }

    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public String selectedObject {get; set;}
    public List<FieldWrapper> listField {get; set;}
    public Field_Tracking__c fieldtracking {get; set;}
    public String tripName{get; set;}
    public integer FieldCount  {get; set;} 
    public DescibeDemoController() {
        listField = new List<FieldWrapper>();
        
    }
    
    // find all sObjects available in the organization
    
    public  List<SelectOption> getListObjectName(){
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities)
            objNames.add(new SelectOption(name,name));
        return objNames;
    }
    /* <---> Find the fields for the selected object   <--->  */
    public void showFields(){
        listField.clear();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(selectedObject).getDescribe().fields.getMap();
        for(Schema.SObjectField sfield : fieldMap.Values()){
            schema.describefieldresult dfield = sfield.getDescribe();
            FieldWrapper wObj = new FieldWrapper();
            wObj.fieldName = dfield.getLabel ();
            wObj.fieldAPIName = dfield.getname();
            wobj.fieldlength = dfield.getLength();
            wObj.fieldTypeName = dfield.getType();
            listField.add(wObj);
        }
        FieldCount = listField.size();
    }
    
    /* <---> save data as a record in a  <--->  */ 
    
    public pagereference SaveRecords(){
        
        String objectName = selectedobject;
        selectedobject = String.escapeSingleQuotes(selectedobject);
        List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(new List<String>{objectName}); // this can accept list of strings, we describe only one object here
        String objectLabel = describeSobjectsResult[0].getLabel();
        integer rt = Database.countQuery('SELECT Count() FROM RecordType WHERE SObjectType=\''+selectedObject+'\'');
        fieldtracking = new Field_Tracking__c();
        List<Field_Analyse__c> falist = new List<Field_Analyse__c>();
        integer nor = database.countQuery('select count() from '+selectedobject);
        showFields();
        fieldtracking.name = tripName ;
        fieldtracking.Object_Name__c= selectedObject;
        fieldtracking.Records__c = nor;
        fieldtracking.custom__c = false;
        fieldtracking.Record_Types__c = rt +1;
        fieldtracking.Object_Label__c = objectLabel;
        
        if(String.isNotEmpty(selectedobject) && selectedobject.endsWith('__c')){
                fieldtracking.Custom__c = true;
        }              
        insert fieldtracking;
        
        for(FieldWrapper wrp : listField){            
            Field_Analyse__c fa = new Field_Analyse__c();
            fa.name = wrp.fieldName;
            fa.Field_Tracking__c = fieldtracking.id;
            fa.Custom__c = false;
            fa.Field_API_Name__c = wrp.fieldAPIName;
            fa.Type__c = String.valueOf(wrp.fieldTypeName);
            fa.Field_Length__c = wrp.fieldlength > 0 ? wrp.fieldlength : null;
            if(String.isNotEmpty(wrp.fieldAPIName) && wrp.fieldAPIName.endsWith('__c')){
                fa.Custom__c = true;
            }
            fa.Label__c = wrp.fieldName;           
            falist.add(fa);
        }
        
        insert falist; 
        PageReference redirect = new PageReference('/' + fieldtracking.Id);
        return redirect;
    }
    public PageReference Cancel() {
        return null;
    }   
    public class FieldWrapper{
        public String fieldName {get; set;}
        public String fieldAPIName {get; set;}
        public Integer fieldlength  {get;set;}
        public DisplayType fieldTypeName  {get;set;}
    }
}