({
 save : function(component, event, helper) {     
     var action = component.get("c.creatcandidateRecord");
            action.setParams({"Candidate":component.get("v.Candidate")});
            action.setCallback(this,function(result){
            component.set("v.isShow",false);
            var leadId = result.getReturnValue();
            alert('leadId'+leadId); 
        });
         $A.enqueueAction(action);
 }
})