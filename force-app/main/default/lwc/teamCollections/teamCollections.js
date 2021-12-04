import { LightningElement, wire,track } from 'lwc';
import getAllTeamsInfo from '@salesforce/apex/TeamController.getAllTeamsInfo';
import updateNotes from '@salesforce/apex/TeamController.updateNotes';
import { refreshApex } from '@salesforce/apex';

export default class TeamCollections extends LightningElement {
teamsInfo
textValue='';
commentatorId='';
@wire(getAllTeamsInfo) teamsInfo;
constructor(){
    super();
    document.onkeyup=function(e){
        var e = e || window.event; // for IE to cover IEs window event-object
        if(e.shiftKey && e.which == 65) {
          alert('Keyboard shortcut working!');
          return false;
        }
      }
}
handleChange(e){
    const {textId, commentatorId} = e.target.dataset;
    this.commentatorId = commentatorId;
    this.textValue = e.detail.value? e.detail.value:'';
}

handleSave(e){
    updateNotes({updatedNotes: this.textValue})
    .then(res=>{
        refreshApex(this.teamsInfo);
				const updatedTeamsInfo = this.teamsInfo;
    })
    .catch(error=>{ })
}

handleClear(e){}

}