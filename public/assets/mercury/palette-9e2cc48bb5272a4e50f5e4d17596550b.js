(function(){var t={}.hasOwnProperty,e=function(e,i){function n(){this.constructor=e}for(var o in i)t.call(i,o)&&(e[o]=i[o]);return n.prototype=i.prototype,e.prototype=new n,e.__super__=i.prototype,e};this.Mercury.Palette=function(t){function i(t,e,n){this.url=t,this.name=e,this.options=null!=n?n:{},i.__super__.constructor.apply(this,arguments)}return e(i,t),i.prototype.build=function(){var t;return this.element=jQuery("<div>",{"class":"mercury-palette mercury-"+this.name+"-palette loading",style:"display:none"}),this.element.appendTo(null!=(t=jQuery(this.options.appendTo).get(0))?t:"body")},i.prototype.bindEvents=function(){var t=this;return Mercury.on("hide:dialogs",function(e,i){return i!==t?t.hide():void 0}),i.__super__.bindEvents.apply(this,arguments)},i.prototype.position=function(t){var e,i;return this.element.css({top:0,left:0,display:"block",visibility:"hidden"}),e=this.button.position(),i=this.element.width(),e.left+i>jQuery(window).width()&&(e.left=e.left-i+this.button.width()),this.element.css({top:e.top+this.button.height(),left:e.left,display:t?"block":"none",visibility:"visible"})},i}(Mercury.Dialog)}).call(this);