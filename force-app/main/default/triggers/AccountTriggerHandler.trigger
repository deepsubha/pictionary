trigger AccountTriggerHandler on Account (before insert, before update) {
    System.debug('in Account trigger!!');
    AccountHandler handler = new AccountHandler();
    boolean res = handler.handleAccount(Trigger.New);
    system.debug(res);
}