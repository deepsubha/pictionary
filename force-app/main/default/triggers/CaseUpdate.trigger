trigger CaseUpdate on Case (after update) {
    //List<Message_Event__e> updatedFields = new List<Message_Event__e>();
        
    system.debug('In start caseUpdate class');
    Message_Event__e mv = new Message_Event__e();
    mv.Priority_Change__c = 'priority change';
    //mv.Status_Change__c = 'status change';   
    EventBus.publish(mv);
	system.debug('In end caseUpdate class');
    
}