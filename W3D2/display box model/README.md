## CSS Display & Box Model Exercise

Download this [skeleton][skeleton]. 

[skeleton]: ./skeleton.zip

The purpose of this exercise is to learn the box model and the differences between the three primary display properties (block, inline, inline-block). The anchor tags from step 2 are naturally inline elements, which is why act oddly when provided padding. Spacing with margin and padding is vital to mastering CSS design. We also used the `inline-block` property to get practice positioning elements to create a desired layout.

Update box_model.css as follows to practice styling with different display and spacing properties.

1. Make our list elements in the nav menu into `inline-block` elements.
2. Give the links in those list elements a padding on all sides of 20px and change their display property to correct their inherent behavior.
3. Pick the correct display property to position the nav next to the logo.
4. Set our main content region by giving the body a width of 900px.
5. Use the classic centering trick `margin: 0 auto` to center the body.
6. Give the main section a 700px width and the aside a width of 180px.
7. Apply a display property to position the aside and section next to each other. Space them out with a 15px `margin-right` on the aside.
    - If you find your ingredients list aligned to the bottom use the developer tools to find and correct the styling.
8. Space out the list elements in the ingredients list with a top and bottom margin of 15px.
9. Space out the directions the same way.
10. Use the display property to put input elements on their own row. At this point it probably looks better to remove the "Cooking Expertise" and "Rating" labels.
11. Space out the `select` element with margin and assign widths to the `text` input, `select`, and `textarea` to finish up our form.

**Challenge:** There is a reason we only gave the aside a `margin-right` of 15px when it should have been 20px to constitute the full 900px of the body. To see what I am talking about, jump into the dev tools, check off the `margin-right` on the aside, and apply a `border-left 1px solid black` on the aside and a `border-left 1px solid black` on the section. Why is there still a space between the borders? Research why and test some corrections.

Compare your results to [this example](./solution/example.html) and [this stylesheet](./solution/assets/box_model.css).