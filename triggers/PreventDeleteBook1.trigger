trigger PreventDeleteBook1 on Book_Category__c (before delete) {
  if(trigger.isdelete || trigger.isbefore){
        for(Book_Category__c b: trigger.old){
            if(b.Count__c>1){
                b.addError('More than One Record');
                
            }
        }
    }


}