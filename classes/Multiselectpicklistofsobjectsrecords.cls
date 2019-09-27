public class Multiselectpicklistofsobjectsrecords{   
    
    public list<SelectOption> selectedobject {get;set;}
    public List<sObject> listofallobjects{get;set;}
    public String objectName { get; set; }    
    public set<string> setoffields{get;set;}
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
    //++++++++++++++++++++++++++++++++++++multiselectpicklist+++++++++++++++++++++++++++++++++++++//
    set<string> leftvalues=new set<string>();   
    public List<Selectoption> addremoveoption{get;set;}
    public list<string> removelistoffields{get;set;}
    public set<string> removelist1set;
    public Multiselectpicklistofsobjectsrecords(){
        PickilistFlag = false;
        ListFlag = false;
        b=false; 
        isize=10; 
        Totalsize=0;
        addremoveoption= new List<Selectoption>();
        removelist1set=new set<string>();
        removelistoffields=new list<string>();
        selectedobject = new list<SelectOption>();  
        selectedobject.add(new selectoption('','-None-'));
        list<schema.SobjectType> lst=schemaMap.values();
        for(schema.SobjectType ss:lst){
            selectedobject.add(new selectoption(ss.getDescribe().getLocalName(),ss.getDescribe().getLabel()));
            selectedobject.sort();
            
        }
        setoffields= new set<string>();
        lsps=new list<SelectOption>();
        
    }
    
    
    public list<String> fields {get; set;}
    
    public list<SelectOption> lsps{get;set;}
    
    public void function() {
        PickilistFlag = true;
        lsps.clear();
        if(objectName!=null || objectName!=''){
            Map<string,Schema.SObjectField> mpConField=schemaMap.get(objectName).getDescribe().fields.getMap();
            setoffields=mpConField.keySet();
            
            for(string name:setoffields){
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
            string k=''+removelistoffields;
            query = 'Select ' + k.subStringBetween('(',')')+ ' from ' + objectName  + ' limit '+ isize  +' offset  '+counter; //Dynamic query//                
            string countquery='select count() from  '+ objectName;
            Totalsize=database.countquery(countquery); 
            pagecount= isize  +counter ;                         
            if(removelistoffields.size()<=10 ){               
                listofallobjects= Database.query(query);
            }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select less fields');
                ApexPages.addMessage(myMsg);
            }
            pagecount = counter + listofallobjects.size();   
            system.debug('@@@@@@@@'+listofallobjects);
        }catch(exception e){
            
        }
        
    }  
    public List<sObject> getsObjList(){
        SelecFields();                    
        return listofallobjects;
        
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
    public boolean getdisabledfirpre(){
        if(counter>0)
            return false;
        else
            return true;
    }
    public boolean getdisablednextlst(){
        if(totalsize>(counter+isize))
            return false;
        else
            return true;
    }
    public void deleterecords(){
        
        Database.delete(ApexPages.currentPage().getParameters().get('accId'));//[select id from objectName where Id in:];
        system.debug('Test'+ApexPages.currentPage().getParameters().get('accId'));
    }
    
    public void saved(){
        update listofallobjects; 
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
    public list<selectoption> getselectedfields(){
        system.debug('$$$$$$$'+ leftvalues);
        list<string> k=new list<string>();
        if(addremoveoption.size()>0){
            for(selectoption a:addremoveoption){          
                k.add(a.getvalue());
            }
        }
        for(string st:leftvalues){
            if(!k.contains(st)){
                addremoveoption.add(new selectoption(st,st));             
            }
            removelist1set.add(st);
        }         
        system.debug('$$$addremoveoption$$$$'+ addremoveoption);     
        return addremoveoption;
    }
    
    public pagereference Add(){
        removelistoffields.clear();
        
        for(string ss:fields){
            leftvalues.add(ss);
        }
        return null;
        
    }
    public PageReference remove() {
        addremoveoption.clear();   
     //   listofallobjects.clear();
        
        for(string ff:removelistoffields){
            leftvalues.remove(ff);
            removelist1set.remove(ff);
        }
        
        return null;
    }
    
    public void selectedMethod(){
        
        addremoveoption= new List<Selectoption>();
        if(removelist1set.size()>0){
            removelistoffields.clear();
            removelistoffields.addAll(removelist1set);
            
            for(string st:removelistoffields){          
                addremoveoption.add(new selectoption(st,st));
            }
        }
        List<sObject> olist=getsObjList();
    } 
}