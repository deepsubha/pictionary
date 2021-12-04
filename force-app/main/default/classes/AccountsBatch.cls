global class AccountsBatch implements Database.Batchable<sObject> {
	
    global Database.QueryLocator start (Database.BatchableContext info){                   //start method to be implemented
        
        string query = 'SELECT Id, Name FROM Account';
    	return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext info,List<Account> scope){                 //execute() to be implemented
        
        
    }
    global void finish(Database.BatchableContext info){                                      //finish() to be implemented
        
    }
}