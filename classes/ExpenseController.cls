public with sharing class ExpenseController {
    @AuraEnabled 
    public static List<Hirdesh93Org__Expense__c> getExpenses() {
        // Perform isAccessible() check here 
        return [SELECT Id, Name, Hirdesh93Org__Amount__c, Hirdesh93Org__Client__c, Hirdesh93Org__Date__c, Hirdesh93Org__Reimbursed__c, CreatedDate FROM Hirdesh93Org__Expense__c];
    }
    @AuraEnabled 
    public static Hirdesh93Org__Expense__c saveExpense(Hirdesh93Org__Expense__c expense) {
        // Perform isUpdateable() check here 
        upsert expense;
        return expense;
    } 
    
}