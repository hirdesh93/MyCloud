/************************************************************
 Lightning Controller  Details
 Name: AccountCreateAndUpdateController.js
 Type: Lightning Controller 
 Purpose: Controller for  lightning component 
		  AccountCreateAndUpdate.cmp
 ***********************************************************/
({
	create : function(component, event, helper) {
		console.log('Create record');
        
        //getting the candidate information
        var AccountNew = component.get("v.Account");
        
        //Calling the Apex Function
        var action = component.get("c.createRecord");
        
        //Setting the Apex Parameter
        action.setParams({
            acc : AccountNew
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                //Reset Form
                var newAccount = {'sobjectType': 'Account',
                                    'Name': 'v.Account.name',
                                    'Industry': '',
                                    'Phone': '', 
                                    'Website': ''
                                   };
                //resetting the Values in the form
                component.set("v.Account",newAccount);
                alert('Record is Created Successfully');
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);

	},
    save : function(component, event, helper) {     
     var action = component.get("c.creatLeadRecord");
            action.setParams({"acc":component.get("v.account")});
            action.setCallback(this,function(result){
            var accId = result.getReturnValue();
            alert('accId =='+accId +' Record Saved SuccessFully'); 
            $A.get("e.force:closeQuickAction");
        });
         $A.enqueueAction(action);
 }
    
})