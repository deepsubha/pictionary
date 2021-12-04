public class EmailSend {
    public Account acc{get;set;}
    public String eSub{get;set;}
    public String eBody{get;set;}
    public EmailSend(){
        eSub='';
        eBody='';
        acc=[select Name,(select Name,Id,Email from Account.Contacts) from Account where Id=:ApexPages.currentPage().getParameters().get('id')];
    }
    
    public PageReference sendMail(){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        PageReference pdfExample = Page.SummaryPdf;
        pdfExample.setRedirect(true);
        Blob b=pdfExample.getContent();
        
        Messaging.EmailFileAttachment fa =new Messaging.EmailFileAttachment();
        fa.setFileName('AccountSummaryTesting.pdf');
        fa.setBody(b);
        
        String add;
        if(acc.Contacts[0].Email != null){
            add = acc.Contacts[0].Email;
            for(Integer i=0;i<acc.Contacts.size();i++){
                if(acc.Contacts[i].Email != null){
                    add += ';'+acc.Contacts[i].Email;
                }
            }
        }
        String[] toAddress = add.split(';',0);
        mail.setSubject(eSub);
        mail.setPlainTextBody(eBody);
        mail.setToAddresses(toAddress);
        system.debug('add '+toAddress);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{fa});
        Messaging.SendEmailResult[] r= Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        system.debug('result '+r);
        return null;
    }
}