public class vfvalidate {

public String status { get; set; }
public boolean displayPopup {get; set;}
public String selectedRadioValue {get; set;}
public String selectedContactId {get; set;}
public String rejectionResonText {get; set;}
public Contact selectedContactInfo;
public Boolean checkRejectionText { get; set; }

public vfvalidate(ApexPages.StandardSetController controller) {
	controller.setPageSize(5);
}

public void saveRejectionReason() { 
	if(rejectionResonText != ''){
		System.Debug('Rejection Reason : '+rejectionResonText);
		note n = new note();
		n.parentId = selectedContactId;
		n.body = rejectionResonText;
		n.title='Rejection Note';
		insert n;
		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'A Rejection note for the contact has been saved'));
		displayPopup = false;
		rejectionResonText ='';
		checkRejectionText = false;
	}
	else{
		checkRejectionText = true;
		displayPopup = true;
	}    
}   


public void closePopup() { 
	if(rejectionResonText != ''){
		rejectionResonText = '';
	}         
	displayPopup = false;
	checkRejectionText = false;    
}     

public void showPopup() {
	System.Debug('Radio value is ' +selectedRadioValue);
	System.Debug('Selected Contact Id value is ' +selectedContactId);
	
	if(selectedRadioValue == 'Reject'){
		displayPopup = true;    
	}
	else if(selectedRadioValue == 'Approve'){
		selectedContactInfo = [Select Name, Email from Contact where Contact.id =: selectedContactId limit 1];
		System.Debug('Selected Contact Email is ' +selectedContactInfo.Email);
		System.Debug('Selected Contact Name is ' +selectedContactInfo.Name);
		if(selectedContactInfo.Email != ''){
			
			Messaging.SingleEmailMessage mailToApprovedContact = new Messaging.SingleEmailMessage();
			String[] sendingTo = new String[]{selectedContactInfo.Email};
			mailToApprovedContact.setToAddresses(sendingTo);
			mailToApprovedContact.setSubject('Contact Approval Mail');
			mailToApprovedContact.setPlainTextBody('Hi ' + selectedContactInfo.Name + ',Your Request has been approved.');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mailToApprovedContact});
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Contact Approval mail has been sent to '+selectedContactInfo.Name));
		}
		displayPopup = false;
	}
	else{
		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select either Approve or Reject'));
		System.Debug('Working');
		
	}   
}

}