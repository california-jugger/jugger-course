---
layout: home
title: Home
nav_order: 0
description: >-
    Course website for ERG98 Introduction to Jugger
---
<!-- <div class="parallax-window" data-parallax="scroll" data-image-src="/assets/background.png" data-speed="0.1">/div> -->
# ERG98 | Introduction to Jugger
{: .mb-2 }
Fall 2026
{: .mb-0 .fs-6 .text-grey-dk-200 }

<hr>

{% if site.announcements %}
{{ site.announcements.last }}
<a href="{{ site.baseurl }}/announcements" class="btn btn-outline fs-3">
  All Announcements
</a>
{% endif %}

# Course Calendar

{% for module in site.modules %}
{{ module }}
{% endfor %}
