public class OnlinePurchase {
    public list<Online_Purchase_Order__c> onplist {get;set;}
    Public boolean flag		{get;set;}
    public string input		{get;set;}
    public OnlinePurchase(){
        flag= false;
    }
    public void show(){
        onplist= database.Query('select id, name, Address__c, Amount__c, Quantity__c,Active__c,PartyName__c,Order_Date__c,Product__c,Total_Amount__c,Purchase_Order_Line_Items__c from Online_Purchase_Order__c where name like '+'\''+'%'+input+'%'+'\'');
    }
    public pagereference create(){
        update onplist;
        return null;
    }

}