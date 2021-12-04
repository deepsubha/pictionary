public class AccountHandler {
    public Boolean handleAccount(List<Account> accList){
         
        System.debug('Trigger is executing : ' + Trigger.isExecuting);
         
        if(Trigger.isExecuting){
            //Do what ever you want to do as part of the trigger invocation
            System.debug('calling from trigger'+accList);
        }
        else{
            //Do what ever you want to do if the call originated from different context, such as from controller.
            System.debug('not from trigger');

        }
        return Trigger.isExecuting;
    }

}