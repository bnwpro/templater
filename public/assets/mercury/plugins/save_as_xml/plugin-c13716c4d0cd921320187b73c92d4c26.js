(function(){var r,e={}.hasOwnProperty,n=function(r,n){function t(){this.constructor=r}for(var o in n)e.call(n,o)&&(r[o]=n[o]);return t.prototype=n.prototype,r.prototype=new t,r.__super__=n.prototype,r};Mercury.PageEditor=function(e){function t(){return r=t.__super__.constructor.apply(this,arguments)}return n(t,e),t.prototype.save=function(){var r,e,n,t;e=null!=(n=null!=(t=this.saveUrl)?t:Mercury.saveUrl)?n:this.iframeSrc(),r=this.serializeAsXml(),console.log("saving",r)},t.prototype.serializeAsXml=function(){var r,e,n,t,o,i,s,p;r=this.serialize(),n=[];for(e in r){t=r[e],i=[],p=t.snippets;for(o in p)s=p[o],i.push("<"+o+' name="'+s.name+'"><![CDATA['+jQuery.toJSON(s.options)+"]]></"+o+">");n.push('<region name="'+e+'" type="'+t.type+'"><value>\n<![CDATA['+t.value+"]]>\n</value><snippets>"+i.join("")+"</snippets></region>")}return"<regions>"+n.join("")+"</regions>"},t}(Mercury.PageEditor)}).call(this);