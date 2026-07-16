---
layout: page
title: Assignments
nav_order: 1
description: All course assignments.
---

# Assignments

{% assign sorted = site.assignments | sort: "due" %}
{% for assignment in sorted %}
{% include assignment_card.html assignment=assignment %}
{% endfor %}
