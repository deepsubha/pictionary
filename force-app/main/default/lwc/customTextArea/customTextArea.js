import { LightningElement, api } from 'lwc';

export default class CustomTextArea extends LightningElement {
    @api cardId;
    @api name;
    @api commentator;
    @api notes;
    @api comments;

    val='';

    onInput(e){
        this.val = e.target.value;
        this.textChange();
    }

    textChange(){
        const updateEvent = new CustomEvent('change',{
            detail:{value: this.val}
        });
        this.dispatchEvent(updateEvent);
    }
}