# Recent Entries Pod Plugin for Mango Blog

This project is a plugin for [Mango Blog](http://www.mangoblog.org) that adds a Pod (requires a pod-enabled theme) showing a list of your most recent published blog posts.

## Configuration options:

* Pod Title
* Number of posts to list
* Number of characters from the excerpt (or body, if excerpt is blank) to include. Set to 0 for none.

## Styling

CSS Styling is left entirely up to you. The HTML that is emitted will resemble:

	<div id="RecentEntries">
		<ul>
			<li>
				<a href="http://yourblog.com/post/post-title">Post Title</a>
				<span>Post Excerpt...</span>
			</li>
		</ul>
    </div>

## LICENSE

Copyright 2012, Adam Tuttle

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.

You may obtain a copy of the License at: http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
