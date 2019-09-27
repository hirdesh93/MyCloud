({
	show : function(component) {
        var action=component.get("c.getName");
        action.setCallback(this,function(response)){
        var state=response.getstate();
        if(state==="success"){
            component.set("v.empName", response.getReturnValue());
        }
     }
    $A.enqueueAction(action);
		
	}
})