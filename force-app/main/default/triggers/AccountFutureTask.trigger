trigger AccountFutureTask on Account (after insert) {

    for(Account acc:Trigger.new){
        system.debug(acc.Id);
        system.debug(acc.id);
        FutureTest.foobar(acc.Id);
        
    }
}