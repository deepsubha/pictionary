import {LightningElement} from 'lwc';

export default class TestScroll extends LightningElement {

   handleScrollClick(){
       const topDiv = this.template.querySelector('[data-id="redDiv"]');
       //topDiv.scrollIntoView({behavior: "smooth", block: "center", inline: "nearest"});
       topDiv.scrollIntoView();
       //topDiv.scroll(0,10);
   }
}