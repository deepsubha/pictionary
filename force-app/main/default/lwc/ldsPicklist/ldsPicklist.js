/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 02-02-2021
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   02-02-2021   Amit Singh   Initial Version
**/
import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

const tempData = [
    {label: 'max', value:'max', highlight: false},
    {label: 'kisan', value:'kisan' , highlight: false},
    {label: 'sam', value: 'sam', highlight: false},
    {label: 'subha', value: 'subha', highlight: false},
    {label: 'deep', value: 'deep', highlight: false},
    {label: 'debasis', value: 'debasis', highlight: false},
    {label: 'foo', value: 'foo', highlight: false},
    {label: 'bar', value: 'bar', highlight: false},

]

export default class LdsPicklist extends LightningElement {

    picklistValues;
    error;
    @wire(getPicklistValues, { 
        recordTypeId: '0122w000001MLp0AAG', fieldApiName: INDUSTRY_FIELD 
    })
    wiredPicklist({ error, data }){
        
        if(data){
            this.picklistValues = data.values;
            // this.picklistValues = this.picklistValues.map(ele=>{
            //     ele.highlight = false;
            //     return ele;
            // })
            this.picklistValues = tempData;
            console.log(' data ->');
            this.error = undefined;
        }
        if(error){
            this.picklistValues = undefined;
            this.error = error;
        }
    }

    handleValueChange(event){
        console.log(JSON.stringify(event.detail));
    }
}