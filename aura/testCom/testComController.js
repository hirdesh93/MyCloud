({
	 doInit : function(component, event, helper) {
        var action1 = component.get("c.getAccList");
        alert('ver3.3.6 '+component.get("v.recordId"));
        action1.setParams({ "accId":component.get("v.recordId")});
        action1.setCallback(this, function(response) {
            if(response.getReturnValue() != null){
                component.set("v.AccName", response.getReturnValue());
            }
        });
        $A.enqueueAction(action1);
	}
})