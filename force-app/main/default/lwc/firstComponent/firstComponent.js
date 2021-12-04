import { LightningElement , wire } from 'lwc';
import foobar from "@salesforce/apex/FirstComponent.foobar";
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import Opportunity from '@salesforce/schema/Opportunity';

export default class FirstComponent extends LightningElement {

    @wire(foobar)
    checkData(data,error){
        if(data){
            console.log(data.data);
        }
        else{
            console.log(data.error);
        }
    }
    // @wire(f)
    // function checkData({data,error}) {
    //     if(data)
    //         console.log(data);
    //     else
    //         console,log(error);
        
    // }
		
		@wire(getObjectInfo, { objectApiName: Opportunity })
    getInfo({error,data}){
       if(data){
         console.log('default record type id=>'+data.defaultTypeId);
					 console.log('all record type infos=>'+JSON.stringify(data.recordTypeInfos));
       }else if(error){
           console.log('error is=>');
        }
     }

}