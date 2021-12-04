public class FutureTest {
    
    
    @future(callout=true)
    public static void foobar(String recId){
        Task t=new Task();
        t.Subject='New Future Task !';
        t.WhatId=recId;
        insert t;
    }

}