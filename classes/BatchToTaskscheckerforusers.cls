public class BatchToTaskscheckerforusers{
    public List<Task> taskList ;
    Public List<Task> taskListnew ;
    public List<User> userList ;
    public map<Id,Integer> UserTaskmap ;
    public BatchToTaskscheckerforusers(){
        userList = new List<User>();
        UserTaskmap = new map<Id,Integer>();
        
        taskList = new List<Task>();
        taskListnew = new List<Task>();
        try{
            userList = [select Id,Name,FirstName, UserName ,email,IsActive from User where IsActive = True];
            taskList = [select Id,Subject,Status,OwnerId,ActivityDate,Owner.Name,Owner.Email,Owner.IsActive from Task 
                        where OwnerId in (select Id from User where isActive = true) ];
            
        }catch(exception e){}
        
        system.debug('testtaskList'+ taskList);
        if(userList.size() > 0){
            for(User u : userList){
                taskListnew.clear();
                system.debug('testu' + u);
                for(Task t : taskList){
                    system.debug('testT'+ t);
                    if(u.Id == t.OwnerId){
                        taskListnew.add(t);
                    }
                }
                if(taskListnew.size() > 0){
                    UserTaskmap.put(u.Id, taskListnew.size());
                    system.debug('testUserTaskmap2'+UserTaskmap.keySet() +'=' +UserTaskmap.values());
                }
                
            }
        }
        system.debug('testUserTaskmap'+ UserTaskmap);
        if(userList.size() > 0){
            Map<Id, integer> mapList = New Map< Id, integer>();
            for(user usr : userList){
                system.debug('UserTaskmaptest' + UserTaskmap);
                if(UserTaskmap.get(usr.id) > 12){
                    system.debug('UserTaskmaptest' + UserTaskmap);
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.toAddresses = new String[] {usr.Email};
                    mail.setsubject('Task OverDue ');
                    mail.SetPlainTextbody('Hi,'+ usr.FirstName  +'\n You have many tasks pending in your system that has to be taken care of ASAP.\n\n'+'REMEMBER that in order to mark a task completed you have to click on the task subject and log a call from there Only and add comments.\n'+'https://propertyssimo--dev.cs84.my.salesforce.com/00O5E000000KPu4?pv0=' + usr.Name);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                    
                    Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                    mail1.toAddresses = new String[] {'hirdeshgangil@gmail.com'};
                    mail1.setsubject('Task OverDue of User' + usr.Name );
                    mail1.SetPlainTextbody('Hi, Daly \n\n' + usr.Name + ' has over 13 overdue tasks, Contact him/her ASAP and make sure it will be taken care of.\n\n'+'Link to employee overdue tasks below:\n'+'https://propertyssimo--dev.cs84.my.salesforce.com/00O5E000000KPu4?pv0=' + usr.Name);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail1});
                }
            }
        }
    }
}