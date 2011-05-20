var History = backbone.Model.extend({
	//suelement méthode post authorisé :: save
	// attirbuts : passer recipe_id
	base : "/home/history",
	
	url : function() {
	      if (this.isNew()) return this.base;
	      return this.base + '/' + this.id; //sert pas à grand chose car jamais utilisé
	    },
	
	fetch : function(){
		//unauthorized
		return false;
	}
	
	destroy : function(){
		//unauthorized
		return false;
	}
});