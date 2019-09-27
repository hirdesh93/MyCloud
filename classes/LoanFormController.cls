public class LoanFormController {
    public Customer_Loan_Form__c cls {get;set;}
    public List<Customer_Loan_Form__c> clist {get;set;}
    public blob Image {get;set;}
    String recId;
    public LoanFormController(ApexPages.StandardController std){
        recId = std.getId();
        cls = new Customer_Loan_Form__c();
        clist = new List<Customer_Loan_Form__c>();
    }
    public PageReference saveAttachment(){
        system.debug('test' + Image);
        Customer_Loan_Form__c cloan = new Customer_Loan_Form__c();
       	cloan.Name__c = cls.Name__c;
        cloan.Father_s_Husband_Name__c = cls.Father_s_Husband_Name__c;
        cloan.Annual_Income__c = cls.Annual_Income__c;
        cloan.Mobile_No__c = cls.Mobile_No__c;
        cloan.Loan_Amount__c = cls.Loan_Amount__c;
        insert cloan;
        if(image!= null){
            Id loanId = System.currentPageReference().getParameters().get('loanId');
        
    	//Blob imagenew = EncodingUtil.base64Decode(Image);
        Attachment attachment = new Attachment();
        attachment.Body = Image;
        attachment.ParentId = cloan.id;
        attachment.Name = String.valueOf('test.jpg');
        insert attachment;
        }  
        
        PageReference pg = new PageReference('/apex/LoanFormDetailPage?Id='+cloan.id);
        return pg;
    }
    Public void CancelRecord(){
        cls = new Customer_Loan_Form__c();
    }
 }