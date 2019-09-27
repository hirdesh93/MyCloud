@istest
private class TestSpeakerControllerExtention {
	@istest
    static void show(){
        
        Speaker__c sp= new Speaker__c();
        sp.Bio__c='this is test';
        sp.Email__c='test@test.com';
        sp.First_Name__c='test';
        sp.Picture_Path__c='/servlet/servlet.FileDownload?file';
        
        insert sp;
        
        Attachment at= new Attachment();
        Blob Picture=Blob.valueOf('Unit Test Attachment Body');
        at.body = picture;
        at.name = 'speaker_' + sp.id + '.jpg';
        at.parentid = sp.id;
        at.ContentType = 'application/jpg';
        insert at; 
        sp.Picture_Path__c = '/servlet/servlet.FileDownload?file='+ at.id;
        update sp;
        
        
        ApexPages.StandardController sc= new ApexPages.StandardController(sp);
        SpeakerControllerExtension  controller = new SpeakerControllerExtension(sc);
        controller.save();
        
    }
}