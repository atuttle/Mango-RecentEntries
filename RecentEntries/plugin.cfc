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

This file is part of RecentEntries.
--->
<cfcomponent displayname="Plugin" extends="BasePlugin">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />

		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/fusiongrokker/plugins/RecentEntries") />

		<!--- set default preferences --->
		<cfset initSettings(
			PodTitle = "Recent Entries",
			CountToShow = 5,
			BlurbLength = 0
		)/>

		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "RecentEntries plugin activated.<br/>Would you like to <a href='generic_settings.cfm?event=RecentEntries-settings&amp;owner=RecentEntries&amp;selected=RecentEntries-settings'>change its settings</a>?" />
	</cffunction>
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "RecentEntries Plugin De-activated" />
	</cffunction>
	<cffunction name="upgrade" hint="This is run when upgrading from a previous version with auto-install" output="false" returntype="any">
		<cfreturn "RecentEntries Plugin Upgrade complete." />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<!--- this plugin doesn't respond to any asynch events --->
		<cfreturn />
	</cffunction>
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<cfset var eventName = arguments.event.getName()/>
		<cfset var local = structNew()/>

		<cfif eventName EQ "RecentEntries-pod">
			<cfsavecontent variable="local.content">
				<cfinclude template="podContent.cfm"/>
			</cfsavecontent>
			<cfset event.outputData = event.outputData & local.content />

		<cfelseif eventName EQ "getPods">
			<!--- render pod body --->
			<cfsavecontent variable="local.content">
				<cfoutput>
					<cfinclude template="podContent.cfm" />
				</cfoutput>
			</cfsavecontent>
			<cfset local.pod = structnew() />
			<cfset local.pod.title = getSetting("PodTitle") />
			<cfset local.pod.content = local.content />
			<cfset local.pod.id = "recentEntries" />
			<cfset arguments.event.addPod(local.pod)>

		<cfelseif eventName EQ "getPodsList">
			<!--- register the pod for the pod-manager --->
			<cfset local.pod = structnew() />
			<cfset local.pod.title = "RecentEntries" />
			<cfset local.pod.id = "recentEntries" />
			<cfset arguments.event.addPod(local.pod)>

		<cfelseif eventName EQ "settingsNav">
			<!--- adds plugin's link to the list of settings pages --->
			<cfset local.link = structnew() />
			<cfset local.link.owner = "RecentEntries">
			<cfset local.link.page = "settings" />
			<cfset local.link.title = "Recent Entries" />
			<cfset local.link.eventName = "RecentEntries-settings" />
			<cfset arguments.event.addLink(local.link)>

		<cfelseif eventName EQ "RecentEntries-settings">
			<!--- render settings page --->
			<cfsavecontent variable="local.content">
				<cfoutput>
					<cfinclude template="settings.cfm">
				</cfoutput>
			</cfsavecontent>
			<cfset local.data = arguments.event.data />
			<cfset local.data.message.setTitle("Recent Entries Pod settings") />
			<cfset local.data.message.setData(local.content) />

		</cfif>
		<cfreturn arguments.event />
	</cffunction>


	<!--- util --->
	<cffunction name="clean">
		<cfargument name="in">
		<cfreturn left( reReplace(arguments.in,'<[^>]+>','','all'), getSetting('BlurbLength') ) />
	</cffunction>

</cfcomponent>
