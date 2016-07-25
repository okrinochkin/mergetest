global class BatchMassEmailDelivery implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    /*------------------------------------------------------------
    Batch Mail Delivery failed. Delivers email messages to lead with status 'Ready for Delivery'
    For execute batch use following line:
    Id batchInstanceId = Database.executeBatch(new BatchMassEmailDelivery(campaing_id, email_template_id), 10);
    */
    
    private Id CampaignId;
    public Id Stuck;
    private Id EmailTemplateId;
    private String Subj;
    private String EmailTemplatePerl;
    public String changes2 = '123';

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT ACCOUNT_BILLINGCITY__c, ACCOUNT_BILLINGCOUNTRY__c, ACCOUNT_BILLINGPOSTALCODE__c, ACCOUNT_BILLINGSTREET__c, ACCOUNT_INDUSTRY__c, ACCOUNT_ISVPROGRAMS__c, ACCOUNT_ISV_PROGRAM_TIER__c, ACCOUNT_ISV_SENIOR_AE__c, ACCOUNT_NAME__c, ACCOUNT_NUMBEROFEMPLOYEES__c, ACCOUNTID__c, Account__c, CreatedById, CreatedDate, IsDeleted, EMAIL__c, HOMEPHONE__c, LastActivityDate, LastModifiedById, LastModifiedDate, MOBILEPHONE__c, Notes__c, OwnerId, Priority_Name__c, Id, Selected__c, Spam_Status__c, Name, Success_Spam_Template__c, SystemModstamp, TITLE__c FROM Success_Lead__c WHERE Spam_Status__c = \'Selected for SPAM\'');
    }
    
    global BatchMassEmailDelivery() { }
    
    global void execute(Database.BatchableContext BC, List<Success_Lead__c> scope) {
        /*
        List<EmailStatus__c> esl = new List<EmailStatus__c>();
    
        
        Set<Id> TemplateSet = new Set<Id>();
        for (CampaignMember cm : scope) {
            TemplateSet.add(cm.Success_Spam_Template__c);
        }

        Map<Id, Success_Spam_Template__c> TempMap = new Map<Id, Success_Spam_Template__c>();
        Success_Spam_Template__c default_template = new Success_Spam_Template__c();

        for (Success_Spam_Template__c ss : [SELECT CreatedById, CreatedDate, IsDeleted, Is_Default__c, LastModifiedById, LastModifiedDate, OwnerId, Id, Subject__c, Name, SystemModstamp, Template_Body__c FROM Success_Spam_Template__c WHERE Id IN : TemplateSet OR Is_Default__c = true]) {

            TempMap.put(ss.Id, ss);
            if (Is_Default__c == true) default_template = ss;


        }





        List<Lead> LeadList = [SELECT Id, FirstName, Country, First_Name_Replace__c, LastName, Name, Email FROM Lead WHERE Id IN :LeadSet AND Status = 'Ready for Delivery' AND Duplicate__c = false];

        */
        Set<Id> LeadsSet = new Set<Id>();
        for (Success_Lead__c l : scope) {
            LeadsSet.add(l.Id);
        }
        Common.SendEmailToLead(LeadsSet);

          /*  
            l.Status = 'Contacted';
            l.Email_Sent_Datetime__c = system.now();
            EmailStatus__c es = new EmailStatus__c(
                Lead__c = l.Id,
                Type__c = 'Email Sent'
            );
            esl.add(es);
            */
            
        //}
        //update LeadList;
        //insert esl;
    }
    
    global void finish(Database.BatchableContext BC) {
    }
    
}
