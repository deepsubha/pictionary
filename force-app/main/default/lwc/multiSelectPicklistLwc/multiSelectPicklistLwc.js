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
import {LightningElement, api, track} from 'lwc';
export default class MultiSelectPicklistLwc extends LightningElement {

    /* 
        component receives the following params:
        label - String with label name;
        disabled - Boolean value, enable or disable Input;
        options - Array of objects [{label:'option label', value: 'option value'},{...},...];
    
        to clear the value call clear() function from parent:
        let multiSelectPicklist = this.template.querySelector('c-multi-select-pick-list');
        if (multiSelectPicklist) {
           multiSelectPicklist.clear();
        }
   
        to get the value receive "valuechange" event in parent;
        returned value is the array of strings - values of selected options;
        example of usage:
        <c-multi-select-pick-list options={marketAccessOptions}
                                   onvaluechange={handleValueChange}
                                   label="Market Access">
        </c-multi-select-pick-list>

        handleValueChange(event){
            console.log(JSON.stringify(event.detail));
        }
    */


    @api label = "Default label";
    _disabled = false;
    @api
    get disabled(){
        return this._disabled;
    }
    set disabled(value){
        this._disabled = value;
        this.handleDisabled();
    }
    @track inputOptions;
    @track _start;
    @track _end;
    @track _pointer;
    connectedCallback(){
        this._start = 0;
        this._end = this.inputOptions ? this.inputOptions.length - 1 : 0;
        this._pointer = this._start;
        console.log('ans-->'+JSON.stringify(this.inputOptions))
        // this.inputOptions = this.inputOptions ? this.inputOptions.map(ele => { ele.highlight = false; return ele; }) : undefined;
            document.addEventListener('keydown', (event) => {
                var name = event.key;
                var code = event.code;
                if(code === 'ArrowDown'){         
                    this._pointer = this._pointer !== this._end ? this._pointer + 1 : this._start;
                    console.log('up arrow!!!!!!!----'+'  st: '+this._start+'  end: '+this._end+'  pt: '+this._pointer);
                    this.inputOptions[this._pointer].highlight = true;
                    console.log('selected industry-->'+JSON.stringify(this.inputOptions[this._pointer]))
                }
                else if(code === 'ArrowUp'){
                    this._pointer = this._pointer !== this._start ? this._pointer - 1 : this._end;
                    console.log('down arrow!!!!!!!!---'+'  st: '+this._start+'  end: '+this._end+'  pt: '+this._pointer);
                    this.inputOptions[this._pointer].highlight = true;
                    console.log('selected industry-->'+JSON.stringify(this.inputOptions[this._pointer]))
                }
                //alert(`Key pressed ${name} \r\n Key code value: ${code}`);
              }, false);
    }
    @api
    get options() {
        return this.inputOptions.filter(option => option.value !== 'All');
    }
    set options(value) {
        let options = [{
            value: 'All',
            label: 'All'
        }];
        this.inputOptions = options.concat(value);
        //this.inputOptions = this.inputOptions ? this.inputOptions.map(ele => { ele.highlight = false; return ele; }) : undefined;
    }
    @api
    clear(){
        this.handleAllOption();
    }
    value = [];
    @track inputValue = 'All';
    hasRendered;
    renderedCallback() {
        if (!this.hasRendered) {
            //  we coll the logic once, when page rendered first time
            this.handleDisabled();
        }
        this.hasRendered = true;
    }
    handleDisabled(){
        let input = this.template.querySelector("input");
        if (input){
            input.disabled = this.disabled;
        }
    }
    comboboxIsRendered;
    handleClick() {
        let sldsCombobox = this.template.querySelector(".slds-combobox");
        sldsCombobox.classList.toggle("slds-is-open");
        if (!this.comboboxIsRendered){
            let allOption = this.template.querySelector('[data-id="All"]');
            allOption.firstChild.classList.add("slds-is-selected");
            this.comboboxIsRendered = true;
        }
    }
    handleSelection(event) {
        let value = event.currentTarget.dataset.value;
        if (value === 'All') {
            this.handleAllOption();
        }
        else {
            this.handleOption(event, value);
        }
        let input = this.template.querySelector("input");
        input.focus();
        this.sendValues();
    }
    sendValues(){
        let values = [];
        for (const valueObject of this.value) {
            values.push(valueObject.value);
        }
        this.dispatchEvent(new CustomEvent("valuechange", {
            detail: values
        }));
    }
    handleAllOption(){
        this.value = [];
        this.inputValue = 'All';
        let listBoxOptions = this.template.querySelectorAll('.slds-is-selected');
        for (let option of listBoxOptions) {
            option.classList.remove("slds-is-selected");
        }
        let allOption = this.template.querySelector('[data-id="All"]');
        allOption.firstChild.classList.add("slds-is-selected");
        this.closeDropbox();
    }
    handleOption(event, value){
        let listBoxOption = event.currentTarget.firstChild;
        if (listBoxOption.classList.contains("slds-is-selected")) {
            this.value = this.value.filter(option => option.value !== value);
        }
        else {
            let allOption = this.template.querySelector('[data-id="All"]');
            allOption.firstChild.classList.remove("slds-is-selected");
            let option = this.options.find(option => option.value === value);
            this.value.push(option);
        }
        if (this.value.length > 1) {
            this.inputValue = this.value.length + ' options selected';
        }
        else if (this.value.length === 1) {
            this.inputValue = this.value[0].label;
        }
        else {
            this.inputValue = 'All';
        }
        listBoxOption.classList.toggle("slds-is-selected");
    }
    dropDownInFocus = false;
    handleBlur() {
        if (!this.dropDownInFocus) {
            this.closeDropbox();
        }
    }
    handleMouseleave() {
        this.dropDownInFocus = false;
    }
    handleMouseEnter() {
        this.dropDownInFocus = true;
    }
    closeDropbox() {
        let sldsCombobox = this.template.querySelector(".slds-combobox");
        sldsCombobox.classList.remove("slds-is-open");
    }
}