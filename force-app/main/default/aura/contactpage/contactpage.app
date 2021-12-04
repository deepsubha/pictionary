<aura:application >
    <link href='/resource/bootstrap/' rel="stylesheet"/>
    <div class="navbar navbar-default navbar-static-top" role="navigation">
       <div classs="container">
           <div class="navbar-header">
               <a href="#" class="navbar-brand">Lightning Contacts</a>
        
            </div> 
        </div>
    </div>
    
    <div class="container">
       <div classs="row">
           <div class="col-sm-12">
               Contact Lists
               <c:contactdetails/>
               <c:contactlist/>
               
            </div> 
        </div>
    </div>
    
</aura:application>