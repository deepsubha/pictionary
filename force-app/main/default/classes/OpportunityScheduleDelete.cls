//***************************This is to schedule the batch apex class named: OpportunityDelete************************************//


global class OpportunityScheduleDelete implements Schedulable{
	global void execute(SchedulableContext sc)
    {
        OpportunityDelete b = new OpportunityDelete ();
       
        //with a batch size of 100 
        database.executebatch(b,100);
    }
}