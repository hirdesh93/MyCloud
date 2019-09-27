trigger TaskCreateONcreationOfLead on Lead (after insert ,Before Update) {
    If(Trigger.isInsert && Trigger.IsAfter){
        List<Task> tskList = new List<Task>();
        for(Lead l : trigger.new){
            Task t = new Task();
            t.WhoId = l.Id;
            t.Subject = 'Lead Created' + '- '+l.FirstName + ' '+ l.LastName;
            t.Status = 'In Progress';
            t.OwnerId = l.OwnerId;
            t.Priority = 'High';
            tskList.add(t);
        }
        if(tskList.size() >0){
            insert tskList;
        }
    }
    If(trigger.isUpdate && trigger.isBefore){
        Task t = [select id, Subject ,Status from Task where Status != 'Completed'  limit 1];
        
        for(Lead l : trigger.new){
            if(t != null && l.IsConverted ==true){
                l.addError('Task is Not Completed');
            }
        }
    }
}