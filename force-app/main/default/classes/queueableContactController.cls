public class queueableContactController implements Queueable {

    public void execute(QueueableContext context){
        
        //business logic
        List<Contact> a = [SELECT Id, LastName FROM Contact];
        
        for(Contact acc : a){
            acc.LastName = acc.LastName + ' - Updated';
        }
        
        update a;
    }
}
//in annonymous window
//queueableContactController q = new queueableContactController ();
//Id jobId=system.enqueueJob(q);
//system.debug('Job Id is -- 🚗' + jobId);
//