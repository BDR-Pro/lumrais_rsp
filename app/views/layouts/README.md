# Base Template with Tailwind CSS

This directory contains a base template (`base.html.erb`) that can be used as a foundation for other views in the application. The template includes Tailwind CSS for styling and provides a responsive layout with header, footer, and content sections.

## Features

- Responsive design with mobile menu
- Tailwind CSS integration via CDN
- Custom color scheme
- Flash message display
- SEO-friendly meta tags
- Social media links
- Mobile-friendly navigation

## How to Use

To create a new page that inherits from the base template, follow these steps:

1. Create a new view file (e.g., `your_page.html.erb`)
2. Use `content_for` blocks to define content for specific sections
3. Render the base template at the end of your view

### Available Content Blocks

- `:title` - Sets the page title
- `:meta_description` - Sets the meta description
- `:meta_keywords` - Sets the meta keywords
- `:head` - Adds additional content to the head section
- `:content` - The main content of the page
- `:scripts` - Adds additional scripts at the end of the body

### Example

```erb
<% content_for :title, "Your Page Title" %>
<% content_for :meta_description, "Your page description" %>

<% content_for :head do %>
  <!-- Additional head content specific to this page -->
  <link rel="stylesheet" href="your-stylesheet.css">
<% end %>

<% content_for :content do %>
  <div class="bg-white p-6 rounded-lg shadow-md">
    <h1 class="text-3xl font-bold text-primary mb-4">Your Page</h1>
    <p class="text-gray-700">Your content goes here.</p>
  </div>
<% end %>

<% content_for :scripts do %>
  <!-- Additional scripts specific to this page -->
  <script src="your-script.js"></script>
<% end %>

<%= render template: 'layouts/base' %>
```

## Tailwind CSS

The base template includes Tailwind CSS via CDN. It also includes a custom configuration that extends the default Tailwind theme with custom colors and fonts.

### Custom Colors

- `primary`: #3B82F6 (Blue)
- `secondary`: #10B981 (Green)
- `accent`: #8B5CF6 (Purple)
- `danger`: #EF4444 (Red)
- `warning`: #F59E0B (Amber)
- `info`: #3B82F6 (Blue)
- `success`: #10B981 (Green)
- `dark`: #1F2937 (Gray 800)
- `light`: #F9FAFB (Gray 50)

## Example Page

An example page has been created to demonstrate how to use the base template. You can view it at `/example` in your application.

