public class AccountRelatedTaskController {
    public Account acc {get;set;}
    public List<Task> tskList {get;set;}
    
    public List<Task> tskList2 {get;set;}
    public AccountRelatedTaskController(Apexpages.StandardController controller){
        this.acc= (Account)controller.getRecord();
        
        tskList = [Select id,Status,Subject,whatId,Type,activityDate from Task where whatId =:acc.id AND Status ='Inbound Email' order By CreatedDate Desc];
        
    }

}