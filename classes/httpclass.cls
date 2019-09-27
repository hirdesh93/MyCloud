public class httpclass {
/*	Http http = new Http();
           HttpRequest req = new HttpRequest();
           String url = 'https://myorgtestdomain-dev-ed.my.salesforce.com/services/oauth2/token';
           String client_id = '3MVG9YDQS5WtC11raoKSdyiGu_9NWZPDihuqeP9gd9nmn3k7XkUMk5vI8vmgnySOyT7cmZ6KhYw==';
           String client_secret = '8900669299340807020';
           String username = 'hirdesh@myclod.com';  
           String password = '@gangil1236iJlhU7f8vbD1wB6YXC3KX2y';
           String body = 'grant_type=password&client_id=' + client_id + '&client_secret=' + client_secret + '&username=' + username + '&password=' + password;
           req.setEndpoint(url);
           req.setMethod('POST');
           req.setbody(body);
HTTPResponse resp = http.send(req);
system.debug('resp'+resp); 
//
public without sharing class IssueListViewForAppController {
    public boolean ShowForm{get;set;}
    public boolean unauthorized{get;set;}
    Public List<Issue__c> AllIssue{get;set;}
    public String username{get;set;}
    public String password{get;set;}
    public String subEditid{get; set;}
    public String subdetail{get; set;}
    public IssueListViewForAppController(){
        AllIssue = new List<Issue__c>();
        unauthorized = true;
        ShowForm = false; 
        if(String.isNotBlank(ApexPages.currentPage().getParameters().get('username')) && String.isNotBlank(ApexPages.currentPage().getParameters().get('password'))){
            username = ApexPages.currentPage().getParameters().get('username').replaceAll('\'','');
            password = ApexPages.currentPage().getParameters().get('password').replaceAll('\'','');
            List<contact> users = [select id,username__c,password__c from contact where username__c =:username   and password__c =: password ];
            if(users.size()>0){
                unauthorized = false;
                ShowForm = true;
            }
        }
        for(Issue__c Issue:[select id,name,Close_Date__c,RecordType.name,Agency__c,Docusign_Receiver__c,Issue_Type__c,Status__c,ticket_number__c,Quick_Description__c,Resolution__c,Severity__c from Issue__c]){
            AllIssue.add(Issue);
        }
        
    }
    
     public PageReference Editpage(){
        system.debug('subEditid'+subEditid);
        PageReference pf =  new PageReference('/apex/IssueNewEdit?Id='+subEditid+'&username='+username+'&password='+password);
        pf.setRedirect(true);
        return pf; 
     }
     
     public PageReference Detailpage(){
        system.debug('subdetail'+subdetail);
        PageReference pf =  new PageReference('/apex/IssueDetailPage?Id='+subdetail+'&username='+username+'&password='+password);
        pf.setRedirect(true);
        return pf; 
     }
} 
<!--Author Kcloud Technologies
Developer - Vivek Verma (Date - 13/04/18) -->
<apex:page controller="IssueListViewForAppController" showHeader="false" cache="false">
    <html lang="en">
      <head>           
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <meta name="description" content=""/>
      <meta name="author" content=""/>
      </head>
    </html>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" ></script>
    <apex:includeScript value="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" /> 
   <style>
   table {
  border-collapse: separate;
  border-spacing: 0;
  border-radius:2%;
  color: #4a4a4d;
  font: 14px/1.4 "Helvetica Neue", Helvetica, Arial, sans-serif;
 }
th,
td {
  padding: 10px 15px;
  vertical-align: middle;
}
thead {
  background: #00376d;
  
  color: #fff;
  font-size: 11px;
  text-transform: uppercase;
}
th:first-child {
  border-top-left-radius: 5px;
  text-align: left;
}
th:last-child {
  border-top-right-radius: 5px;
}
tbody tr:nth-child(odd) {
  background: #f0f0f2;
}
td {
  border-bottom: 1px solid #d2d2d2;
  border-right: 1px solid #d2d2d2;
}
td:first-child {
  border-left: 1px solid #d2d2d2;
}
.book-title {
  color: #395870;
  display: block;
}
.text-offset {
  color: #7c7c80;
  font-size: 12px;
}
.item-stock,
.item-qty {
  text-align: center;
}
.item-price {
  text-align: right;
}
.item-multiple {
  display: block;
}
tfoot {
  text-align: right;
}
tfoot tr:last-child {
  background: #f0f0f2;
  color: #395870;
  font-weight: bold;
}
tfoot tr:last-child td:first-child {
  border-bottom-left-radius: 5px;
}
tfoot tr:last-child td:last-child {
  border-bottom-right-radius: 5px;
}

 </style>
    
    <apex:form >
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12" style="width: 100%;background:#00376d;height:40px;"></div>
                
                <div class="col-sm-12">
                    <div class="col-sm-3"></div>
                    <div class="col-sm-6" >
                    <apex:outputpanel id="Access" rendered="{!unauthorized}">
                        <div class="col-sm-12" style="margin-left:16%;font-family: Montserrat;font-weight: 400;color:Green;">
                            <h2><span style="color:red;margin-left:-13%">!!!You are unauthorized to access this page!!!</span></h2>
                        </div>
                    </apex:outputpanel>
                    </div>
                    <div class="col-sm-3"></div>
                    
                    <apex:outputPanel rendered="{!showform}" >
                        <div style="margin-top:20px;">
                        <apex:pageBlock title="Issues" rendered="{!AllIssue.size>0}" >
                          <apex:outputPanel id="DataTable" style="overflow:auto;width:100%;height: calc(100vh - 90px);background: white;" layout="block">
                            <table style="width:100%;" id="myTable" class="list" cellpadding="0" cellspacing="0">
                                <thead>
                                    <th style="color: #fff;"><span style="cursor:pointer;">Edit</span></th>
                                    <th style="color: #fff;"><span style="cursor:pointer;">Issue Name</span></th> 
                                    <th style="color: #fff;"><span style="cursor:pointer;">Description</span></th> 
                                    <th style="color: #fff;"><span style="cursor:pointer;">Agency</span></th> 
                                    <th style="color: #fff;"><span style="cursor:pointer;">Issue Type</span></th>
                                    <th style="color: #fff;"><span style="cursor:pointer;">Status</span></th>  
                                    <th style="color: #fff;"><span style="cursor:pointer;">Resolution</span></th> 
                                </thead>
                              
                                <apex:repeat value="{!AllIssue}" var="a" >
                                    <tr id="Maintd" class="dataRow">
                                        <td>
                                            <apex:commandLink action="{!Editpage}">Edit <apex:param name="{!a.id}" value="{!a.id}" assignTo="{!subEditid}" /></apex:commandLink>
                                            
                                        </td> 
                                        <td>                                            
                                            <apex:commandLink action="{!Detailpage}"><apex:outputText value="{!a.Name}"/> <apex:param name="{!a.id}" value="{!a.id}" assignTo="{!subdetail}" /></apex:commandLink>
                                        </td>
                                        
                                        <td>
                                            <apex:outputText value="{!a.Quick_Description__c}"/>
                                        </td>
                                        
                                        <td>
                                            <apex:outputfield value="{!a.Agency__c}"/>
                                        </td>
                                       
                                        <td>
                                            <apex:outputText value="{!a.Issue_Type__c}"/>
                                        </td>
                                            
                                        <td>
                                            <apex:outputText value="{!a.Status__c}"/>
                                        </td>
                                        
                                        <td>
                                            <apex:outputText value="{!a.Resolution__c}"/>
                                        </td>
                                        
                                        
                                    </tr>
                                </apex:repeat>
                            </table>
                            </apex:outputPanel>
                        </apex:pageBlock>
                        
                        <apex:outputPanel rendered="{!AllIssue.size=0}">
                            <apex:pagemessage severity="info" summary="No Records Found" strength="3"></apex:pagemessage>
                        </apex:outputPanel>
                    </div>
                    </apex:outputPanel>
                    
                </div>
                
            </div>
        </div>
    </apex:form>  
</apex:page>

*/
}