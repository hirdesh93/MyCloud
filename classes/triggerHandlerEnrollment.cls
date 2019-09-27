public class triggerHandlerEnrollment {
    
    public void BadgePopulate(List<Enrollment__c> newList , Map<Id,Enrollment__c> oldMap){
        Map<Id, Enrollment__c> enrollMap = new Map<Id, Enrollment__c>();
        List<Student_Badge__c> stubag = new List<Student_Badge__c>();
        for(Enrollment__c enroll: newList){
            if(enroll.Status__c=='Completed' && enroll.program__r.Badge__c != null && (oldMap == null || enroll.program__r.Badge__c != oldMap.get(enroll.Id).program__r.Badge__c)){
                enrollMap.put(enroll.program__r.Badge__c ,null);
            }	
        }
        if(enrollMap.Keyset().size() > 0){
            enrollMap = new Map<Id,Enrollment__c>([select id,Name,status__c, student__c,Program__c ,
                                                   program__r.Badge__c from Enrollment__c where id IN:enrollMap.Keyset()]);   
        }
        for(Enrollment__c enroll: newList){
            if(enroll.Status__c =='Completed' && enroll.program__r.Badge__c != null && enrollMap.containsKey(enroll.program__r.Badge__c)){
                Student_Badge__c stu = new Student_Badge__c();
                stu.Student__c = enroll.Student__c;
                stu.Badge__c = enroll.Program__r.Badge__c;
                stubag.add(stu);
            }
        }
        if(stuBag.size() > 0){
            Update stuBag;
        }
    }
}