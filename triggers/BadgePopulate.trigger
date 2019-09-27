trigger BadgePopulate on Enrollment__c (after insert , after Update) {
    Set<ID> setEnIds = new Set<ID>();
    if(trigger.isInsert || trigger.isUpdate && (trigger.isafter)){
    for(Enrollment__c en : trigger.new){
        setEnIds.add(en.Id);
    }
    }
    List<Student_Badge__c> stuBag = new List<Student_Badge__c>();
    if(setEnIds.size() > 0){
        for(Enrollment__c enroll: [select Id,Name,status__c, student__c,Program__c , program__r.Badge__c ,Program__r.Badge__r.Name
                                   from Enrollment__c where Id IN :setEnIds] ){
                if(enroll.Status__c =='Completed' && enroll.program__r.Badge__c != null && (enroll.status__c != trigger.oldMap.get(enroll.id).status__c)){
                    Student_Badge__c stu = new Student_Badge__c();
                    stu.status__c = enroll.Program__r.Badge__r.Name;
                    stu.Student__c = enroll.Student__c;
                    stu.Badge__c = enroll.Program__r.Badge__c;
                    stuBag.add(stu);  
                }
            }
       if(stuBag.size() > 0 ){ 
        upsert stuBag;
        }
    }   
}