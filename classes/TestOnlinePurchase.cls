@istest
private class TestOnlinePurchase {
    static testmethod void test(){
        
        Online_Purchase_Order__c  opc= new Online_Purchase_Order__c();
            opc.Active__c=true;
            opc.Address__c='test';
            opc.Amount__c=20;
            opc.Order_Date__c=system.today();
            opc.Name='test1';
            opc.Product__c='abc';
            opc.PartyName__c='abcd';
            opc.Quantity__c=2;
            insert opc;
        OnlinePurchase con= new OnlinePurchase();
        con.show();
        con.create();
        AssignmentClass ac= new AssignmentClass();
        ac.showdata();
     }
}