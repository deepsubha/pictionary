public with sharing class OpportunityEmailSend {
    public string ccMail;
    public string repMail;

    public OpportunityEmailSend() { }

    @AuraEnabled(cacheable=true)
    public static void sendMail(String id,String message){
        string toMail = 'maitisubhadeep443@gmail.com';
        System.debug('id is: '+id);
        Opportunity op = [select Id,Name,Account.Name,Amount,StageName,Type,Mail_Sent__c from Opportunity where Id=:id];
        system.debug(op);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        string[] to = new string[] {toMail};
        // string[] cc = new string[] {ccMail};
        
        email.setToAddresses(to);
        // if(ccMail!=null && ccMail != '')
	    //     email.setCcAddresses(cc);
        // if(repmail!=null && repmail!= '')
        // 	email.setInReplyTo(repMail);
        String sub = 'Opportunity Reminder - '+op.Name;
        email.setSubject(sub);
        String body = 'Hello '+op.Account.Name+',<br/>This is to remind you the updated Opportunity Details. <br/><br/>'+
                      '<b>Opportunity Name:</b> '+op.Name+'<br/>'+
                      '<b>Account Name:</b> '+op.Account.Name+'<br/>'+
                      '<b>Stage Name:</b> '+op.StageName+'<br/>'+
                      '<b>Type:</b> '+op.Type+'<br/>'+
                      '<b>Amount:</b> '+op.Amount+'<br/>'+
                      '<b>P.S: '+message+'.<b/>'+
                      ' <br/><br/><br/>Regards<br/> Developer';
        email.setHtmlBody(body);
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });  
        }catch(exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
        }
        toMail = '';
        // ccMail = '';
        // repMail = '';
        sub='';
        body='';
        op = null;
    }
}