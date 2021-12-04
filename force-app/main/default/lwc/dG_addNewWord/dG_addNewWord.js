import { LightningElement,wire } from 'lwc';
import getAllWords from '@salesforce/apex/DG_DataController.getAllWords';
import newWordInsertion from '@salesforce/apex/DG_DataController.newWordInsertion';
import { refreshApex } from '@salesforce/apex';
export default class DG_addNewWord extends LightningElement {

    @wire(getAllWords)
    allWords;

    newWords='';
    handleChange(event){
        this.newWords = event.target.value;
    }

    handleSave(){
        if(this.newWords !== '' || this.newWords !== null || this.newWords !== undefined ){
            newWordInsertion({newWords: this.newWords})
            .then(data=>{
                alert('resolved? :'+data);
                refreshApex(this.allWords);
            })
            .catch(err=>{
                alert('rejected? :'+JSON.stringify(err));
            })
        }else{
            alert('some error need to be handled!');
        }

    }
}