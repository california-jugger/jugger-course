# Intro to Jugger — Course Website

Live site:
[jugger.studentorg.berkeley.edu/decal-fa26/](https://jugger.studentorg.berkeley.edu/decal-fa26/)

Source for the Berkeley DeCal **Introduction to Jugger** (ERG 98, Fall 2026).
The content is meant to be reusable — fork it if you’re teaching a similar class.

This README assumes you’re comfortable with git, Markdown, and static sites in
general, but may never have touched **Ruby** or **Jekyll**.

---

## Overview
Ok so I had never used jekyll or ruby before when I ~~made this~~ copied this site from a class I took. Hopefully this doc will make it a little easier for you.

here's the stack, at a high level:
- jekyll: static site generator in Ruby. combines markdown and some templates, writes html.
- bundler: ruby's package manager. works with the `Gemfile`.
- `github-pages` gem (package): pins versions to what github pages uses, so deploying there is easy (we're not right now but *you* can)
- just-the-docs: a theme
- Liquid: template language

tldr; you just write markdown and the templates and css here will handle making it look nice.

## Prerequisites

1. install ruby 3.4.9. Use [rbenv](https://github.com/rbenv/rbenv).
2. if bundler wasn't installed with ruby, run `gem install bundler`
3. (optional) [just](https://github.com/casey/just), a command runner. see `justfile`;

## Quick start

```bash
git clone https://github.com/california-jugger/jugger-course.git
cd jugger-course

# one-time: install gems into the project
bundle install

# serve
bundle exec jekyll serve
```

Open the URL Jekyll prints. Note the path includes `baseurl`
(`/decal-fa26/` from `_config.yml`). You can (should) change this to
whatever you want your site to be.

build writes the site to `_site/` but doesnt serve it:

```bash
bundle exec jekyll build
# or: just build
```

Other notes:

- `_site/` is gitignored; don't edit it. it's just built files.
- `_config.yml` is **not** hot-reloaded. After changing it, stop and restart `jekyll serve`.

---

### Front matter

Every content file starts with YAML between `---` fences:

```markdown
---
title: Policies
nav_order: 3
layout: page
---

# Policies

Body in Markdown…
```

Jekyll reads the YAML into `page.*` (or collection document fields), then
renders the body through the chosen layout.

### Nav pages vs collections

| Kind | Where | Purpose |
| --- | --- | --- |
| **Pages** | `*.md` at repo root (`index.md`, `assignments.md`, `staff.md`, …) | Top-level nav (sidebar). `nav_order` controls order; `nav_exclude: true` hides from nav. |
| **Collections** | `_modules/`, `_assignments/`, `_staffers/`, `_announcements/` | Structured content rendered by custom layouts. Listed as `site.modules`, `site.assignments`, etc. |

Collections are declared in `_config.yml` under `collections:`.

- `output: false` — used as data / embedded fragments only (modules, staffers, announcements). Not standalone URLs.
- `output: true` — each file becomes a page (assignments → `/assignments/<slug>/`).

---

## Editing content

Generally speaking, you should just be able to look at the .md files
that exist here and make adjustments as you see fit.

### Weekly modules (`_modules/`)

Shown on the home page as the course calendar. We did one per week,
since we had one class per week, but these could represent anything
you want. I've also had classes where they had multiple classes in one
week all condensed into one module.

- `assignments` corresponds to files in `_assignments/`
- filename order = display order (`week01.md`, `week02.md`, …).

### Assignments (`_assignments/`)

One file per assignment. Slug = filename without extension
(`quiz-1.md` -> slug `quiz-1` -> URL `/decal-fa26/assignments/quiz-1/` when published).

to make an assigment show up on a module, add its slug under that module’s
`assignments:` list (see above).

if `published: false`, the file content is hidden.

> Note: with `published: false`, the page is still generated, it's just not linked. I assume this is fine since 

### Staff (`_staffers/`)

pretty basic. put photos under `assets/staff_pics/`.  
everything is rendered on `staff.md`.

### Announcements (`_announcements/`)

Latest announcement is featured on the home page; full list on
`announcements.md`.

### Top-level pages

Edit the root `*.md` files for Policies, Resources, About, Schedule, etc.
Front matter fields that matter for the sidebar:

- `title` — nav label  
- `nav_order` — sort key (lower = higher in the list)  
- `nav_exclude: true` — omit from sidebar  
- `layout: page` (or `home` on the index)

External links in the sidebar (Syllabus, Discord, …) come from `nav_links` in
`_config.yml`, not from Markdown files.

---

## Site configuration (`_config.yml`)

at least look into changing:

- `title`, `description`, `author`, `email`: branding/authorship info
- `url`: host base url. we have it set to `https://jugger.studentorg.berkeley.edu`. if you host with github pages, for example, you'd set it to `https://yourname.github.io`
- `baseurl`: the subpath the site should be served on. we have `/decal-fa26/`; it's whatever comes after `url`.

After any change here restart `jekyll serve`


## Deploy

right now there's a github action (in `.github/workflows/` that
updates the site when anyone pushes to main. This is great if you
already have a server that you want to use to host this, since you can
just set your fork's repository secrets (`HOST`, `USERNAME`, and
`KEY`) to the right values for your server and it'll just work.

Make sure you update `baseurl` and `url` according to where you plan
to deploy!

An easier way to make your site live is through *github pages*. If
your fork is public, you can go to repository settings -> pages, set
*source* to "Deploy from a branch" and *Branch* to anything other than
None (presumably "main").

Github will then make your site available at
`https://your-username.github.io/baseurl/`. Make sure to set your
`url` to `https://your-username.github.io` to make everything work.
