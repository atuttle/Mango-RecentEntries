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
<cfscript>
	//handle settings form post
	if (structKeyExists(form, "podTitle")){
		local.update = structNew();
		local.update.PodTitle = form.podTitle;
		local.update.CountToShow = form.countToShow;
		local.update.BlurbLength = form.blurbLength;
		setSettings(argumentCollection=local.update);
		persistSettings();
		event.data.message.setstatus("success");
		event.data.message.setType("settings");
		event.data.message.settext("Recent Entries Plugin Settings Updated");
	}
</cfscript>

<style type="text/css">
	.err {
		display: block;
		border: 0;
		border-top: 1px solid #aa0000 !important;
		border-bottom: 1px solid #aa0000 !important;
		background: #ff99cc !important;
		color: #000000 !important; /* #aa0000 */
	}
	.msg {
		display: block;
		border: 0;
		border-top: 1px solid #cccc33;
		border-bottom: 1px solid #cccc33;
		background: #ffff99;
		color: #000000;
		padding: 8px;
	}
</style>

<cfoutput>
<form method="post" action="">
	<fieldset>
		<legend>Settings</legend>
		<p>
			<label for="podTitle">Pod Title:</label>
			<span class="hint">
				Title to display over the pod.
			</span>
			<span class="field">
				<input type="text" id="podTitle" name="podTitle" value="#getSetting('podTitle')#" size="30" />
			</span>
		</p>
		<p>
			<label for="podBlurb">Count to show:</label>
			<span class="hint">
				Number of recent entries to display
			</span>
			<span class="field">
				<input type="text" id="countToShow" name="countToShow" value="#getSetting('CountToShow')#" size="4" />
			</span>
		</p>
		<p>
			<label for="podBlurb">Blurb Length:</label>
			<span class="hint">
				In addition to the title, display this many characters of the excerpt (if available, otherwise the post body). Enter zero for no blurb.
			</span>
			<span class="field">
				<input type="text" id="blurbLength" name="blurbLength" value="#getSetting('BlurbLength')#" size="4" />
			</span>
		</p>
		<input type="submit" value="Save Changes" />
	</fieldset>
</form>
</cfoutput>
