<!---
LICENSE INFORMATION:

Copyright 2012, Adam Tuttle

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.

You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Recent Entries.
--->
<cfoutput>

<cfset local.count = getSetting('CountToShow') />
<cfset local.posts = getManager().getPostsManager().getPosts( count=local.count ) />

<div id="RecentEntries">
	<cfif eventName eq "RecentEntries-pod">
		<h2>#getSetting('podTitle')#</h2>
	</cfif>
	<ul>
		<cfloop from="1" to="#min(local.count,arrayLen(local.posts))#" index="local.i">
			<cfset local._post = local.posts[local.i] />
			<li>
				<a href="#local._post.getUrl()#">#local._post.getTitle()#</a>
				<cfif getSetting('BlurbLength') gt 0>
					<cfset local.blurb = local._post.getExcerpt() />
					<cfif len(local.blurb) eq 0>
						<cfset local.blurb = local._post.getContent() />
					</cfif>
					<cfset local.blurb = clean(local.blurb) />
					<span>#local.blurb#...</span>
				</cfif>
			</li>
		</cfloop>
	</ul>
</div>
</cfoutput>
