public class dynamicApex5 {
    
    public list<SelectOption> selectedobject { get; set; }
    public List<sObject> lstObjs {get;set;}
    public String objectName { get; set; }    
    public set<string> flds{get;set;}
    public string query{get;set;}
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    //Pagination working++++++++++++++++++++++++++++++++++++++++++++++++++++++++//  
    public boolean b{get;set;}    
    public boolean PickilistFlag{get;set;} 
    public boolean ListFlag{get;set;}
    public integer counter=0;
    public integer isize;
    public integer pagecount{get;set;} 
    public integer Totalsize{get;set;}
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
    set<string> leftvalues=new set<string>();   
    List<Selectoption> addremoveoption= new List<Selectoption>();
    public dynamicApex5(){
        PickilistFlag = false;
        ListFlag = false;
        b=false; 
        isize=10; 
        Totalsize=0;
        selectedobject = new list<SelectOption>();  
        selectedobject.add(new selectoption('','-None-'));
        list<schema.SobjectType> lst=schemaMap.values();
        for(schema.SobjectType ss:lst){
            selectedobject.add(new selectoption(ss.getDescribe().getLocalName(),ss.getDescribe().getLabel()));
            selectedobject.sort();
            
        }
        flds= new set<string>();
        lsps=new list<SelectOption>();
        
        //lstObjs = Database.query(query);
    }
    
    
    public list<String> fields {get; set;}
    
    public list<SelectOption> lsps{get;set;}
    
    public void function() {
        PickilistFlag = true;
        lsps.clear();
        if(objectName!=null || objectName!=''){
            Map<string,Schema.SObjectField> mpConField=schemaMap.get(objectName).getDescribe().fields.getMap();
            flds=mpConField.keySet();
            
            for(string name:flds){
                Schema.DescribeFieldResult fldResult=mpConField.get(name).getDescribe();
                lsps.add(new SelectOption(fldResult.getName(),fldResult.getLabel()));
                lsps.sort();                    
            }
        } 
    }
    
    public void SelecFields(){
        ListFlag = true;
        b=true;
        try{
            string k=''+fields;
            // system.debug('^^^^^^^^^^^^^^^'+fields.size());
            query = 'Select ' + k.subStringBetween('(',')')+ ' from ' + objectName  + ' limit '+ isize  +' offset  '+counter; //Dynamic query//
            System.debug('**************: ' + query);
            string countquery='select count() from  '+ objectName;
            Totalsize=database.countquery(countquery);
            system.debug('$$$$$'+countquery);
            system.debug('&&&&&&'+Totalsize);
            if(fields.size()<=10){               
                lstObjs = Database.query(query);
            }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select less fields');
                ApexPages.addMessage(myMsg);
            }
            
            system.debug('@@@@@@@@'+lstObjs );
        }catch(exception e){
            
        }
        
    }  
    public List<sObject> getsObjList(){
        SelecFields();
        
        List<sobject> listSoch  = new list<sobject>();
        listSoch  = lstObjs ;
        pagecount = counter + listSoch.size(); 
        return listSoch ;
        
    }       
    public PageReference nextpage(){
        counter+= isize;  
        return null;
        
    }
    public void previouspage(){
        counter-= isize;
    }
    public PageReference Firstpage(){
        counter=0; 
        return null;   
    }
    public pagereference lastpage(){
        counter=Totalsize-math.mod(Totalsize,isize);
        return null;
    }
    public void deleterecords(){
        
        Database.delete(ApexPages.currentPage().getParameters().get('accId'));//[select id from objectName where Id in:];
        system.debug('Test'+ApexPages.currentPage().getParameters().get('accId'));
    }
    
    public void saved(){
        update lstObjs; 
    }
}
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//