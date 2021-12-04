trigger EventTrigger on Message_Event__e (after insert) {
    system.debug('In outside eventtriggerclass');
    for(Message_Event__e values:Trigger.New){
        system.debug('In inside eventtriggerclass');
        List<Messaging.SingleEmailMessage> semail = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mails = new Messaging.SingleEmailMessage(); 
        String[] sendingTo = new String[]{'maitisubhadeep443@gmail.com'};
        mails.setToAddresses(sendingTo);
        mails.setSubject('Case Update @Salesforce');
        String body = values.Priority_Change__c;
        mails.setHtmlBody(body);
        semail.add(mails);
        System.debug('In Event trigger');
        try{
            Messaging.sendEmail(semail);
            System.debug('success');
        }catch(exception e){
            System.debug(e.getMessage());
        }
        		
    }
}