var GithubRepo;GithubRepo=function(){function e(e){null==e&&(e={}),this.api=new GithubApi({user:e.user,repo:e.repo})}return e.prototype.render=function(){this.api.version(function(e){return function(t){var i;i=jQuery.timeago(t.published_at),$("#"+e.api.repo+" .updated").text("Updated "+i),$("#"+e.api.repo+" .version").text("v"+t.tag_name)}}(this))},e}();