trigger firstTriggers on Gadget__c (before insert) {
	system.debug('hello world!!');
}