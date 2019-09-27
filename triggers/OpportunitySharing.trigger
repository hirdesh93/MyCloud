trigger OpportunitySharing on Opportunity (after insert) {
	user u = [select id from user where username ='gulshan@mycloud.com'];
    list<OpportunityShare> oppList = new List<OpportunityShare>();
    if(trigger.isinsert && trigger.isafter){
    for(Opportunity opp : trigger.new){
        if(opp.StageName == 'Closedwon'){
            OpportunityShare os = new OpportunityShare();
            os.OpportunityId = opp.Id;
            os.OpportunityAccessLevel = 'Read';
            os.UserOrGroupId = u.id;
            os.RowCause = 'Manual';
            oppList.add(os);
        }
        if(oppList.size() >0){
           insert oppList;
        }
    }
    }
}