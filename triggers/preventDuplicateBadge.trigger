trigger preventDuplicateBadge on Student_Badge__c (before insert) {
    if(trigger.isinsert && trigger.isbefore){
        for(Student_Badge__c stu: trigger.new){
            integer recordCount = [SELECT Count() FROM Student_Badge__c Where Badge__c =:stu.Badge__c];
            if(recordCount > 0){
                stu.addError('duplicate record');
            }
        }  
    } 
}