---
layout: default
title: Blog
nav_order: 25
permalink: blog
---

# Developer Blog

This is the kscript developer's blog, which details new features being added to kscript, as well as examples, shout-outs, and more. 

Check out the posts below:

## Posts

<ul>
{% for post in site.posts %}
    {% unless post.next %}
        <h3>{{ post.date | date: '%Y-%m' }}</h3>
    {% else %}
        {% capture year %}{{ post.date | date: '%Y-%m' }}{% endcapture %}
        {% capture nyear %}{{ post.next.date | date: '%Y-%m' }}{% endcapture %}
        {% if year != nyear %}
        <h3>{{ post.date | date: '%Y-%m' }}</h3>
        {% endif %}
    {% endunless %}

    <li><a href="{{site.url}}{{ post.url }}">{{ post.date | date: '%Y-%m-%d' }} - {{ post.title }}</a></li>
{% endfor %}
</ul>


