public class Rec_LeadOppDashboard_Controller{
  /*  //opportunity
    public Opportunity  OppObj{get;set;}
    public String OppselectedDueDate{get;set;}
    public List<String> OppselectedStage{get;set;}
    public List<String> OppselectedInterest{get;set;}
    public  Opportunity  OppObjBroker_Dealer{get;set;} 
    public String OppsearchTerm{get;set;}
    public Integer opp_offSet  {get;set;} 
    public Integer opp_nextPageIndex  {get;set;} 
    public Boolean isSearch_opp{get;set;} 
    public Boolean is_0pp {get;set;}
    public Boolean isNext_0pp {get;set;}
    public Boolean nextDisabled {get;set;}
    public Boolean prevDisabled {get;set;}
    public Decimal countTotalRecords_opp{get;set;} 
    public Decimal pagecount_opp{get;set;}
    public static boolean sortDuedate{get;set;}
    public string PageNoColor{get;set;}
    public String sortField{get;set;}
    //lead
    public Lead  LeadObj{get;set;}
    public String LeadselectedDueDate{get;set;}
    public String LeadselectedSourceDate{get;set;}
    public List<String> LeadselectedStatus{get;set;}
    public  lead  LeadObjBroker_Dealer{get;set;}
    public String LeadsearchTerm{get;set;}  
    public list<Lead> leadlist{get;set;}
    public Integer Lead_offSet  {get;set;} 
    public Integer Lead_nextPageIndex  {get;set;}  
    public Decimal countTotalRecords_Lead{get;set;} 
    public Decimal pagecount_Lead{get;set;}
    public Boolean isSearch_Lead{get;set;}
    public String sortFieldLead{get;set;}
       
     public PageReference  init(){
        sortDir = 'asc';
        opp_offSet  = 0;
        sortField='duedate'; 
        opp_nextPageIndex  = 5;        
        OppselectedStage= new List<String>{'1'};
        OppselectedInterest= new List<String>{'1'};
        OppselectedDueDate='1';
        OppObj=new Opportunity();
        OppObj.ownerID=UserInfo.getUserId();
        sortDuedate=false;
        LeadObj=new lead();
        LeadObj.ownerID=UserInfo.getUserId();
        LeadselectedStatus= new List<String>{'1'};
        LeadselectedDueDate='1';
        LeadselectedSourceDate='1';
        Lead_offSet  = 0;
        Lead_nextPageIndex  = 5; 
        sortFieldLead='duedate';
        sortDirLead='asc';
        return null;
     }
     public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }

   public void toggleSort() {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    }
  
    public Integer tempPageCount = 0;
    public List<Opportunity> getOpportunityObjList(){
         String loggedInUserId  = UserInfo.getUserId();
         String queryStr='select id, name ,ownerid ,owner.name,Current_Stage__c,Account.BillingCity,Account.BillingState,Next_Task_Due_Date__c ,StageName,Contact__c,Contact__r.name,Created__c, Intro__c, Qualified__c , Qualified_Out__c, Demo__c, HOV__c , Offer__c ,Interest__c ,Broker_Dealer__r.name ,(select id, ActivityDate from tasks where  ActivityDate!=null and Status!=\'Completed\' ORDER BY activitydate ASC limit 1) from Opportunity where RecordType.Name=\'Advisor Services Opportunity Record Type\' and StageName=\'Active Recruit\'';
         String countQuery = 'Select count() from Opportunity where RecordType.Name=\'Advisor Services Opportunity Record Type\' and StageName=\'Active Recruit\'';
         List<String> stagedatelist= new List<String>();
         List<String> InterestList = new List<String>();
         String searchToken ='';
         string brokerid='';
         string ownerid=null;
         if(isSearch_opp != null && isSearch_opp){    
                if(String.isNotBlank(OppsearchTerm)){
                    searchToken =  '%'+OppsearchTerm+'%';
                    countQuery = countQuery +' and (Name like : searchToken OR Owner.name like : searchToken OR Account.BillingCity like : searchToken OR Account.BillingState like : searchToken  OR Interest__c like : searchToken  OR Broker_Dealer__r.name like : searchToken OR Contact__r.name like : searchToken OR Current_Stage__c like : searchToken )';
                    queryStr = queryStr +' and (Name like : searchToken OR Owner.name like : searchToken OR Account.BillingCity like : searchToken OR Account.BillingState like : searchToken  OR Interest__c like : searchToken OR Broker_Dealer__r.name like : searchToken OR Contact__r.name like : searchToken OR Current_Stage__c like : searchToken )';
                } else {
                    countQuery = countQuery + ' and Id != null ';
                    queryStr = queryStr + ' and Id != null ';
                }
                ownerid=OppObj.ownerID;
                if(String.isNotBlank(ownerid)){
                    countQuery = countQuery +' AND OwnerId =: ownerid';
                    queryStr = queryStr +' AND OwnerId =: ownerid';
                }
                if(OppselectedStage != null && OppselectedStage.isEmpty() == false){               
                      for(String selectedStage: OppselectedStage){
                            if('2'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Created');
                            } else if('3'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Intro');
                            } else if('4'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Qualified');
                            }else if('5'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Qualified Out');
                            }else if('6'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Demo');
                            } else if('7'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('HOV');
                            }else if('8'.equalsIgnoreCase(selectedStage)){
                                stagedatelist.add('Offer');
                            } 
                      }
                      if(stagedatelist.size() > 0){
                          countQuery = countQuery +' AND Current_Stage__c IN: stagedatelist ';
                          queryStr = queryStr +' AND Current_Stage__c IN: stagedatelist ';  
                      }                  
                }
               if(OppselectedInterest != null && OppselectedInterest.isEmpty() == false){               
                    for(String selectedIntereststr: OppselectedInterest ){
                        if('2'.equalsIgnoreCase(selectedIntereststr)){
                            InterestList.add('Cold');
                        } else if('3'.equalsIgnoreCase(selectedIntereststr)){
                            InterestList.add('Warm');
                        } else if('4'.equalsIgnoreCase(selectedIntereststr)){
                            InterestList.add('Hot');
                        } 
                    }
                    if(InterestList.Size() > 0){
                        countQuery = countQuery +' AND Interest__c  IN: InterestList   ';
                        queryStr = queryStr +' AND Interest__c  IN: InterestList   '; 
                    }                   
                }
                 brokerid = OppObj.Broker_Dealer__c;
                if(String.isNotBlank(brokerid )){
                    countQuery = countQuery +' AND Broker_Dealer__c=: brokerid ';
                    queryStr = queryStr +' AND Broker_Dealer__c=: brokerid ';
                }
                if(String.isNotBlank(OppselectedDueDate) && '1'.equalsIgnoreCase(OppselectedDueDate) == false){
                 if('2'.equalsIgnoreCase(OppselectedDueDate)){
                    countQuery = countQuery +' AND Next_Task_Due_Date__c < NEXT_N_DAYS:'+1;
                    queryStr = queryStr +' AND Next_Task_Due_Date__c < NEXT_N_DAYS:'+1;
                } else if('3'.equalsIgnoreCase(OppselectedDueDate)){
                    countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+1;
                    queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+1;
                } else if('4'.equalsIgnoreCase(OppselectedDueDate)){
                    countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+7;
                    queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+7;
                } else if('5'.equalsIgnoreCase(OppselectedDueDate)){
                    countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+14;
                    queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+14;
                } else if('6'.equalsIgnoreCase(OppselectedDueDate)){
                    countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+30;
                    queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+30;
                }
                
            }
            queryStr = queryStr +' order by '+getSortFieldAPIMapping(sortField)+' '+sortDir+' NULLS LAST ';
                          
           }else{
            countQuery = countQuery +' and OwnerId=:loggedInUserId';
            queryStr = queryStr +' and OwnerId=:loggedInUserId  order by Next_Task_Due_Date__c asc NULLS LAST';
           }
         countTotalRecords_opp = Database.countQuery(countQuery);
         queryStr = queryStr + ' limit : opp_nextPageIndex   offSet  : opp_offSet  ';
        
         List<Opportunity> opList = (List<Opportunity>)Database.query(queryStr);
         tempPageCount = opList.size();
         pageCount_opp = opp_offSet  + tempPageCount;
         return opList;  
      }
    
    public Pagereference searchOpportunity(){
        opp_offSet  = 0;
        opp_nextPageIndex = 5;
        getOpportunityObjList();
        return null;
    }
   
    //due date picklist for both lead and opprtunity
    public List<SelectOption> getOppDueDateInOptions() {
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('1','All'));
        Options.add(new SelectOption('2','OverDue+Today'));
        Options.add(new SelectOption('3','OverDue+Next Day'));
        Options.add(new SelectOption('4','OverDue+Next 7 Days'));
        Options.add(new SelectOption('5','OverDue+Next 14 Days'));
        Options.add(new SelectOption('6','OverDue+Next 30 Days'));
 
        return Options;
    }
    
     public List<SelectOption> getOppInterestOptions(){
        List<SelectOption> statusOptions=new List<SelectOption>();
        statusOptions.add(new SelectOption('1','All'));
        Map<String, Schema.SObjectType> gd=Schema.getGlobalDescribe();
        Schema.SobjectType sso=gd.get('Opportunity');
        Schema.DescribeSobjectResult dsr=sso.getDescribe();
        Map<String, Schema.SObjectField> fieldMap=dsr.fields.getMap();
        Schema.SObjectField statField=fieldMap.get('Interest__c');
        
        Schema.DescribeFieldResult fieldDesc = statField.getDescribe();
        List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
         Integer i=2;    
        for (Schema.PickListEntry plEntry : plEntries)
        {
            SelectOption option=new SelectOption(string.valueof(i), plEntry.getLabel());
            statusOptions.add(option);
            i=i+1; 
        }
        return statusOptions;
    }
   
   public String getSortFieldAPIMapping(String sortField){
        String sortFieldAPIName = '';
       if('Opportunity Name'.equalsIgnoreCase(sortField)){
            sortFieldAPIName = 'Name';
        } else if('Owner'.equalsIgnoreCase(sortField)){
            sortFieldAPIName = 'Owner.name';
        } else if('City'.equalsIgnoreCase(sortField)){
            sortFieldAPIName = 'Account.BillingCity';
        } else if('State'.equalsIgnoreCase(sortField)){
            sortFieldAPIName = 'Account.BillingState';
        } else if('Interest'.equalsIgnoreCase(sortField)){
            sortFieldAPIName = 'Interest__c';
        } else if('Broker/Dealer'.equalsIgnoreCase(sortField)){
           sortFieldAPIName = 'Broker_Dealer__r.name';
        } else if('Primary Contact'.equalsIgnoreCase(sortField)){
           sortFieldAPIName = 'Contact__r.name';
        } else if('Stage'.equalsIgnoreCase(sortField)){
           sortFieldAPIName = 'Current_Stage__c';
        }else{
            sortFieldAPIName = 'Next_Task_Due_Date__c';
        }
        return sortFieldAPIName;
    }
    public PageReference FirstPage_opp(){
        opp_offSet=0;   
        return null;       
    }
     
     public PageReference OppNext() {
        opp_offSet  += opp_nextPageIndex ;
        return null;
    }

    public PageReference OppPrevious() {
        opp_offSet  -= opp_nextPageIndex ;
        return null;
    }
    
    public PageReference OppEnd() {      
        if( countTotalRecords_opp>0 && math.mod(countTotalRecords_opp.intValue(),opp_nextPageIndex)==0 ){
             PageNoColor='last';
            opp_offSet  = countTotalRecords_opp.intValue()-opp_nextPageIndex;
       }else{
            opp_offSet  = countTotalRecords_opp.intValue()-math.mod(countTotalRecords_opp.intValue(),opp_nextPageIndex);
             PageNoColor='last';
        }
        return null;
    }

    public Boolean getDisablePrevious_opp(){
        if(opp_offSet  >0){
            return false;
        }
        else return true;
    }

    public Boolean getDisableNext_opp() {
        if(opp_offSet==0 && opp_nextPageIndex>countTotalRecords_opp){
            return true;
        }else if (opp_offSet  + opp_nextPageIndex < countTotalRecords_opp){
            return false;
        }else{ 
            return true;
        }
      }
  
    // ************************************lead Code********************************************************************
        public String sortDirLead {
            get  { if (sortDirLead == null) {  sortDirLead = 'asc'; } return sortDirLead ;  }
            set;
        }
    
       public void toggleSortLead() {
            sortDirLead = sortDirLead .equals('asc') ? 'desc' : 'asc';
        }
        
       public List<SelectOption> getLeadSourceDateOptions(){
            List<SelectOption> statusOptions=new List<SelectOption>();
            statusOptions.add(new SelectOption('1','All'));
            Map<String, Schema.SObjectType> gd=Schema.getGlobalDescribe();
            Schema.SobjectType sso=gd.get('lead');
            Schema.DescribeSobjectResult dsr=sso.getDescribe();
            Map<String, Schema.SObjectField> fieldMap=dsr.fields.getMap();
            Schema.SObjectField statField=fieldMap.get('LeadSource');
            
            Schema.DescribeFieldResult fieldDesc = statField.getDescribe();
            List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
            for (Schema.PickListEntry plEntry : plEntries){
                SelectOption option=new SelectOption(plEntry.getvalue(), plEntry.getLabel());
                statusOptions.add(option);
            }
            return statusOptions;
      }
      
       public List<SelectOption> getLeadStatusOptions() {
            List<SelectOption> Options = new List<SelectOption>();
            Options.add(new SelectOption('1','All'));
            Options.add(new SelectOption('2','Street'));
            Options.add(new SelectOption('3','Qualified'));
            Options.add(new SelectOption('4','Drip'));
            return Options;
        }
        
      public Integer tempPageCount1 = 0;
      public List<Lead> getLeadObjList(){
          String loggedInUserId  = UserInfo.getUserId();
          String queryStr='select id,name ,ownerid ,owner.name,Company,Phone,Next_Task_Due_Date__c,LeadSource,Email,city, Status,state, LeadBrokerDealer__c,LeadBrokerDealer__r.name from Lead where RecordType.Name=\'Advisor Services Lead Record Type\' ';
          String countQuery = 'Select count() from Lead where RecordType.Name=\'Advisor Services Lead Record Type\'';
          List<String> stagedatelist= new List<String>();
          List<String> LeadStatusList = new List<String>();
          String searchToken ='';
          string brokerid='';
          string ownerid=null;
          if(isSearch_Lead != null && isSearch_Lead){    
                if(String.isNotBlank(LeadsearchTerm)){
                    searchToken =  '%'+LeadsearchTerm+'%';
                    countQuery = countQuery +' and (Name like : searchToken OR Owner.name like : searchToken OR Company like : searchToken OR Phone like : searchToken  OR LeadSource like : searchToken  OR Email like : searchToken OR city like : searchToken OR state like : searchToken OR LeadBrokerDealer__r.name like : searchToken OR Status like : searchToken)';
                    queryStr = queryStr +' and (Name like : searchToken OR Owner.name like : searchToken OR Company like : searchToken OR Phone like : searchToken  OR LeadSource like : searchToken  OR Email like : searchToken OR city like : searchToken OR state like : searchToken OR LeadBrokerDealer__r.name like : searchToken OR Status like : searchToken)';
                } else {
                    countQuery = countQuery + ' and Id != null ';
                    queryStr = queryStr + ' and Id != null ';
                }
                ownerid=LeadObj.ownerID;
                if(String.isNotBlank(ownerid)){
                    countQuery = countQuery +' AND OwnerId =: ownerid';
                    queryStr = queryStr +' AND OwnerId =: ownerid';
                }
               
                if(LeadselectedStatus != null && LeadselectedStatus.isEmpty() == false){               
                    for(String selectedLeadStatus: LeadselectedStatus){
                        if('2'.equalsIgnoreCase(selectedLeadStatus)){
                            LeadStatusList  .add('Street');
                        } else if('3'.equalsIgnoreCase(selectedLeadStatus)){
                            LeadStatusList  .add('Qualified');
                        } else if('4'.equalsIgnoreCase(selectedLeadStatus)){
                            LeadStatusList  .add('Drip');
                        } 
                    }
                     if(LeadStatusList.size() > 0){
                        countQuery = countQuery +' AND Status IN: LeadStatusList ';
                        queryStr = queryStr +' AND Status IN: LeadStatusList ';  
                     }                     
                 }
                brokerid = LeadObj.LeadBrokerDealer__c;
                if(String.isNotBlank(brokerid )){
                    countQuery = countQuery +' AND LeadBrokerDealer__c=: brokerid ';
                    queryStr = queryStr +' AND LeadBrokerDealer__c=: brokerid ';
                }
                if(String.isNotBlank(LeadselectedSourceDate) && '1'.equalsIgnoreCase(LeadselectedSourceDate) == false){
                     countQuery = countQuery +' AND LeadSource=: LeadselectedSourceDate ';
                     queryStr = queryStr +' AND LeadSource=: LeadselectedSourceDate ';
                }
                if(String.isNotBlank(LeadselectedDueDate) && '1'.equalsIgnoreCase(LeadselectedDueDate) == false){
                      if('2'.equalsIgnoreCase(LeadselectedDueDate)){
                        countQuery = countQuery +' AND Next_Task_Due_Date__c <NEXT_N_DAYS:'+1;
                        queryStr = queryStr +' AND Next_Task_Due_Date__c <NEXT_N_DAYS:'+1;
                    } else if('3'.equalsIgnoreCase(LeadselectedDueDate)){
                        countQuery = countQuery +' AND Next_Task_Due_Date__c <=NEXT_N_DAYS:'+1;
                        queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+1;
                    } else if('4'.equalsIgnoreCase(LeadselectedDueDate)){
                        countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+7;
                        queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+7;
                    } else if('5'.equalsIgnoreCase(LeadselectedDueDate)){
                        countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+14;
                        queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+14;
                    } else if('6'.equalsIgnoreCase(LeadselectedDueDate)){
                        countQuery = countQuery +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+30;
                        queryStr = queryStr +' AND Next_Task_Due_Date__c <= NEXT_N_DAYS:'+30;
                    }               
                }
               queryStr = queryStr +' order by '+getSortLead(sortFieldLead)+' '+sortDirLead +' NULLS LAST ';                          
          }else{
              countQuery = countQuery +' and OwnerId=:loggedInUserId';
              queryStr = queryStr +' and OwnerId=:loggedInUserId  order by Next_Task_Due_Date__c asc NULLS LAST';
           }
        countTotalRecords_Lead = Database.countQuery(countQuery);
        queryStr = queryStr + ' limit : Lead_nextPageIndex   offSet  : Lead_offSet  ';
        
        List<Lead> LeadList = (List<Lead>)Database.query(queryStr);
        tempPageCount1 = LeadList.size();
        pageCount_Lead = Lead_offSet  + tempPageCount1;
        
        return LeadList;  
       }
    
      public Pagereference searchLead(){
        Lead_offSet  = 0;
        Lead_nextPageIndex = 5;
        getLeadObjList();
        return null;
      }
      
     public String getSortlead(String sortFieldLead){       
         String sortFieldAPIName = '';
         if('Lead Name'.equalsIgnoreCase(sortFieldLead)){
               sortFieldAPIName = 'Name';
          } else if('Owner'.equalsIgnoreCase(sortFieldLead)){
               sortFieldAPIName = 'Owner.name';
          } else if('Company'.equalsIgnoreCase(sortFieldLead)){
              sortFieldAPIName = 'Company';
          } else if('LeadSource'.equalsIgnoreCase(sortFieldLead)){
              sortFieldAPIName = 'LeadSource';
          } else if('Phone'.equalsIgnoreCase(sortFieldLead)){
              sortFieldAPIName = 'Phone';
          }else if('Email'.equalsIgnoreCase(sortFieldLead)){
              sortFieldAPIName = 'Email';
          }else if('City'.equalsIgnoreCase(sortFieldLead)){
             sortFieldAPIName = 'City';
          } else if('State'.equalsIgnoreCase(sortFieldLead)){
             sortFieldAPIName = 'state';
          }else{
             sortFieldAPIName = 'Next_Task_Due_Date__c';
          }
          
         return sortFieldAPIName;
         }
         
       public PageReference CreateNewlead(){
          PageReference pgRef = new PageReference('/00Q/e');
          return pgRef;
        }
           
       public PageReference FirstPage_lead(){       
           Lead_offSet=0;   
           return null;       
        }
               
       public PageReference LeadNext() {
           Lead_offSet  += Lead_nextPageIndex ;
           return null;
        }
    
        public PageReference LeadPrevious() {
            Lead_offSet  -= Lead_nextPageIndex ;
            return null;
        }
        
        public PageReference LeadEnd() {
            if(math.mod(countTotalRecords_Lead.intValue(),Lead_nextPageIndex)==0){
               Lead_offSet  = countTotalRecords_Lead.intValue()-Lead_nextPageIndex;
            }else{
                Lead_offSet  = countTotalRecords_Lead.intValue()-math.mod(countTotalRecords_Lead.intValue(),Lead_nextPageIndex);
            }
            return null;
        }
      
        public Boolean getDisablePrevious_lead(){
            if(Lead_offSet  >0){
                return false;
            }else 
                return true;
         }
    
        public Boolean getDisableNext_Lead() {
            if(Lead_offSet==0 && Lead_nextPageIndex>countTotalRecords_Lead){
                return true;
            }else if(Lead_offSet  + Lead_nextPageIndex < countTotalRecords_Lead){
                return false;
            }else 
                return true;
          } 
          
          
          <apex:page controller="Rec_LeadOppDashboard_Controller"  sidebar="false"  action="{!init}"> 
 <apex:form >
  <style>
    .bPageBlock 
    {
      background-color:#ffffff  !important;
      }
    </style>
    <script>
        function showmessage(fieldid){
            var input = document.getElementById(fieldid).value;
            var pid1=document.getElementById("error");
            if(input==null || input==''){
                 pid1.innerHTML='';
                 pid1.style.color = "red";
            }else{
               pid1.innerHTML=''; 
            }
         <!--   alert(input);-->
        
        }
    </script>
      <Apex:pageBlock >

              <!---- opp ---------->     
          <apex:pageBlockSection columns="1" collapsible="true" title="Opportunity" >
                <apex:outputPanel id="oppid">
                   <table width="100%">
                     <tr><td width="100%">
                        <table >
                               <tr></tr>
                               <tr></tr>
                               <tr>
                                   <td>
                                       <table>
                                           <tr><td style="text-align:center;">Owner</td></tr>
                                           <tr><td style="text-align:center;"><apex:inputField value="{!OppObj.OwnerID}" html-placeholder="Opportunity Owner" id="input1" style="width:158px;" required="false"/><p id="error"></p></td></tr>
                                       </table>
                                   </td>
                                   <td width="5"></td>
                                   <td>
                                       <table>
                                           <tr><td style="text-align:center;"> Due Date In</td></tr>
                                           <tr>
                                               <td >
                                                   <apex:selectList value="{!OppselectedDueDate}" multiselect="false" size="1" style="width:158px;">
                                                        <apex:selectOptions value="{!OppDueDateInOptions}"/>
                                                   </apex:selectList>
                                               </td>
                                           </tr>
                                        </table>
                                   </td>
                                   <td width="5"></td>
                                   <td>
                                        <table>
                                           <tr><td style="text-align:center;"> Stage </td></tr>
                                           <tr>
                                               <td>
                                                   <apex:selectList value="{!OppselectedStage}" multiselect="true" size="3" style="width:158px;">
                                                        <!-- <apex:selectOptions value="{!OppStageOptions}"/> -->
                                                        <apex:selectOption itemlabel="All" itemValue="1"/>
                                                        <apex:selectOption itemlabel="Created" itemValue="2"/>
                                                        <apex:selectOption itemlabel="Intro" itemValue="3"/>
                                                        <apex:selectOption itemlabel="Qualified" itemValue="4"/>
                                                        <apex:selectOption itemlabel="Qualified out" itemValue="5"/>
                                                        <apex:selectOption itemlabel="Demo" itemValue="6"/>
                                                        <apex:selectOption itemlabel="HOV" itemValue="7"/>
                                                        <apex:selectOption itemlabel="Offer" itemValue="8"/>
                                                    </apex:selectList>
                                               </td>
                                           </tr>
                                       </table>   
                                   </td>
                                   <td width="5"></td>
                                   <td>
                                       <table>
                                           <tr><td style="text-align:center;"> Interest </td></tr>
                                           <tr>
                                               <td >
                                                   <apex:selectList value="{!OppselectedInterest}" multiselect="true" size="3" style="width:158px;">
                                                        <apex:selectOptions value="{!OppInterestOptions}"/>
                                                   </apex:selectList>
                                               </td>
                                           </tr>
                                       </table>
                                   </td>
                                   <td width="5"></td>
                                   <td>
                                       <table>
                                           <tr><td style="text-align:center;">Broker/Dealer</td></tr>
                                           <tr><td style="text-align:center;"><apex:inputField value="{!OppObj.Broker_Dealer__c}" style="width:158px;"/></td></tr>
                                       </table>
                                   </td>
                                   <td width="10"></td>
                                   <td>
                                       <table>
                                           <tr><td style="text-align:center;"> Search Opportunity</td></tr>
                                           <tr>
                                               <td>
                                                   <apex:inputText value="{!OppsearchTerm}" label="Search Opportunity"  html-placeholder="Search Opportunity" style="width:158px;"/>
                                               </td>
                                           </tr>
                                       </table>
                                   </td>
                                   <td width="5"></td>
                                   <td>
                                       <table><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
                                           <tr>
                                              <td>
                                                 <apex:commandButton value="Search Opportunity" id="searchButton"  reRender="tableId,pageCount,nextId,Endid,prevId,firstId,error" status="searchStatus" action="{!searchOpportunity}" onclick="showmessage('{!$Component.input1}')"><apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/></apex:commandbutton>
                                               </td>
                                            </tr>
                                       </table>
                                   </td>
                               </tr>
                                            <!----picklist end ---->
                              <tr><td></td></tr>
                              <tr><td></td></tr>
                              <tr><td></td></tr>
                              <tr>
                                  <td>
                                      <apex:commandLink type="image/png" rerender="tableId,pageCount" status="refreshStatus"> 
                                          Refresh Grid
                                      </apex:commandLink>
                                  </td>
                              </tr>
                            </table>
                        </td></tr>
                        <tr><td width="100%">
                            <center>
                                  <table>
                                      <tr>
                                          <td style="width:45%;"></td>
                                          <td align="center" style="width:10%;">
                                              <apex:actionStatus id="searchStatus">
                                                <apex:facet name="start">
                                                      <apex:outputText style="font-weight:bold;font-size:16px;color:#3232FF;" value="....Searching...."/>
                                                </apex:facet>
                                              </apex:actionStatus>
                                              <apex:actionStatus id="refreshStatus">
                                                <apex:facet name="start">
                                                  <apex:outputText style="font-weight:bold;font-size:16px;color:#3232FF;" value="....Refreshing...."/>
                                               </apex:facet>
                                             </apex:actionStatus>
                                        </td>
                                    </tr>
                                </table>  
                              </center>  
                        </td></tr>
                        <tr><td width="100%">
                               <apex:pageBlockTable value="{!OpportunityObjList}" var="opWr" id="tableId">
                                      <apex:column headerValue="Opportunity Name" width="15%">
                                            <apex:facet name="header">
                                                <apex:commandLink value="Opportunity Name" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Opportunity Name" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Opportunity Name')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                            </apex:facet>          
                                            {!opWr.Name}
                                       </apex:column>
                                       <apex:column headerValue="Owner" width="15%">
                                           <apex:facet name="header">
                                              <apex:commandLink value="Owner" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Owner" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Owner')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                            </apex:facet>
                                            {!opWr.Owner.name}
                                       </apex:column>
                                       <apex:column headerValue="City" width="10%">
                                           <apex:facet name="header">
                                            <apex:commandLink value="City" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="City" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'City')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           {!opWr.Account.BillingCity}
                                       </apex:column>
                                       <apex:column headerValue="State" width="10%">
                                            <apex:facet name="header">
                                            <apex:commandLink value="State" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="State" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'State')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           {!opWr.Account.BillingState}
                                       </apex:column>
                                       <apex:column headerValue="Primary Contact" width="10%">
                                           <apex:facet name="header">
                                            <apex:commandLink value="Primary Contact" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Primary Contact" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Primary Contact')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           {!opWr.Contact__r.name}
                                       </apex:column>
                                       <apex:column headerValue="Stage" width="10%">
                                            <apex:facet name="header">
                                            <apex:commandLink value="Stage" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Stage" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Stage')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           <apex:outputText value="{!opWr.Current_Stage__c}" rendered="{!opWr.Current_Stage__c!=null}" >                                                                   
                                          </apex:outputText>
                                       </apex:column>
                                       <apex:column headerValue="Interest" width="10%">
                                            <apex:facet name="header">
                                                <apex:commandLink value="Interest" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Interest" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Interest')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           {!opWr.Interest__c}</apex:column>
                                       <apex:column headerValue="Broker/Dealer" width="10%">
                                           <apex:facet name="header">
                                                <apex:commandLink value="Broker/Dealer" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Broker/Dealer" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Broker/Dealer')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           <apex:outputfield value="{!opWr.Broker_Dealer__c}" />
                                        </apex:column>
                                       <apex:column headerValue="Next Due Date" width="10%">
                                       <apex:facet name="header">
                                                <apex:commandLink value="Next Due Date" action="{!toggleSort}" rerender="tableId" >
                                                    <apex:param name="sortField" value="Next Due Date" assignTo="{!sortField}"/>
                                                    <apex:param name="sortDir" value="{!sortDir}" assignTo="{!sortDir}"/>
                                                    <apex:param name="isSearch" value="true" assignTo="{!isSearch_opp}"/>
                                                    <apex:outputPanel rendered="{!BEGINS(sortField,'Next Due date')}">
                                                        &nbsp;<apex:image value="{!IF(sortDir = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                    </apex:outputPanel>
                                                </apex:commandLink>
                                             </apex:facet>
                                           <apex:outputText value="{0,date,MMM d,yyyy}" rendered="{!opWr.Next_Task_Due_Date__c!=null}"  style="color:{!IF(AND(opWr.Next_Task_Due_Date__c!=null,opWr.Next_Task_Due_Date__c<Today()),'red','black')}"> 
                                              <apex:param value="{!opWr.Next_Task_Due_Date__c}" /> 
                                          </apex:outputText>
                                       </apex:column> 
                                  </apex:pageBlockTable>
                              </td></tr>
                          </table>
                      </apex:outputPanel>   
                 </apex:pageBlockSection>
                 <center>
                     <table width="32%"><tr><td width="10%">  
                      <table border="1" cellspacing="0" bordercolor="#d1d3d6" width="80%" id="pagination" >
                             <tr height="15px"> 
                                 <td  style="text-align:center;width:10%"><apex:commandbutton value="<< Previous" style="background:none;bordtext-decoration: none;border:none;color:{!IF(DisablePrevious_opp==true,'#b8babc','#0cc8fc')}" action="{!OppPrevious}" id="prevId" disabled="{!DisablePrevious_opp}"/></td>
                                 <td  style="text-align:center;width:9%"><apex:commandbutton value="First Page" style="background:none;bordtext-decoration: none;border:none;color:{!IF(opp_offSet==0,'#0000FF','#0cc8fc')}" action="{!FirstPage_opp}" id="firstId" /></td>
                                 <td style="text-align:center;width:9%"><apex:commandbutton value="Last Page" style="background:none;bordtext-decoration: none;border:none;color:{!IF(opp_offSet>=(countTotalRecords_opp-opp_nextPageIndex),IF(AND(DisableNext_opp==true,opp_offSet==0),'#b8babc','blue'),'#0cc8fc')}" action="{!OppEnd}"  id="Endid" disabled="{!DisableNext_opp}"/></td>
                                 <td style="text-align:center;width:25%"><apex:commandButton value="Next >>" action="{!OppNext}" style="background:none;bordtext-decoration: none;border:none;color:{!IF(DisableNext_opp==true,'#b8babc','#0cc8fc')}" id="nextId" disabled="{!DisableNext_opp}"/></td>
                                
                              </tr>
                           </table> 
                       </td><td width="30%">
                           <apex:outputPanel id="pageCount" >
                                    {!pageCount_opp} of {!CountTotalRecords_opp} Records
                                </apex:outputPanel>
                         </td></tr>
                      </table>
                   </center>        
                   <hr size="1" noshade="0" />
                 
                  <apex:pageBlockSection columns="1" collapsible="true" title="Leads">
                         <apex:outputPanel >
                               <table width="100%" >
                                 <tr><td width="100%">
                                    <table width="10%" >
                                           <tr></tr>
                                           <tr></tr>
                                           <tr>
                                               <td width="40%">
                                                   <table width="10%">
                                                       <tr><td style="text-align:center;">Owner</td></tr>
                                                       <tr><td style="text-align:center;width:100%" ><apex:inputField value="{!LeadObj.Ownerid}" html-placeholder="Logged in User"  required="false"/></td></tr>
                                                   </table>
                                               </td>
                                               <td width="2px"></td>
                                               <td width="6%">
                                                   <table>
                                                       <tr><td style="text-align:center;"> Due Date In</td></tr>
                                                       <tr>
                                                           <td>
                                                               <apex:selectList value="{!LeadselectedDueDate}" multiselect="false" size="1" style="width:158px;">
                                                                    <apex:selectOptions value="{!OppDueDateInOptions}"/>
                                                                </apex:selectList>
                                                           </td>
                                                       </tr>
                                                    </table>
                                               </td>
                                               <td width="2"></td>
                                               <td width="6%">
                                                    <table>
                                                       <tr><td style="text-align:center;"> Lead Source </td></tr>
                                                       <tr>
                                                           <td>
                                                               <apex:selectList value="{!LeadselectedSourceDate}" size="1" style="width:158px;">
                                                                    <apex:selectOptions value="{!LeadSourceDateOptions}"/>
                                                                </apex:selectList>
                                                           </td>
                                                       </tr>
                                                   </table>   
                                               </td>
                                               <td width="2"></td>
                                               <td width="6%">
                                                   <table>
                                                       <tr><td style="text-align:center;"> Lead Status  </td></tr>
                                                       <tr>
                                                           <td >
                                                               <apex:selectList value="{!LeadselectedStatus}" multiselect="true" size="3" style="width:158px;">
                                                                    <apex:selectOptions value="{!LeadStatusOptions}"/>
                                                                </apex:selectList>
                                                           </td>
                                                       </tr>
                                                   </table>
                                               </td>
                                               <td width="2"></td>
                                               <td width="6%">
                                                   <table>
                                                       <tr><td style="text-align:center;">Broker/Dealer</td></tr>
                                                       <tr><td style="text-align:center;"><apex:inputField value="{!LeadObj.LeadBrokerDealer__c }" style="width:158px;"/></td></tr>
                                                   </table>
                                               </td>
                                               
                                               <td width="2"></td>
                                               <td width="6%">
                                                   <table>
                                                       <tr><td style="text-align:center;"> Search Leads</td></tr>
                                                       <tr>
                                                           <td>
                                                               <apex:inputText value="{!LeadsearchTerm}" label="Search Lead"  html-placeholder="Search Lead" style="width:158px;"/>
                                                           </td>
                                                       </tr>
                                                   </table>
                                               </td>
                                               <td width="2"></td>
                                               <td width="4%">
                                                   <table><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
                                                       <tr>
                                                          <td> 
                                                              <apex:commandButton value="Search Lead" id="LeadButton"  reRender="LeadtableId,pageCountl,pevId1,Firstid1,nextId1,endId1" status="searchLeadStatus" action="{!searchLead}" ><apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/></apex:commandbutton>
                                                          </td>
                                                        </tr>
                                                   </table>
                                               </td>
                                               <td width="2"></td>
                                               <td width="20%">
                                                   <table width="100%" ><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
                                                       <tr>
                                                          <td width="100%">
                                                             <apex:commandlink value="  NewLead " id="NewLeadButton" action="{!CreateNewlead}"  styleclass="btn " target="_blank" style="text-decoration:none;width:50px;text-align: center;line-height: 25px;padding-top:4px;padding-bottom:4px;"  />
                                                           </td>
                                                        </tr>
                                                   </table>
                                               </td>
                                           </tr>
                                                        <!----picklist end ---->
                                          <tr><td></td></tr>
                                          <tr><td></td></tr>
                                          <tr><td></td></tr>
                                          <tr>
                                              <td>
                                                  <apex:commandLink type="image/png" rerender="LeadtableId,pageCountl" status="refreshLeadStatus"> 
                                                      Refresh Grid
                                                  </apex:commandLink>
                                              </td>
                                          </tr>
                                        </table>
                                    </td></tr>
                                    <tr><td width="100%">
                                        <center>
                                              <table>
                                                  <tr>
                                                      <td style="width:45%;"></td>
                                                      <td align="center" style="width:10%;">
                                                          <apex:actionStatus id="searchLeadStatus">
                                                            <apex:facet name="start">
                                                                  <apex:outputText style="font-weight:bold;font-size:16px;color:#3232FF;" value="....Searching...."/>
                                                            </apex:facet>
                                                          </apex:actionStatus>
                                                          <apex:actionStatus id="refreshLeadStatus">
                                                            <apex:facet name="start">
                                                              <apex:outputText style="font-weight:bold;font-size:16px;color:#3232FF;" value="....Refreshing...."/>
                                                           </apex:facet>
                                                         </apex:actionStatus>
                                                    </td>
                                                </tr>
                                            </table>  
                                          </center>  
                                    </td></tr>
                                    <tr><td width="100%">
                                           <apex:pageBlockTable value="{!LeadObjList}" var="le" id="LeadtableId">
                                                <apex:column headerValue="Lead Name" width="15%">
                                                    <apex:facet name="header">
                                                        <apex:commandLink value="Lead Name" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Lead Name" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Lead Name')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                    {!le.Name}
                                                </apex:column>
                                                <apex:column headerValue="Owner" width="15%">
                                                    <apex:facet name="header">
                                                        <apex:commandLink value="Owner" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Owner" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Owner')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                    {!le.Owner.name}
                                                 </apex:column>
                                                 <apex:column headerValue="Company" width="10%">
                                                       <apex:facet name="header">
                                                        <apex:commandLink value="Company" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Company" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Company')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                      {!le.company}
                                                 </apex:column>
                                                 <apex:column headerValue="Lead Source" width="10%">
                                                     <apex:facet name="header">
                                                        <apex:commandLink value="LeadSource" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="LeadSource" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'LeadSource')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                      {!le.Leadsource}
                                                 </apex:column>
                                                 <apex:column headerValue="Phone" width="10%">
                                                     <apex:facet name="header">
                                                        <apex:commandLink value="Phone" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Phone" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Phone')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                      {!le.phone}
                                                 </apex:column>
                                                 <apex:column headerValue="Email" width="10%">
                                                     <apex:facet name="header">
                                                        <apex:commandLink value="Email" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Email" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Email')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                     {!le.Email}
                                                 </apex:column>
                                                 <apex:column headerValue="City" width="10%">
                                                     <apex:facet name="header">
                                                        <apex:commandLink value="City" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="City" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'City')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                     {!le.city}
                                                 </apex:column>
                                                 <apex:column headerValue="State" width="10%">
                                                       <apex:facet name="header">
                                                        <apex:commandLink value="state" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="state" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'state')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                     {!le.state}
                                                 </apex:column>
                                                 <apex:column headerValue="Next Due Date" width="10%">
                                                     <apex:facet name="header">
                                                        <apex:commandLink value="Next Due Date" action="{!toggleSortLead}" rerender="LeadtableId" >
                                                            <apex:param name="sortFieldLead" value="Next Due Date" assignTo="{!sortFieldLead}"/>
                                                            <apex:param name="sortDirLead " value="{!sortDirLead }" assignTo="{!sortDirLead }"/>
                                                            <apex:param name="isSearchLead" value="true" assignTo="{!isSearch_Lead}"/>
                                                            <apex:outputPanel rendered="{!BEGINS(sortFieldLead,'Next Due date')}">
                                                                &nbsp;<apex:image value="{!IF(sortDirLead  = 'desc','/img/arrowDown.gif','/img/arrowUp.gif')}"/>
                                                            </apex:outputPanel>
                                                        </apex:commandLink>
                                                     </apex:facet>
                                                     <apex:outputText value="{0,date,MMM d,yyyy}" rendered="{!le.Next_Task_Due_Date__c!=null}"  style="color:{!IF(AND(le.Next_Task_Due_Date__c!=null,le.Next_Task_Due_Date__c<Today()),'red','black')}"> 
                                                          <apex:param value="{!le.Next_Task_Due_Date__c}" /> 
                                                     </apex:outputText>
                                                 </apex:column>
                                            </apex:pageBlockTable>

                                         </td></tr>
                                    </table>
                               </apex:outputPanel> 
                      </apex:pageBlockSection>
                       <center>  
                         <table width="32%">
                             <tr><td width="10%">  
                                 <table border="1" cellspacing="0" bordercolor="#d1d3d6" width="100%" >
                                     <tr height="15px"> 
                                         <td  style="text-align:center;width:30%"><apex:commandbutton value="<< Previous" style="background:none;bordtext-decoration: none;border:none;color:{!IF(DisablePrevious_Lead==true,'#b8babc','#0cc8fc')}" action="{!LeadPrevious}" id="pevId1" disabled="{!DisablePrevious_Lead}"/></td>
                                         <td  style="text-align:center;width:9%"><apex:commandbutton value="First Page" style="background:none;bordtext-decoration: none;border:none;color:{!IF(Lead_offSet==0,'#0000FF','#0cc8fc')}" action="{!FirstPage_Lead}" id="Firstid1" /></td>
                                        <td style="text-align:center;width:9%"><apex:commandbutton value="Last Page" style="background:none;bordtext-decoration: none;border:none;color:{!IF(Lead_offSet>=(countTotalRecords_Lead-Lead_nextPageIndex),IF(AND(DisableNext_Lead==true,Lead_offSet==0),'#b8babc','blue'),'#0cc8fc')}" action="{!LeadEnd}"  id="endId1" disabled="{!OR(DisableNext_Lead=true)}"/></td>
                                         <td style="text-align:center;width:25%"><apex:commandButton value="Next >>" action="{!LeadNext}" style="background:none;bordtext-decoration: none;border:none;color:{!IF(DisableNext_Lead==true,'#b8babc','#0cc8fc')}" id="nextId1" disabled="{!OR(DisableNext_Lead=true)}"/></td>    
                                     </tr>
                                   </table> 
                               </td><td width="30%">
                                   <apex:outputPanel id="pageCountl" >
                                        {!pageCount_Lead} of {!CountTotalRecords_Lead} Records
                                    </apex:outputPanel>
                         </td></tr>
                      </table> 
                   </center> 
      </apex:pageBlock>
    </apex:form> 
</apex:page>
                                   
     */
  }