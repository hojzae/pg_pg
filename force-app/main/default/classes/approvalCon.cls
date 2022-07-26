global with sharing class approvalCon {
    global String recordId {get;set;}
    // global String StageName {get;set;}
    // global List<Opportunity> oppList {get;set;}
    
    global String approvalUrl {get{
        return 'https://'+ System.URL.getSalesforceBaseUrl().getHost() + '/p/process/ProcessInstanceWorkitemWizardStageManager?id=' +[SELECT id FROM ProcessInstanceWorkitem WHERE processInstance.TargetObjectId=:recordID LIMIT 1].Id;
    }
                               set;}
    
    global Opportunity approvalInfo {
        get {approvalInfo = [SELECT Id, Name, StageName, CloseDate, Type, Owner.Name, ownerId 
                             FROM Opportunity 
                             WHERE Id =: recordId];
             return approvalInfo;
            }
        set;
    }
    
    global ProcessinstanceStep requestComments {
        get{requestComments = [SELECT Comments,ActorId
                               FROM ProcessinstanceStep
                               WHERE ActorId = :approvalInfo.ownerId 
                               ORDER BY CreatedDate desc 
                               LIMIT 1
                              ];
            return requestComments;
           }
        set;
    }
}