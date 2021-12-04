import { LightningElement } from 'lwc';
import getSingleIssue from '@salesforce/apex/JiraHostController.getSingleIssue';

export default class JiraHost extends LightningElement {
    result;
    key;
    getIssue(){
        getSingleIssue({
            key: this.key
        })
        .then(res=>{
            console.log('The details of issue SP-1 :--->', JSON.stringify(res));
            this.result = JSON.stringify(res);
        })
        .catch(err=>{
            console.log('Error Details', err);
            this.result = JSON.stringify(err);
        })
    }

    getId(event){
        this.key = event.target.value;
        console.log('key is === ',this.key);
    }
}