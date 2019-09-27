({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContact");
        action.setParams({
            conId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contact", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else if (response.getState() === "ERROR") {
                $A.log("Errors", response.getError());
            }
        });
        $A.enqueueAction(action); 
    }     
})