---
permalink: /
title: "PROJ TEST"
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

This is the front page ("about"), that is being served from the docs dir of a github project. 
so the git path is https://[acct].github.com/[project]/docs
and this page's url is  https://[acct].github.io/[project]

created by copying the template for academic pages, here:  [academicpages template](https://github.com/academicpages/academicpages.github.io) 

Original instructions can be found here (among other places:
https://mobb.github.io/academicpages-test/

It might be a little heavy for what a project needs. but features I like:
1. files lives in the docs dir of a git project, so website-files don't swamp the other project material.
1. pages are composed in markdown, then converted to html by git
1. site has navigation along the top, which can be customized.
1. since it's git, there can be multiple contributors, but still managed by EDI group.

Other stuff that might be useful:
1. some pages' metadata can be used to generate indexes. eg, a 'list of talks' on the Talks page (https://mobb.github.io/academicpages-test/talks/).


What I don't know yet:
1. what will break since it's no longer at the repo root. note that funny ", , 1900". that was not in the original fork of adacemicpages. it might be a default date.
1. presuming I didn't break the whole thing, how much can I drop and still have a functional website?
1. this template has a dir for /files/. do we need that? or is it better to put static files (eg, pdfs) in the main code <> area?
1. how to tag. It would be great if some one could search acoss all EDI repos, eg, for a content type, like "best practices" or "how-to", or for a subject, like "units" or 
 
 
YOu are looking for a template with the simplicity of serving from /docs/, but
1. navigation can be configured so projects have the same look/feel
1. same for layout
1. pages are kept in markdown
1. website material (pages, config, scripts) are kept in a subdir, so they dont swamp the rest of the project.
 

Other tests:
1. directly from master: https://mobb.github.io/EML-BP-test/
this is a fork of minimalmistakes, installed in the recommended way (served from master).  academicpages is based on this. it might be the better template, but I have not yet found the navigation, etc. 
1. directly from master: https://mobb.github.io/academicpages-test/
fork of adacemicpages, installed as recommended.
1. from docs, with a single page: https://ediorg.github.io/ECC/
simply has a single page, index.md served from the project's docs dir (https://github.com/EDIorg/ECC/tree/master/docs)
1. from branch gh-pages: http://mobb.github.io/litterbox/
same URL as this one; this was in an earlier incarnation. have to change the settings to see it.




For more info
------
More info about configuring academicpages can be found in [the guide](https://academicpages.github.io/markdown/). The [guides for the Minimal Mistakes theme](https://mmistakes.github.io/minimal-mistakes/docs/configuration/) (which this theme was forked from) might also be helpful.
