trigger exampletrigger2 on Gadget__c (before insert) {
/*
 * it only comes into pic while interaction with database
 * Events - before,after  && operation-insert,update,delete,undelete
   * Contextual Variables
 *   .isInsert
 * 	 .isUpdate
 *   .isDelete
 *   .isUndelete
 *   .isAfter
 *   .isBefore
 *   
 */
    //--------------------in case before insert----------------------
    //Trigger.new -> list type      //when we want to insert record by typing or data loader (for 1 million times each time triggers get triggred)
    //Trigger.old -> list type       //when we want to change(edit) the existing record then this list comes into pic
    //Trigger.newMap ->map type
    //trigger.oldMap ->map type
    //blukifyine      (alwys strts wth for loop in case before insert)
    for(Gadget__c g:Trigger.New){
        
    }
    
}