public class TriggerHandlerStudentBadge {
    public void onAfterInsertnew(list<Student_Badge__c> lstBadge){
        Set<ID> stuBadgeIds = new Set<ID>();
        Set<ID> setContactIds = new Set<ID>();
        for(Student_Badge__c stu : lstBadge){
            stuBadgeIds.add(stu.Id);
        }
        if(stuBadgeIds.size() > 0){
            for(Student_Badge__c s : [SELECT Id,student__c FROM Student_Badge__c WHERE Id IN :stuBadgeIds]){
                setContactIds.add(s.student__c);
            }
        }
        
        if(setContactIds.size() > 0){
            List<Contact> conList = new List<Contact>();
            for(Contact con : [SELECT Id,Total_Number_of_badges__c,(select id from Student_Badges__r) from contact where id IN:setContactIds]){
                con.Total_Number_of_badges__c = con.Student_Badges__r.size();
                conList.add(con);        
            }
            if(conList.size() > 0){
                update conList;
            } 
        } 
    }
    
    public static void OnAfterDelete(list<Student_Badge__c> oldbadge){
        List<id> stuList = new List<id>();
        For(Student_Badge__c stu : oldbadge){
            stuList.add(stu.Student__c);
        } 
        List<Contact> conList = new List<Contact>();
        for(Contact con : [SELECT Id,Total_Number_of_badges__c,(select id from Student_Badges__r) from contact where id IN:stuList]){
            con.Total_Number_of_badges__c = con.Student_Badges__r.size();
            conList.add(con);
        }
        update conList;
    }
    public void PointsToUpdate(list<Student_Badge__c> lststuBadge){
        List<String> studentList = new List<String>();
        Map<String ,Decimal> MapToPoints = new Map<String, Decimal>();
        for(Student_Badge__c stu:lststuBadge) {
            studentList.add(stu.Student__c); 
            
        }
        AggregateResult[] groupedResults = [SELECT Sum(Badge__r.Points__c),Student__c FROM Student_Badge__c where Student__c IN :studentList GROUP BY Student__c];
        
        for(AggregateResult ar:groupedResults) {
            
            MapToPoints.put((STRING)ar.get('Student__c'),(Decimal)ar.get('expr0') );
        }
        if(studentList.size() >0){
            for(Student_Badge__c st : lststuBadge){
                if(MapToPoints.containsKey(st.Student__c)){
                    List<Contact> conUpdateList = new List<Contact>();
                    for(Contact con:[select Id ,Point_Count__c,(select id from Student_Badges__r) from Contact where Id IN:studentList]) {
                        If(con.Student_Badges__r.size() > 0){
                            con.Point_Count__c = MapToPoints.get(st.Student__c);
                            conUpdateList.add(con);
                        }    
                    }
                    if(conUpdateList.size() > 0){
                        Update conUpdateList;
                    }
                }
            }  
        }
    }
}