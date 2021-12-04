public class ExecuteBatchController {
    
        public void handleBacth(){
        AccountsBatch ab = new AccountsBatch();
        Id jId=Database.executeBatch(ab,2);
            system.debug('job id is ✌'+ jId);
    }

}