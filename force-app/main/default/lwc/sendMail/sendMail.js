import { api, LightningElement,wire,track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import sendMail from '@salesforce/apex/OpportunityEmailSend.sendMail';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import MAIL_SENT_FIELD from '@salesforce/schema/Opportunity.Mail_Sent__c';
import ID_FIELD from '@salesforce/schema/Opportunity.Id';
// import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
const FIELDS = [
    'Opportunity.Name',  
    'Opportunity.AccountId', 
    'Opportunity.StageName',
    'Opportunity.Amount',
];

export default class SendMail extends LightningElement {
    @api targetid;
    @track data;
    @track error;
    @track message;
    accountRecordId;

    @wire(getRecord, { recordId: '$targetid', fields: FIELDS })
    wiredOpportunity({data,error}){
        if(data){
            this.data = data;
            this.error = undefined;
            console.log('in data'+JSON.stringify(this.data));
        }else if(error){
            this.data = undefined;
            this.error = error;
            console.log('in error'+this.error);
        }
    }
    get name() {
        return this.data.fields.Name.value;
    }   
    // get account() {
    //     this.accountRecordId = this.data.fields.AccountId.value;
    //     return this.data.fields.AccountId.value;
    // } 
    get amount() {
        return this.data.fields.Amount.value;
    }
    get stage() {
        return this.data.fields.StageName.value;
    }

    constructor(){
        super();
        console.log('in send mail cmp^^^'+this.targetid);
    }

    closeModal(){
        this.data=null;
        this.targetid='';
    }
    sendMailConfirm(){
        sendMail({
            id:this.targetid,
            message:this.message
        })
        .then(result=>{
            const fields = {};
            fields[ID_FIELD.fieldApiName] = this.targetid;
            fields[MAIL_SENT_FIELD.fieldApiName] = true;

            const recordInput = { fields };

            updateRecord(recordInput)
            .then(()=>{
                refreshApex();
            })
    
            this.targetid = '';
            this.data = null;
            console.log('toast event success !');
            this.targetid='';
            const event = new ShowToastEvent({
                title: 'Success',
                variant: 'success',
                message: 'mail sent!!',
            });
            this.dispatchEvent(event);
        })
        .catch(error=>{
            this.targetid = '';
            this.data = null;
            console.log('toast event fail !');
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'Something went wrong!!',
            });
            this.dispatchEvent(event);
        });
    }
    additionalMessage(event){
        this.message = event.target.value;
        console.log(this.message);
    }
}