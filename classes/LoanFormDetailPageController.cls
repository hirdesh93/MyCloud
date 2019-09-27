public class LoanFormDetailPageController {
    public Customer_Loan_Form__c cls {get;set;}
    String recId;
    
    public LoanFormDetailPageController(ApexPages.StandardController std){
        recId = std.getId();
    }
    
    public String getFileId() {
        String fileId = '';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:recId ];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;    
    }

}