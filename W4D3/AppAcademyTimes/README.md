# App Academy Times

Often when working as a front-end developer you'll be collaborating with a
designer. Most likely they will provide you with a sequence of screenshots and
specifications for you to convert into neat, maintainable HTML and CSS. Like so:

![aa-times](./solution/docs/screenshots/overall.png)

Download the [`skeleton`][skeleton] to get started on making an App Academy
clone of [The New York Times homepage](http://nytimes.com)!

[skeleton]:./skeleton.zip?raw=true

# Phase 0: Setup

- Navigate to the root directory and `bundle install`.
- Run `rails s` in one tab.
- In another tab, run `bundle exec guard -P livereload`.

The `guard -P livereload` implements an easy-to-setup workflow using "style injection." *Style injection is the ability to see styling changes immediately after authoring them without having to manually refresh your browser.* Here is a [blog post][guard-livereload] explaining the setup and how it works.

[guard-livereload]: https://mattbrictson.com/lightning-fast-sass-reloading-in-rails

## Stylesheets File Structure

Begin by familiarizing yourself with the stylesheets file structure, which will
house all of our CSS code for this project.

```
/app/assets/stylesheets
+-- base
|   +-- colors.scss
|   +-- fonts.scss
|   +-- grid.scss
|   +-- layout.scss
|   +-- reset.scss
+-- components
|   +-- _gear_dropdown.scss
|   +-- _main_content.scss
|   +-- _main_nav.scss
|   +-- _masthead.scss
|   +-- _search_modal.scss
|   +-- _sections_nav.scss
|   +-- _sections_sidebar.scss
+-- application.scss
```

Next take a look at the `application.scss` file:

```scss
// CSS Reset
@import "base/reset.scss";

// Core
@import "base/colors.scss";
@import "base/fonts.scss";
@import "base/layout.scss";

// Grid
@import "base/grid.scss";

// Components
@import "components/*";
```

This file uses SASS `import`s to define general styles that will apply to your
entire application and enforce the importing of these stylesheets in a
particular order.

Check out the `colors.scss` and `fonts.scss` files. They define SASS variables
for you to use throughout the project to style your app. Defining SASS variables
for an app's fonts and colors make changing any of them at any point more
maintainable and consistent. Use these given SASS variables when defining any
fonts or color values.

**N.B.**: We won't dive any deeper into SASS for this project but it does provide
a couple more cool features! Read about them [here][sass-features] if you're interested.

[sass-features]: https://github.com/rails/sass-rails#features

[rails-pipeline]: http://guides.rubyonrails.org/asset_pipeline.html#manifest-files-and-directives

## A Few Things Before You Start...

- The project is provided as a Rails application to give you practice working with the Rails Asset Pipeline and navigating file structure
- Sometimes the HTML will be given and you will need to style with CSS;
sometimes the styles will be given and you will need to define the HTML
structure; and sometimes you will be required to code both.
- The `docs` folder contains two directories: `screenshots` and `copy`. You'll use the images found in `screenshots` for your mockups as you are styling. `copy` contains the text you'll copy and paste for app's content.
- **Pro Tip**: Keep each mockup open and use it for reference as your styling a component.
- HTML is rendered using rails partials in the
`/app/views/static_pages/index.html.erb` file, allowing for the styling of
each component separately.
- The images you will use to style your app are located in the
`app/assets/images` folder.
- Javascript files are provided in the `app/assets/javascripts` folder.
- A script tag in the `application.html.erb` loads [Font Awesome's][font-awesome] icon classes. For our app's icons, we will being
using ones imported from Font Awesome's list of icons and applying them to
elements using classes.

[font-awesome]: http://fontawesome.io/icons/

# Phase 1: Reset

Always begin styling an app with a clean slate by "resetting" the user agent
stylesheet provided by the browser in your `stylesheets/base/reset.scss` file.

To speed things up, we provided some tag selectors to get you started.

- Be wise about which properties to inherit, and which to hard-code.
- Besides the regular, set the `box-sizing` property to inherit, to have all
elements behave the same, which is `content-box`, by default.
- Make all images `block` elements. Each image's widths should be equal to its
parent's width (`100%`) and its height should grow proportionally (`auto`).
Set `img` `width` and `height` properties accordingly.
- Remove the bullets from list items.
- Set the `cursor` to be the pointer hand on `button`s to make it obvious for users to click.
- Lastly, define clearfix.

# Phase 2: The Layout

Study the mockup to get an idea of the app's overall design.

- [Layout Mockup](./solution/docs/screenshots/main_content.jpg)

In order to write "cascading" style sheets, it is important that we pick out
common design elements and essential layout features. We will use the
`layout.scss` file when styling aspects common to our entire application.

Notice that all of app's content is styled in a defined blocked away from
the edges of the screen. Each component is also contained within regions with
clean margins. This is essential for user experience because it makes content
easier to read.

In `stylesheets/base/layout.scss`, style the `body`:
- Apply a width of `80%`.
- Center using `margin: 0 auto;`.
- Set the base font to `font-family: $serif`.
- Set `12px` as the default `font-size`.

---

# Phase 3: The Header

With our layout styling started we can now begin focusing on each component,
like the header. We can break the header down further into smaller components:
`main_nav` (with a `masthead` component containing our logo) and `sections_nav`
(with a `gear_dropdown` component).

- [Main Nav Mockup](./solution/docs/screenshots/main_nav.jpg)
- [Masthead Mockup](./solution/docs/screenshots/masthead.jpg)
- [Sections Nav Mockup](./solution/docs/screenshots/sections_nav.jpg)
- [Gear Dropdown Mockup](./solution/docs/screenshots/gear_dropdown.jpg)

We will style each one of these components in its own stylesheet. **N.B.:**
Breaking down stylesheets into each component is key to writing maintainable and
modular stylesheets.

## Main Nav

[Main Nav Mockup](./solution/docs/screenshots/main_nav.jpg)

Compare the provided HTML structure in `/views/shared/_main_nav.html.erb` to the
mockup. Notice we are missing the HTML for the right-side navigation. Let's add
it right now!

In `/views/shared/_main_nav.html.erb`:
- Add a `<nav>` with the class `"right-nav"`. Make sure it's contained within
the `"main-nav"` element.
- Add a `ul` element to your new `nav`. Make the buttons and gear icon list items of this unordered list.
- Add "Subscribe Now" and "Log In" buttons.
- Add the gear icon.
  - Use [this list of Font Awesome icon classes][font-awesome] to find the right
  gear image.
  - Use the "Sections" and "Search" buttons defined in the `left-nav` as guides.

A great use for the `layout.scss` stylesheet is to define styling shared by
multiple for elements. For example, the styling for the "Subscribe Now" button
and is identical to the styling for the "Log In" button. **N.B.**: Using the same
styling on buttons makes it easier for users to know where to click throughout
your app.

In `stylesheets/base/layout.scss`:
- Style the buttons to look like the buttons in the mockup.
- each css property has been provided as a comment

Now it is time to style in the `components/_main_nav.scss` stylesheet. We have provided the selectors for you. Here are some guidelines:

- Add `display: flex` the `"main-nav"` and use `justify-content` for horizontal spacing.
- Add `padding` for vertical spacing.
- Flex the unordered lists to keep their children horizontally aligned and use the `align-items` property vertically align them.
- Apply font and sizing properties to the list elements themselves.
- Use the `$lightest-gray` hover for the list elements without buttons.
- Style the necessary `margin` spacing between the texts and the icons.
- Use `font-size` to make the gear icon bigger.

## Masthead

[Masthead Mockup](./solution/docs/screenshots/masthead.jpg)

Open up `views/shared_masthead.html.erb`. Pull up the provided
`components/_masthead.scss` stylesheet next to it using split screen.

Copy and paste all of the text content from `docs/copy/masthead.txt` into the
html file. We will build the HTML structure around the content. Here are some
guidelines:

- Notice that the `.masthead` is a flex-parent which means it will be used as an
html container element and all of its immediate child elements will be
flex-children.
- Use `align-items` property to center the flex-children horizontally.
- The Rails Asset Pipeline takes care of precompiling our assets, so the correct file path for images in the `assets/images` folder is `assets/example_image.jpg`
- Only list elements should be present within unordered lists, but list elements may contain other elements such as anchor tags or buttons.

After some HTML structuring you will notice some problems with the styling.
Refer to the masthead mock up and edit the stylesheet to fix the following
things:

- Correct the positioning of the `.language-nav`.
- Remove the last border-right from `.masthead-links`.
- Make the first link in the `.language-nav` bold.
- Add application styling for anchor tags using the `layout.scss` file.

## Sections Nav

[Sections Nav Mockup](./solution/docs/screenshots/sections_nav.jpg)

Follow the patterns and coding patterns described above to style the Sections Nav component. Define its styles in `stylesheets/components/_sections_nav.scss` and HTML in `views/shared/_sections_nav.html.erb` file. Copy and paste the text content from `docs/copy/sections_nav.txt`. Once you have fully completed the Sections Nav bar **call over a TA to code review your Header**!

## Gear Dropdown

[Gear Dropdown Mockup](./solution/docs/screenshots/gear_dropdown.jpg)

Take a look at the `app/assets/javascripts/components/dropdown.js` file. Read
the comments to get an understanding how the script works.

- Add the necessary `id` attribute to the gear icon in the defined in `_main_nav.html.erb`
- Add the corresponding `.hidden` selector in `layout.scss`.

Open the `_gear_dropdown.html.erb` file where we have defined the HTML structure
for the dropdown. Notice the classes used to divide the different unordered
lists and the span elements for the subtitles.

- Render the partial as a child of the list element with the gear icon using `<%= render partial: 'shared/gear_dropdown' %>`
- Click the gear icon to test the toggling of the `hidden` class.

Style the dropdown in `_gear_dropdown.scss` according to the mockup:

- Style its position:
    + Position the icon relatively.
    + Position the dropdown absolutely and use `top` and `right` to adjust.
- Give the dropdown some background, padding, and a border.
- Using a defined px `width` for a dropdown is perfectly acceptable.
- Set the `z-index`. Remember the `z-index` property is used on positioned
elements to place them in front of or behind other elements with the largest
`z-index` being in front.
- Style the remaining fonts and margins being sure to use proper selectors.

For a final touch apply some `box-shadow` styling to the dropdown to give it a
bit more dimension. Box shadows are highly customizable with values for the
`x-offset`, `y-offset`, `blur-radius`, `spread-radius` and `color`. Here is an
example using `rgba` colors where the `Alpha` value makes the color super
transparent.

```css
box-shadow: -1px 4px 6px 1px rgba(0, 0, 0, 0.09);
```

---

# Phase 4: The Main Content

For the next phase we will add the latest App Academy Times news using a
flexible grid system. The `docs/copy` folder contains the content for each
section, which we will copy and paste. We will building the HTML structure
around the content, like we did for the Masthead. But first let's make sure we
have a flexible application by implementing a custom grid system.

## Custom Flexible Grid

Grids are much less complicated than they sound and are commonly used throughout
the web. Popular style frameworks like `bootstrap` by Twitter and `material` by
Google all use flexible grid systems. For App Academy Times, hand-roll a
simple grid just like you did in the [CSS Homework][css-grid-homework].

Define your grid's CSS in the `grid.scss` stylesheet. Make sure to include the
media query with a nice break point that maintains your design like `1000px`. So that it behaves like so:

![custom-grid](skeleton/docs/screenshots/grid.gif)

**N.B.**: Please don't just copy and paste any code. Writing out and debugging
CSS/HTML is the best way to learn!

[css-grid-homework]: https://github.com/appacademy/curriculum/blob/master/html-css/assets/custom_grid.css


## News Content

[News Content Mockup](./solution/docs/screenshots/main_content.jpg)

Copy and paste all the content from `docs/copy/main_content.txt` to
`views/shared/_main_content.html.erb`. Start by using your newly defined grid
classes with `section` elements to structure the content into flexible columns.

Use the following code snippet to embed the video content from YouTube:

```html
<iframe width="560" height="315" src="https://www.youtube.com/embed/ARe9FupzuOA" frameborder="0" allowfullscreen></iframe>
```

Once you have all of your content defined in flexible columns, follow the mockup style. Add additional HTML elements if necessary. Here are some guidelines:

+ Headers like "Opinion Pages" and "Cat Academy" are bold.
- `.hr-top` and `.hr-bottom` defined in `layout.scss` can be used to get the double lines that separate different content.
- We used a pseudo content `:after` and `content = ''` to create the blue square next to the comments link.
- Using `flex: 1` on the input element will force it to grow or shrink to take up all the space next to it's flex sibling Sign Up button
- Place the `new_office.jpg` image inside of a div with a class like `thumbnail`. This way you can reuse this `thumbnail` class with a styled `height` in px and then make all images `width: 100%` & `height: 100%`. Use `object-fit: cover` on all images inside `thumbnail` to assure the images cover the containing div correctly.
- Try to put as many of the application-wide selectors into the `layout.scss` file as possible. Selectors such as `h1, h2,  img, small, hr, .thumbnail` etc. make more sense in the layout file because we will likely reuse them.

**Get A TA to Review your page before continuing**

---

# Phase 5: The Sections Sidebar

Now try resizing the window. Notice that our flexible website breaks a bit
because we don't have flexible fonts. We will leave this discussion for another
time and instead use media queries to complete our responsive design. Notice how
the amount of links in the Sections Nav is too big for smaller screen sizes (ie.
mobile screens). Let's adjust for mobile!

[Mobile Mockup](./solution/docs/screenshots/mobile.png)

- Write a media query similar to the one used in the `grid.scss` to hide the sections nav at the same viewport width that the columns convert to `100%`.
- Write a similar media query to hide the Language Nav.
- Finally hide the "Subscribe" button, "Login" button and take the margin off the `.left-nav` in the `main_nav` styles. We added a bit of padding as well.

**N.B.** With just these few media queries and a flexible grid system we have a completely responsive website!

Now let's code a Sections Sidebar so that mobile users still have a way of
navigating all of the different App Academy Times sections. Style it according
to the mockup.

[Sections Sidebar Mockup](./solution/docs/screenshots/sections_sidebar.jpg)

- Copy and paste the HTML from the `sections_nav.html.erb` file into the `sections_sidebar.html.erb` file to use as a skeleton and guide.
- Take a look at the `app/assets/javascripts/components/sidebar.js` to see how the Sidebar functions.
- Add the `<%= render partial: 'shared/sections_sidebar' %>` to the `_main_nav.html.erb` as a child of the corresponding list element with `id="sections-sidebar-btn"`.
- In `_sections_sidebar.scss`, start with a selector to style the `opacity: 0` normally and `opacity: 1` when it has the additional `.expand` class.

**N.B.** We use opacity here instead of display because it is transition-able.

This is the effect we are going for:

<img src="skeleton/docs/screenshots/sidebar.gif" alt="sidebar example" width=" 400" height="500"/>

- Copy and paste the content from `docs/copy/sidebar_submenus.txt`.
- Add the remaining HTML to the `sections_sidebar` by nesting `ul` elements within the `li` elements that require an additional dropdown.

Create pure css dropdowns with the following example code:
```html
<section class="dropdown">
    <ul>
        <li>lorem ipsum</li>
        <li>Lorem ipsum dolor</li>
    </ul>
</section>
```

```css
.dropdown {
    position: relative;
}
.dropdown > ul {
    display: none;
    position: absolute;
    /* use top, left, right, bottom to position */
}
.dropdown:hover > ul {
    display: block;
}
```

Use pseudo element [css triangles][css-triangles] on top of triangles to create the arrows for the menu items as well as the submenu dropdown triangles. This code could apply right arrows to the list items in the dropdown HTML from above:

```css
.dropdown li {
    position: relative;
}
.dropdown li:after,
.dropdown li:before {
    content: "";
    position: absolute;
    right: 0;
    top: 25%;
    border-left: 5px solid gray;
    border-top: 5px solid transparent;
    border-bottom: 5px solid transparent;
    width: 0;
    height: 0;
}
.dropdown li:after {
    right: 2px;
    border-left: 5px solid white;
    z-index: 1;
}
```

[css-triangles]:[https://css-tricks.com/snippets/css/css-triangle/]

---

# Phase 6: Search Modal

[Search Modal Mockup](./solution/docs/screenshots/search_modal.jpg)

Modals are distinct from dropdowns because they appear to float independently
over the application. A common characteristic of a modal is also that the app
beneath becomes more opaque and clicking away from the modal will close it.

Take a look at the `search-modal.png` screenshot to get a better idea of what
this is supposed to look like. Use the `search-modal.js` file to get the id
necesary for the search button, modal and overlay.

Create the HTML in the `_search_modal.html.erb` file and style in
`_search_modal.scss`. We created a `<section id="overlay" class="overlay
hidden"></section>` at the bottom of the `main_content` section.

Here is a trick to making content take up the full width of the viewport even
when inside of a smaller container by using viewport units (`vw = viewport
width, vh = viewport height`).

```css
  position: absolute;
  width: 100vw;
  left: calc(-50vw + 50%);
```

- We used this trick both to make the full width search modal and overlay
- `height: 100%` is not transitionable...use `max-height` instead
- Inset box shadows with `box-shadow: inset 2px 3px 3px rgba(0,0,0,0.07);`

Before continuing **Call over a TA for review**.

# Bonus: A Fixed Header

Use what you have learned to create a Fixed Header. When scrolling past the
`sections_nav` a `fixed_sections_nav` should appear. Use the
[NYTimes](http://nytimes.com) as an example.
