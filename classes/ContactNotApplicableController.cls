public class ContactNotApplicableController {
    public Boolean isNotApplicable {get;set;}
    public Contact con;
    public ContactNotApplicableController(ApexPages.StandardController stcontroller){
        this.con=(contact)stcontroller.getRecord();
        isNotApplicable = false;
        for(Contact C: [select id, Firstname,LastName, AccountId ,Type__c, Status__c from Contact where Id =: stcontroller.getId()]){
            if(c.Status__c !='NA'){
                Map<String, List<String>> depOptionMap = new Map<String, List<String>>();
                depOptionMap = DependentPickLists.GetDependentOptions('Contact', 'Type__c','Status__c');
                if(depOptionMap.containsKey(c.Type__c)){
                    for(String str : depOptionMap.get(c.Type__c)){
                        if(str == 'NA'){
                        	isNotApplicable = true;
                        }
                    }
                }
            } 
        }
    }
    
    public pagereference Mark(){
        isNotApplicable = true;
        con.Status__c='NA';
        update con; 
        string URL = '/'+con.Id;
        return new pageReference (URL);
    }
    
    public PageReference editCon()
    {
        isNotApplicable = false;
        string URL = '/'+con.Id;
        return new pageReference (URL);
    }
}