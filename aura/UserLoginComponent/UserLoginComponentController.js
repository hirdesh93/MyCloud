({
	handleLogin: function (component, event, helpler) {
        var username1 = component.find("username").get("v.value");
        var password1 = component.find("password").get("v.value");
        var action = component.get("c.login");
        
        
        action.setParams({username:username1, password:password1});
        action.setCallback(this, function(a){
            var rtnValue = a.getReturnValue();
            if (rtnValue !== null) {
                component.set("v.errorMessage",rtnValue);
                component.set("v.showError",true);
            }
        });
        $A.enqueueAction(action);
    }
    
})