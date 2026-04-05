---
author: Lance McCarthy
title: Rich Content and Shortcodes
date: 2010-01-01
description: "Cheatsheet: Hugo content features and shortcodes"
tags: ["shortcodes", "markdown", "code", "youtube", "vimeo", "twitter"]
thumbnail: https://picsum.photos/id/1002/400/250
math: true
aliases:
  - /rich-content-shortcodes/
  - /2010/01/01/rich-content-shortcodes/
---

This page is a living cookbook of content features available in this site. It combines standard Markdown, Hugo built-in shortcodes, and custom shortcodes in one place so future posts are fast to author.

## <!--more-->

## Markdown Basics

### Text formatting

You can use **bold**, _italic_, ~~strikethrough~~, and inline code like `dotnet build`.

### Lists

1. Ordered list item
2. Another ordered list item
3. One more ordered list item

- Unordered list item
- Another unordered item
- Yet another item

- [x] Task list complete item
- [ ] Task list pending item

### Blockquote

> Good writing is clear thinking made visible.
>
> You can include **Markdown** inside blockquotes.

### Table

| Feature | Syntax | Notes |
| ------- | ------ | ----- |
| Bold | `**text**` | Great for emphasis |
| Code | `` `text` `` | Good for commands and identifiers |
| Link | `[label](url)` | Use absolute or relative URLs |

### Footnote

Footnotes are useful for side notes in longer posts.[^footnote-example]

[^footnote-example]: This is a sample footnote rendered by Goldmark.

---

## Code Blocks

### Fenced code block

```csharp
public static int Add(int a, int b)
{
    return a + b;
}
```

### Hugo highlight shortcode

This is useful when you want line numbers and highlighted lines.

{{< highlight csharp "linenos=table,hl_lines=3" >}}
public static int Add(int a, int b)
{
    return a + b;
}
{{< /highlight >}}

### Multi-tab code blocks (custom pattern)

This site does not have a built-in tabs shortcode right now, but you can still create clean tabbed code snippets with `rawhtml`.

{{< rawhtml >}}
<style>
  .code-tabs {
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    overflow: hidden;
    margin: 1rem 0;
  }

  .code-tabs input[type="radio"] {
    display: none;
  }

  .code-tabs .tab-labels {
    display: flex;
    background: #f3f4f6;
    border-bottom: 1px solid #d1d5db;
  }

  .code-tabs .tab-labels label {
    padding: 0.6rem 0.9rem;
    cursor: pointer;
    font-weight: 600;
    font-size: 0.9rem;
    border-right: 1px solid #d1d5db;
  }

  .code-tabs .tab-panel {
    display: none;
  }

  #tab-css:checked ~ .tab-labels label[for="tab-css"],
  #tab-html:checked ~ .tab-labels label[for="tab-html"] {
    background: #ffffff;
  }

  #tab-css:checked ~ .tab-content #panel-css,
  #tab-html:checked ~ .tab-content #panel-html {
    display: block;
  }

  .code-tabs pre {
    margin: 0;
    padding: 1rem;
    background: #111827;
    color: #f9fafb;
    overflow-x: auto;
  }
</style>

<div class="code-tabs">
  <input type="radio" name="tabset-example" id="tab-css" checked>
  <input type="radio" name="tabset-example" id="tab-html">

  <div class="tab-labels">
    <label for="tab-css">CSS</label>
    <label for="tab-html">HTML</label>
  </div>

  <div class="tab-content">
    <div class="tab-panel" id="panel-css">
      <pre>
        <code>
.card {
  border: 1px solid #d1d5db;
  border-radius: 0.5rem;
  padding: 1rem;
  background: #f9fafb;
}
        </code>
      </pre>
    </div>
    <div class="tab-panel" id="panel-html">
      <pre>
        <code>
&lt;div class="card"&gt;
  &lt;h3&gt;Sample Card&lt;/h3&gt;
  &lt;p&gt;This is HTML shown in a tab.&lt;/p&gt;
&lt;/div&gt;
        </code>
      </pre>
    </div>
  </div>
</div>
{{< /rawhtml >}}

To separate tab content, each tab needs three matching values:

- `input id` (example: `tab-css`)
- `label for` (example: `for="tab-css"`)
- panel id used by CSS selector (example: `#panel-css`)

Copy/paste source:

```go-html-template
{{</* rawhtml */>}}
<!-- Insert the HTML/CSS tab block here -->
{{</* /rawhtml */>}}
```

---

## Built-in Hugo Shortcodes

### Gist

{{< gist LanceMcCarthy 63815c41569ad877f24121be679d3638 >}}

Source:

```go-html-template
{{</* gist LanceMcCarthy 63815c41569ad877f24121be679d3638 */>}}
```

---

### YouTube privacy-enhanced embed

{{< youtube ZJthWmvUzzc >}}

Source:

```go-html-template
{{</* youtube ZJthWmvUzzc */>}}
```

---

### Vimeo simple embed

{{< vimeo_simple 48912912 >}}

Source:

```go-html-template
{{</* vimeo_simple 48912912 */>}}
```

---

## Custom Shortcodes In This Site

### Twitter simple shortcode

{{< twitter_simple 1085870671291310081 >}}

Source:

```go-html-template
{{</* twitter_simple 1085870671291310081 */>}}
```

---

### Bluesky simple shortcode

{{< bluesky_simple id="3ljf67zzyok2s" handle="lance.boston" >}}

Source:

```go-html-template
{{</* bluesky_simple id="3ljf67zzyok2s" handle="lance.boston" */>}}
```

---

### Raw HTML shortcode

Use this when you need custom HTML/CSS/JS in a post.

{{< rawhtml >}}
<div style="padding: 0.75rem; border: 1px dashed #6b7280; border-radius: 0.5rem;">
  This box is rendered through the rawhtml shortcode.
</div>
{{< /rawhtml >}}

Source:

```go-html-template
{{</* rawhtml */>}}
<div>Custom content</div>
{{</* /rawhtml */>}}
```

---

### Build timestamp shortcode

Build timestamp: {{< build_timestamp >}}

Source:

```go-html-template
{{</* build_timestamp */>}}
```

---

## Math (KaTeX)

Inline math: $E=mc^2$

Block math:

$$
\int_0^1 x^2\,dx = \frac{1}{3}
$$

This page enables math with front matter:

```yaml
math: true
```

---

## Authoring Notes

- Use `<!--more-->` to control the summary split.
- Use fenced code blocks for quick snippets.
- Use `highlight` shortcode when you need line numbers or line emphasis.
- Use `rawhtml` for custom widgets like tabbed code examples.
- Add new custom shortcodes under `layouts/shortcodes` to keep content clean.
