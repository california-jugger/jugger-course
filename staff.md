---
layout: page
title: Staff
nav_order: 5
description: A listing of all the course staff members.
---

## Instructors

<div class="role">
  {% assign instructors = site.staffers %}
  {% for staffer in instructors %}
  {{ staffer }}
  {% endfor %}
</div>
